import 'dart:async';
import 'dart:io';

import 'package:blitz_api_client/blitz_api_client.dart' as client;

import 'docker/containers/cashu_mint.dart';
import 'docker/containers/fake_ln.dart';
import 'docker/containers/lnbits.dart';
import 'docker/docker.dart';
import 'constants.dart';
import 'models.dart';
import 'utils.dart';

enum NetworkState {
  down,
  cleanup,
  startingUp,
  up,
  shuttingDown,
  checking,
  error
}

class NetworkStateMessage {
  final NetworkState state;
  final String? message;

  NetworkStateMessage(this.state, [this.message]);

  NetworkStateMessage.checking() : this(NetworkState.checking);
}

class NetworkManager {
  bool _isInitialized = false;
  final Map<String, DockerContainer> _containerMap = {};

  static final NetworkManager _instance = NetworkManager._internal();

  factory NetworkManager() => _instance;

  final StreamController<NetworkStateMessage> _netStateController =
      StreamController<NetworkStateMessage>();
  late final Stream<NetworkStateMessage> _netStateStream;

  final StreamController<DockerContainer> _containerDeletedController =
      StreamController<DockerContainer>();
  late final Stream<DockerContainer> _containerDeletedStream;

  NetworkManager._internal();

  Future<void> init() async {
    if (_isInitialized) {
      logMessage("NetworkManager already initialized");
      return;
    }
    _isInitialized = true;

    _netStateStream = _netStateController.stream.asBroadcastStream();

    _containerDeletedStream =
        _containerDeletedController.stream.asBroadcastStream();

    await _checkIfRunning();
  }

  bool get initialized => _isInitialized;

  Stream<NetworkStateMessage> get netStateStream => _netStateStream;

  Stream<DockerContainer> get containerDeletedStream => _containerDeletedStream;

  Map<String, DockerContainer> get nodeMap => _containerMap;
  List<DockerContainer> get containers =>
      _containerMap.values.toList(growable: false);

  LnNode? nodeByPubKey(String key) => _containerMap.values
      .whereType<LnNode>()
      .firstWhere((node) => node.pubKey == key);

  List<LnNode> get lnNodes => _containerMap.values.whereType<LnNode>().toList();

  /// Starts the network if down
  ///
  /// If [exposeDataDirToHost] is true, the data directory will not be made
  /// public. ⚠️ This will ask for root password!
  ///
  /// If [autoFundNodes] is true, the nodes will be funded with 15 rBTC each
  Future<void> start({
    bool exposeDataDirToHost = false,
    bool autoFundNodes = true,
  }) async {
    _sendMessage(NetworkState.startingUp);

    await prepareDataDir(dockerDataDir);
    await _ensureDockerNetwork();
  }

  Future<void> stop() async {
    final args = ["compose", "-p", projectName, "down", "--volumes"];
    try {
      _sendMessage(NetworkState.shuttingDown);
      final output = await dockerCmd(args, dockerDataDir);

      await cleanDataDirectories(dockerDataDir);

      _sendMessage(NetworkState.down);
      logMessage(output.toString());
    } catch (e) {
      logMessage(e.toString());
    }
  }

  Future<void> refresh() async {
    await _checkIfRunning();
  }

  Future<void> _checkIfRunning() async {
    _sendMessage(NetworkState.checking);

    final containers = await getRunningContainerNames(projectName);

    if (containers.isEmpty) {
      _sendMessage(NetworkState.down);
      return;
    }

    for (final ContainerData c in containers) {
      if (c.image.contains('bitcoin-core')) {
        final container =
            await BitcoinCoreContainer.fromRunningContainer(c, null);
        _containerMap[c.internalId] = container;

        continue;
      } else if (c.image.contains('lnd')) {
        final container = await LndContainer.fromRunningContainer(c, null);
        _containerMap[c.internalId] = container;
      }
    }
  }

  _sendMessage(NetworkState state, [String? message]) =>
      _netStateController.add(NetworkStateMessage(state, message));

  recreate() async {
    final containers = await getRunningContainerNames();
    _sendMessage(NetworkState.cleanup, "Removing containers $containers");
    for (final container in containers) {
      final res = await Process.run('docker', ['rm', '-f', container.dockerId]);
      logMessage(res.stdout.toString());
    }

    await Future.delayed(const Duration(seconds: 15));
  }

  Future<void> fundNodes({
    bool autoMine = true,
    double amountInBtc = 15.0,
  }) async {}

  /// Wait until all nodes have all funds confirmed
  Future<int> waitOnchainConfirmed({int maxIterations = 30}) async {
    return 0;
  }

  Future<void> compareAndWaitForFunds({
    required WalletBalances before,
    int maxIterations = 25,
  }) async {}

  Future<void> applyNetwork([String fileName = 'net-1.json']) async {}

  Future<int> sweepAllChannels({bool autoMine = false}) async {
    return 0;
  }

  Future<String> sweepOnchain({
    List<LnNode> nodes = const [],
    String destAddress = "",
    autoMine = false,
  }) async {
    return '';
  }

