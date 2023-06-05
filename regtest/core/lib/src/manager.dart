import 'dart:async';
import 'dart:io';

import 'package:blitz_api_client/blitz_api_client.dart' as client;

import 'docker/containers/cashu_mint.dart';
import 'docker/containers/fake_ln.dart';
import 'docker/containers/lnbits.dart';
import 'docker/docker.dart';
import 'constants.dart';
import 'docker/exceptions.dart';
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

  bool _bootstrapped = false;

  BitcoinCoreContainer? _btcc;

  factory NetworkManager() => _instance;

  final StreamController<NetworkStateMessage> _controller =
      StreamController<NetworkStateMessage>();

  NetworkManager._internal();

  Future<void> init() async {
    if (_isInitialized) {
      logMessage("NetworkManager already initialized");
      return;
    }
    _isInitialized = true;
    await _checkIfRunning();
  }

  bool get initialized => _isInitialized;

  Stream<NetworkStateMessage> get stream =>
      _controller.stream.asBroadcastStream();

  Map<String, DockerContainer> get nodeMap => _containerMap;
  List<DockerContainer> get containers =>
      _containerMap.values.toList(growable: false);

  BitcoinCoreContainer get btcc {
    final f = _btcc;
    if (f == null) {
      throw NodeNotRunningError.fromContainerType(ContainerType.bitcoinCore);
    }

    return f;
  }

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
        _containerMap[c.internalId] =
            await BitcoinCoreContainer.fromRunningContainer(c);

        continue;
      }
    }
  }

  _sendMessage(NetworkState state, [String? message]) =>
      _controller.add(NetworkStateMessage(state, message));

  recreate() async {
    final containers = await getRunningContainerNames();
    _sendMessage(NetworkState.cleanup, "Removing containers $containers");
    for (final container in containers) {
      final res = await Process.run('docker', ['rm', '-f', container.dockerId]);
      logMessage(res.stdout.toString());
    }

    await Future.delayed(const Duration(seconds: 15));
  }

  _bootstrapNodeData() async {
    if (_bootstrapped) return;
    logMessage("Bootstrapping node data");

    _bootstrapped = true;
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

  // Future<String> getNewBitcoinCoreAddress() async => await _btcc.newAddress();

  Future<void> _ensureDockerNetwork() async {
    final networkArgs = [
      'network',
      'create',
      '--driver',
      'bridge',
      projectNetwork
    ];
    await dockerCmd(networkArgs, dockerDataDir);
  }

  DockerContainer createContainer(
    ContainerType type, {
    ContainerOptions? opts,
  }) {
    final DockerContainer container = switch (type) {
      ContainerType.bitcoinCore => BitcoinCoreContainer(),
      ContainerType.blitzAPI => _buildBlitzAPIContainer(opts),
      ContainerType.cashuMint => CashuMintContainer(),
      ContainerType.cln => CLNContainer.defaultOptions(),
      ContainerType.fakeLn => FakeLnContainer.defaultOptions(),
      ContainerType.lnbits => LNbitsContainer(),
      ContainerType.lnd => LNDContainer.defaultOptions(),
      ContainerType.redis => RedisContainer(),
    };

    _containerMap[container.internalId] = container;

    return container;
  }

  Future<void> startContainer(String id) async {
    final container = _containerMap[id];
    if (container == null) throw StateError('Container not found');

    await prepareDataDir(container.dataPath);
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

  Future<void> updateContainerOptions(
    String id,
    ContainerOptions opts,
  ) async {
    final container = _containerMap[id];
    if (container == null) throw StateError('Container not found');

    final DockerContainer newContainer = switch (container.type) {
      ContainerType.bitcoinCore => BitcoinCoreContainer(
          opts: opts as BitcoinCoreOptions,
          internalId: id,
        ),
      ContainerType.blitzAPI => BlitzAPIContainer(
          opts: opts as BlitzAPIOptions,
        ),
      ContainerType.cashuMint => CashuMintContainer(
          opts: opts as CashuMintOptions,
        ),
      ContainerType.cln => CLNContainer(opts: opts as CLNOptions),
      ContainerType.fakeLn => FakeLnContainer(opts: opts as FakeLnOptions),
      ContainerType.lnbits => LNbitsContainer(opts: opts as LNbitsOptions),
      ContainerType.lnd => LNDContainer(opts: opts as LNDOptions),
      ContainerType.redis => RedisContainer(opts: opts as RedisOptions),
    };

    await container.delete();
    _containerMap[id] = newContainer;
  }

  BlitzAPIContainer _buildBlitzAPIContainer(ContainerOptions? opts) {
    if (opts != null && opts is BlitzAPIOptions) {
      throw ArgumentError.value(opts);
    }

    return BlitzAPIContainer(
      opts: opts == null ? BlitzAPIOptions.empty() : opts as BlitzAPIOptions,
    );
  }
}
