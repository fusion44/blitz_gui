import 'dart:async';
import 'dart:io';

import 'package:blitz_api_client/blitz_api_client.dart' as client;
import 'package:common/common.dart';
import 'package:regtest_core/src/port_manager.dart';

import 'docker/containers/cashu_mint.dart';
import 'docker/containers/fake_ln.dart';
import 'docker/containers/lnbits.dart';
import 'docker/docker.dart';
import 'constants.dart';
import 'models.dart';
import 'utils.dart';

enum NetworkStatus {
  down,
  cleanup,
  startingUp,
  up,
  shuttingDown,
  checking,
  error
}

class NetworkStateMessage {
  final NetworkStatus status;
  final String? message;

  NetworkStateMessage(this.status, [this.message]);

  NetworkStateMessage.checking() : this(NetworkStatus.checking);
}

class NetworkManager {
  bool _isInitialized = false;
  final Map<String, BlitzApiContainer> _complementaryCache = {};
  final Map<String, DockerContainer> _containerMap = {};
  final Map<ContainerType, int> _containerIds = {
    ContainerType.cln: 0,
    ContainerType.lnd: 0
  };

  static final NetworkManager _instance = NetworkManager._internal();

  String _gatewayIP = '';
  String get gatewayIP => _gatewayIP;

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

  LnContainer? nodeByPubKey(String key) => _containerMap.values
      .whereType<LnContainer>()
      .firstWhere((node) => node.pubKey == key);

  List<LnContainer> get lnNodes =>
      _containerMap.values.whereType<LnContainer>().toList();

  /// Get all nodes that are controllable by the user
  List<DockerContainer> get userNodes => _containerMap.values
      .where((element) =>
          element.type != ContainerType.redis &&
          element.type != ContainerType.blitzApi)
      .toList();

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
    _sendMessage(NetworkStatus.startingUp);