  Future<WalletBalances> getWalletBalances() async {
    final futures = <Future<client.WalletBalance>>[];
    for (final n in lnNodes) {
      futures.add(n.walletBalance());
    }

    final b = await Future.wait<client.WalletBalance>(futures);

    final balances = <LnNode, client.WalletBalance>{};
    for (var i = 0; i < b.length; i++) {
      balances[lnNodes[i]] = b[i];
    }

    return WalletBalances(balances);
  }

  Future<void> _ensureDockerNetwork() async {
    final networkArgs = [
      'network',
      'create',
      '--driver',
      'bridge',
      projectNetwork
    ];
    await dockerCmd(networkArgs, '.');
  }

  DockerContainer createContainer(
    ContainerType type, {
    ContainerOptions? opts,
  }) {
    _checkRequirements(type);

    final DockerContainer container = switch (type) {
      ContainerType.bitcoinCore => BitcoinCoreContainer(),
      ContainerType.blitzApi => _createBlitzApiContainer(opts),
      ContainerType.cashuMint => CashuMintContainer(),
      ContainerType.cln => CLNContainer.defaultOptions(),
      ContainerType.fakeLn => FakeLnContainer.defaultOptions(),
      ContainerType.lnbits => LNbitsContainer(),
      ContainerType.lnd => _createLndContainer(
          opts == null ? null : opts as LndOptions,
        ),
      ContainerType.redis => RedisContainer(),
    };

    _containerMap[container.internalId] = container;

    return container;
  }

  Future<void> startContainer(String id) async {
    final container = _containerMap[id];
    if (container == null) throw StateError('Container not found');

    await _ensureDockerNetwork();

    try {
      await container.start();
    } on DockerException catch (e) {
      logMessage(e.message);
    }
  }

  Future<void> stopContainer(String id) async {
    final container = _containerMap[id];
    if (container == null) throw StateError('Container not found');

    await container.stop();
  }

  Future<bool> deleteContainer(String id) async {
    final container = _containerMap[id];
    if (container == null) throw StateError('Container not found');

    try {
      await container.delete();
      _containerMap.remove(id);
    } on DockerException catch (e) {
      print(e.message);
    }

    _containerDeletedController.add(container);

    return true;
  }

  /// Updating container options results in a new container
  /// object being instantiated with the same internal ID.
  Future<void> updateContainerOptions(
    String id,
    ContainerOptions opts,
  ) async {
    final container = _containerMap[id];
    if (container == null) throw StateError('Container not found');

    final DockerContainer newContainer = switch (container.type) {
      ContainerType.bitcoinCore =>
        BitcoinCoreContainer(opts: opts as BitcoinCoreOptions, internalId: id),
      ContainerType.blitzApi =>
        BlitzApiContainer(opts: opts as BlitzApiOptions),
      ContainerType.cashuMint =>
        CashuMintContainer(opts: opts as CashuMintOptions),
      ContainerType.cln => CLNContainer(opts: opts as CLNOptions),
      ContainerType.fakeLn => FakeLnContainer(opts: opts as FakeLnOptions),
      ContainerType.lnbits => LNbitsContainer(opts: opts as LNbitsOptions),
      ContainerType.lnd => LndContainer(lndOpts: opts as LndOptions),
      ContainerType.redis => RedisContainer(opts: opts as RedisOptions),
    };

    try {
      await container.delete();
    } on DockerException catch (e) {
      print(e.message);
    }

    _containerMap[id] = newContainer;
  }

  void _checkRequirements(ContainerType type) {
    final unmetReq = <ContainerType>[];

    final List<ContainerType> requirements = switch (type) {
      ContainerType.blitzApi => BlitzApiContainer.requirements,
      _ => const []
    };

    if (requirements.isEmpty) return;

    for (var req in requirements) {
      if (findFirstOf(req) == null) unmetReq.add(req);
    }

    if (unmetReq.isNotEmpty) {
      throw RequirementsNotMetError.fromContainerType(
        ContainerType.blitzApi,
        unmetReq,
      );
    }
  }

  T? findContainerById<T extends DockerContainer>(String internalId) {
    for (var container in containers) {
      if (container.internalId == internalId && container is T) {
        return container;
      }
    }

    return null;
  }

  T? findFirstOf<T>([ContainerType? type]) {
    if (type != null) {
      for (var container in containers) {
        if (container.type == type) {
          return container as dynamic;
        }
      }

      return null;
    }

    if (T is! DockerContainer) {
      throw ArgumentError.value(T);
    }

    for (var container in containers) {
      if (container is T) return container as T;
    }

    return null;
  }

  BlitzApiContainer _createBlitzApiContainer(ContainerOptions? opts) {
    if (opts != null && opts is! BlitzApiOptions) {
      throw ArgumentError.value(opts);
    }

    return BlitzApiContainer(
      opts: opts == null ? BlitzApiOptions.empty() : opts as BlitzApiOptions,
    );
  }

  LndContainer _createLndContainer([LndOptions? opts]) {
    String btccId = opts == null ? '' : opts.btccContainerId;
    LndOptions lndOptions = opts ?? LndOptions();

    if (btccId.isEmpty) {
      final btcc = findFirstOf<BitcoinCoreContainer>();
      if (btcc == null) {
        throw StateError('LND needs a Bitcoin Core container to run.');
      }

      lndOptions = lndOptions.copyWith(btccContainerId: btcc.internalId);
    }

    return LndContainer(lndOpts: lndOptions);
  }
}