    await prepareDataDir(dockerDataDir);
    await _ensureDockerNetwork();
  }

  Future<void> stop() async {
    final args = ["compose", "-p", projectName, "down", "--volumes"];
    try {
      _sendMessage(NetworkStatus.shuttingDown);
      final output = await dockerCmd(args, dockerDataDir);

      await cleanDataDirectories(dockerDataDir);

      _sendMessage(NetworkStatus.down);
      logMessage(output.toString());
    } catch (e) {
      logMessage(e.toString());
    }
  }

  Future<void> refresh() async {
    await _checkIfRunning();
  }

  Future<void> _checkIfRunning() async {
    _sendMessage(NetworkStatus.checking);

    final containers = await getRunningContainerNames(projectName);

    if (containers.isEmpty) {
      _sendMessage(NetworkStatus.down);
      return;
    }

    for (final ContainerData c in containers) {
      DockerContainer? container;
      BlitzApiContainer? bapi;
      final bapiData = c.bapi;
      if (bapiData != null) {
        bapi = await BlitzApiContainer.fromRunningContainer(bapiData, null);
        _containerMap[c.bapi!.internalId] = bapi;
      }

      if (c.image.contains('bitcoin-core')) {
        container = await BitcoinCoreContainer.fromRunningContainer(c, null);
      } else if (c.image.contains('boltz/c-lightning')) {
        if (bapi == null) {
          throw StateError('Blitz API container can\'t be null');
        }
        container = await ClnContainer.fromRunningContainer(c, null, bapi);
      } else if (c.image.contains('lnd')) {
        if (bapi == null) {
          throw StateError('Blitz API container can\'t be null');
        }
        container = await LndContainer.fromRunningContainer(c, null, bapi);
      } else if (c.image.contains('redis')) {
        container = await RedisContainer.fromRunningContainer(c, null);
      } else if (c.image.contains('blitz_api')) {
        continue;
      }

      if (container == null) {
        logMessage('Unknown container type: ${c.image}');
        continue;
      }

      _containerMap[c.internalId] = container;
    }

    _sendMessage(NetworkStatus.up);
  }

  _sendMessage(NetworkStatus state, [String? message]) =>
      _netStateController.add(NetworkStateMessage(state, message));

  recreate() async {
    final containers = await getRunningContainerNames();
    _sendMessage(NetworkStatus.cleanup, "Removing containers $containers");
    for (final container in containers) {
      final res = await Process.run('docker', ['rm', '-f', container.dockerId]);
      logMessage(res.stdout.toString());
    }

    await Future.delayed(const Duration(seconds: 15));
  }

  Future<void> fundNodes({
    bool autoMine = false,
    Amount amount = const Amount(sat: 1500000000),
  }) async {
    final btcc = findFirstOf<BitcoinCoreContainer>();
    if (btcc == null) {
      throw StateError('BitcoinCore container not found');
    }

    for (final node in lnNodes) {
      final bapiContainer = findComplementaryNode(node);
      if (bapiContainer == null) continue;

      try {
        final addr = await bapiContainer.newAddress();
        await btcc.sendFunds(addr, amount.inBitcoin);
      } catch (e) {
        print(e);
      }
    }
  }

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
    List<LnContainer> nodes = const [],
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

    final balances = <LnContainer, client.WalletBalance>{};
    for (var i = 0; i < b.length; i++) {
      balances[lnNodes[i]] = b[i];
    }

    return WalletBalances(balances);
  }

  Future<void> _ensureDockerNetwork() async {
    if (_gatewayIP.isNotEmpty) return;

    final networkArgs = [
      'network',
      'create',
      '--driver',
      'bridge',
      projectNetwork
    ];
    await dockerCmd(networkArgs, '.');

    final res = await getDockerNetworkGateway();
    res.match(
      () => throw StateError('Unable to get Gateway IP'),
      (t) => _gatewayIP = t,
    );
    print('Found gateway $_gatewayIP');
  }

  Future<DockerContainer> createContainer(
    ContainerType type, {
    ContainerOptions? opts,
  }) async {
    _checkRequirements(type);

    final DockerContainer container = switch (type) {
      ContainerType.bitcoinCore => BitcoinCoreContainer(BitcoinCoreOptions()),
      ContainerType.blitzApi => _createBlitzApiContainer(opts),
      ContainerType.cashuMint => CashuMintContainer(CashuMintOptions()),
      ContainerType.cln => await _createClnContainer(opts),
      ContainerType.fakeLn => FakeLnContainer.defaultOptions(),
      ContainerType.lnbits => LNbitsContainer.defaultOptions(),
      ContainerType.lnd => await _createLndContainer(
          opts == null ? null : opts as LndOptions,
        ),
      ContainerType.redis => RedisContainer.defaultOptions(),
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
      if (e.logs.isNotEmpty) {
        return logMessage('message: ${e.message},\nlogs: ${e.logs}');
      }

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
        BitcoinCoreContainer(opts as BitcoinCoreOptions, internalId: id),
      ContainerType.blitzApi => BlitzApiContainer(opts as BlitzApiOptions),
      ContainerType.cashuMint => CashuMintContainer(opts as CashuMintOptions),
      ContainerType.cln => ClnContainer(opts as ClnOptions),
      ContainerType.fakeLn => FakeLnContainer(opts as FakeLnOptions),
      ContainerType.lnbits => LNbitsContainer(opts as LNbitsOptions),
      ContainerType.lnd => LndContainer(opts as LndOptions),
      ContainerType.redis => RedisContainer(opts as RedisOptions),
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

  T? findFirstOf<T extends DockerContainer>([ContainerType? type]) {
    if (type != null) {
      for (var container in containers) {
        if (container.type == type) {
          return container as dynamic;
        }
      }

      return null;
    }

    for (var container in containers) {
      if (container is T) return container;
    }

    return null;
  }

  List<T> findAllOf<T extends DockerContainer>([ContainerType? type]) {
    final list = <T>[];

    if (type != null) {
      for (var container in containers) {
        if (container.type == type) {
          list.add(container as T);
        }
      }

      return list;
    }

    for (var container in containers) {
      if (container is T) list.add(container);
    }

    return list;
  }

  BlitzApiContainer? findComplementaryNode(DockerContainer main) {
    if (_complementaryCache.keys.contains(main.internalId)) {
      return _complementaryCache[main.internalId];
    }

    for (final node in nodeMap.values) {
      if (node.type != ContainerType.blitzApi) continue;
      if (node.containerName.contains(main.internalId)) {
        return node as BlitzApiContainer;
      }
    }

    return null;
  }

  BlitzApiContainer _createBlitzApiContainer(ContainerOptions? opts) {
    if (opts != null && opts is! BlitzApiOptions) {
      throw ArgumentError.value(opts);
    }

    return BlitzApiContainer(
      opts == null ? BlitzApiOptions.empty() : opts as BlitzApiOptions,
    );
  }

  Future<LndContainer> _createLndContainer([LndOptions? opts]) async {
    String btccId = opts == null ? '' : opts.btccContainerId;
    LndOptions lndOptions = opts ?? LndOptions();

    if (btccId.isEmpty) {
      final btcc = findFirstOf<BitcoinCoreContainer>();
      if (btcc == null) {
        throw StateError('LND needs a Bitcoin Core container to run.');
      }

      lndOptions = lndOptions.copyWith(btccContainerId: btcc.internalId);
    }

    var currId = _containerIds[ContainerType.lnd] ??= 0;

    lndOptions = lndOptions.copyWith(
      gRPCPort: await PortManager().nextUnusedPort(LndContainer.grpcPortRange),
      restPort: await PortManager().nextUnusedPort(LndContainer.restPortRange),
    );

    _containerIds[ContainerType.lnd] = ++currId;

    return LndContainer(lndOptions);
  }

  Future<ClnContainer> _createClnContainer(ContainerOptions? baseOpts) async {
    ClnOptions opts = ClnOptions();
    if (baseOpts != null && baseOpts is ClnOptions) {
      opts = baseOpts;
    }

    String btccId = opts.btccContainerId;

    if (btccId.isEmpty) {
      final btcc = findFirstOf<BitcoinCoreContainer>();
      if (btcc == null) {
        throw StateError('CLN needs a Bitcoin Core container to run.');
      }

      opts = opts.copyWith(btccContainerId: btcc.internalId);
    }

    var currId = _containerIds[ContainerType.cln] ??= 0;

    opts = opts.copyWith(
      gRPCPort: await PortManager().nextUnusedPort(ClnContainer.grpcPortRange),
    );

    _containerIds[ContainerType.cln] = ++currId;

    return ClnContainer(opts);
  }
}
