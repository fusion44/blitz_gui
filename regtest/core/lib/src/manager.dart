import 'dart:async';
import 'dart:io';

import 'package:blitz_api_client/blitz_api_client.dart' as client;

import 'docker/containers/cashu_mint.dart';
import 'docker/containers/lnbits.dart';
import 'docker/docker.dart';
import 'constants.dart';
import 'docker/exceptions.dart';
import 'model_extensions.dart';
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
  final Map<ContainerType, DockerContainer> _containerMap = {};

  static final NetworkManager _instance = NetworkManager._internal();

  bool _bootstrapped = false;

  late RedisContainer _redisContainer;
  late BitcoinCoreContainer _btcc;

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

  Map<ContainerType, DockerContainer> get nodeMap => _containerMap;
  List<DockerContainer> get containers => _containerMap.values.toList();
  BitcoinCoreContainer get btcc => _btcc;

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

    _redisContainer = RedisContainer();
    await _redisContainer.start();

    _btcc = BitcoinCoreContainer();
    await _btcc.start();

    final lnd = LNDContainer(
      alias: 'lnd1',
      id: 0,
      btcContainerName: _btcc.containerName,
    );

    try {
      await lnd.start();
    } on DockerException catch (e) {
      print(e.message);
    }

    final cln = CLNContainer(
      alias: 'cln1',
      id: 0,
      btcContainerName: _btcc.containerName,
    );

    lnd.logStream.listen(
      (event) {
        print('CLN $event');
      },
      onError: (line) {
        print('CLN error: $line');
      },
      onDone: () {
        print('CLN done');
      },
    );
    try {
      await cln.start();
    } on DockerException catch (e) {
      print(e.message);
    }

    logMessage("Ensuring Bitcoin daemon wallet exists");
    await _btcc.ensureWalletLoaded();
    // Consensus mechanism requires 100 blocks to be mined
    // before reward can be spent
    logMessage("Mining 110 blocks to get and unlock block reward");
    await btcc.mineBlocks(110);

    for (var i = 25; i > 0; i--) {
      logMessage("Sleeping ${i * 5} s");
      await Future.delayed(const Duration(seconds: 5));
    }

    await _bootstrapNodeData();

    if (autoFundNodes) {
      await fundNodes();
    }

    logMessage("Sleeping 10 s");
    await Future.delayed(const Duration(seconds: 10));

    await btcc.mineBlocks(3);
    await _bootstrapNodeData();
    if (exposeDataDirToHost) {
      await makeDataDirsPublic(dockerDataDir);
    }

    await Future.delayed(const Duration(seconds: 10));
    _sendMessage(NetworkState.up);
    // logMessage(output);
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

    final containers = await getRunningContainerNames();

    if (containers.isEmpty) {
      _sendMessage(NetworkState.down);
      return;
    }

    if (containers.length < currentNumContainers) {
      _sendMessage(
        NetworkState.error,
        "Not enough containers running: ${containers.length}/$currentNumContainers",
      );
      return;
    }

    if (containers.length == currentNumContainers) {
      await _bootstrapNodeData();
      _sendMessage(NetworkState.up);
      return;
    }

    if (containers.length > currentNumContainers) {
      _sendMessage(
        NetworkState.error,
        "Unexpected number of containers running: ${containers.length}/$currentNumContainers",
      );
      return;
    }
  }

  _sendMessage(NetworkState state, [String? message]) =>
      _controller.add(NetworkStateMessage(state, message));

  recreate() async {
    final containers = await getRunningContainerNames();
    _sendMessage(NetworkState.cleanup, "Removing containers $containers");
    for (final container in containers) {
      final res = await Process.run('docker', ['rm', '-f', container]);
      logMessage(res.stdout.toString());
    }

    await Future.delayed(const Duration(seconds: 15));
  }

  _bootstrapNodeData() async {
    if (_bootstrapped) return;
    logMessage("Bootstrapping node data");

    // TODO: fixme
    print('TODO: FIXME!!!');
    // final futures = <Future>[];
    // for (final id in NodeId.values) {
    //   if (id != NodeId.empty) {
    //     final n = LnNode(id);
    //     _nodeMap["id"] = n;
    //     futures.add(n.bootstrap());
    //   }
    // }

    // await Future.wait(futures);
    _bootstrapped = true;
  }

  Future<void> fundNodes({
    bool autoMine = true,
    double amountInBtc = 15.0,
  }) async {
    logMessage("Funding nodes");

    await _btcc.ensureWalletLoaded();

    final futures = <Future>[];
    for (final n in lnNodes) {
      try {
        futures.add(n.newAddress());
      } catch (e) {
        logMessage("Can't fund Nodes: ${e.toString()}");
        return;
      }
    }

    // get balances before funding
    var before = await getWalletBalances();

    final addresses = await Future.wait(futures);
    for (var a in addresses) {
      final res = await _btcc.sendFunds(a, amountInBtc);
      logMessage(res);
    }

    if (autoMine) {
      try {
        await compareAndWaitForFunds(before: before);
      } catch (e) {
        logMessage("Unable to fund Nodes: ${e.toString()}");
        return;
      }
    }

    logMessage("Funding done");
  }

  /// Wait until all nodes have all funds confirmed
  Future<int> waitOnchainConfirmed({int maxIterations = 30}) async {
    var balances = await getWalletBalances();
    var iterations = 0;

    while (balances.haveUnconfirmedFunds) {
      await btcc.mineBlocks(1);
      await Future.delayed(Duration(seconds: 1));
      balances = await getWalletBalances();

      if (iterations > maxIterations) {
        throw StateError(
            "Wallet balances not confirmed after $maxIterations iterations");
      }

      iterations++;
    }

    return iterations;
  }

  /// Wait until all nodes have all funds confirmed by comparing
  /// to a previous balance
  Future<void> compareAndWaitForFunds({
    required WalletBalances before,
    int maxIterations = 25,
  }) async {
    int iterations = 0;
    bool isHigher = false;
    while (!isHigher) {
      if (iterations > maxIterations) {
        throw StateError("Nodes not funded after $maxIterations iterations");
      }

      await btcc.mineBlocks(1);
      await Future.delayed(const Duration(seconds: 2));
      final after = await getWalletBalances();
      isHigher = after.areAllHigherThan(before, confirmedOnly: true);

      iterations++;
    }

    logMessage("Funds arrived at all nodes after $iterations iterations");
  }

  Future<void> applyNetwork([String fileName = 'net-1.json']) async {
    // final file = File(fileName);
    // final txt = await file.readAsString();
    // final json = jsonDecode(txt);

    // for (var entry in json) {
    //   final from = entry['from'] as String;
    //   final channels = entry['channels'];

    //   final fromNode = _nodeMap[NodeId.values.byName(from)];

    //   for (var c in channels) {
    //     final to = c['to'];
    //     final toNode = _nodeMap[NodeId.values.byName(to)];
    //     if (fromNode == null || toNode == null) {
    //       logMessage("Can't find node $from or $to");
    //       continue;
    //     }

    //     final txid = await fromNode.openChannel(toNode);

    //     for (var i = 0; i < 10; i++) {
    //       // mine every second to allow nodes to catch up timely
    //       await btcc.mineBlocks(1);
    //       await Future.delayed(const Duration(seconds: 1));
    //     }
    //     await Future.delayed(const Duration(seconds: 2));

    //     logMessage(
    //       "Opened channel from ${fromNode.id} to ${toNode.id}, txid: $txid",
    //     );
    //   }
    // }
  }

  Future<int> sweepAllChannels({bool autoMine = false}) async {
    logMessage("Sweeping all channels");

    final Map<LnNode, List<RegtestChannel>> channels = {};
    int numClosed = 0;
    for (var n in lnNodes) {
      // get all channels before closing
      channels[n] = await n.fetchChannels();

      // close the channels
      numClosed += await n.sweepChannels();

      // We need to wait a bit for the nodes to catch up
      await Future.delayed(Duration(seconds: 10));
    }

    for (var n in containers) {
      if (channels.containsKey(n)) {
        for (var x in channels[n]!) {
          print("active: ${x.channel.active}");
        }
      }
    }

    if (autoMine && numClosed > 0) {
      await btcc.mineBlocks(1);
      await Future.delayed(const Duration(seconds: 2));

      for (final n in lnNodes) {
        final newState = await n.fetchChannels();
        final olsState = channels[n]!;
        final diff = newState.length - olsState.length;
        if (diff != numClosed) {
          logMessage(
            "Node ${n.id} has ${newState.length} channels, but $numClosed were closed",
          );
        }
      }
    }

    return numClosed;
  }

  Future<String> sweepOnchain({
    List<LnNode> nodes = const [],
    String destAddress = "",
    autoMine = false,
  }) async {
    print("Sweeping onchain funds");
    await _btcc.ensureWalletLoaded();
    final address =
        destAddress.isEmpty ? await getNewBitcoinCoreAddress() : destAddress;

    final balancesBefore = await getWalletBalances();

    final l = nodes.isEmpty ? containers : nodes;
    for (final n in l) {
      if (n is! LnNode) continue;

      if (balancesBefore.balances[n]!.hasOnchainFunds) {
        await n.sendOnChain(0, address, true);
      }
    }

    if (autoMine) {
      await btcc.mineBlocks(10, delayBetweenBlocks: 1, printStatus: true);
    }

    return address;
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

  Future<String> getNewBitcoinCoreAddress() async => await _btcc.newAddress();

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

  DockerContainer addContainer(ContainerType type) {
    final DockerContainer container = switch (type) {
      ContainerType.bitcoinCore => BitcoinCoreContainer(),
      ContainerType.cashuMint => CashuMintContainer(),
      ContainerType.cln => CLNContainer(),
      ContainerType.lnbits => LNbitsContainer(),
      ContainerType.lnd => LNDContainer()
    };

    containers.add(container);

    return container;
  }

  Future<void> startContainer(DockerContainer container) async {
    await prepareDataDir(dockerDataDir);
    await _ensureDockerNetwork();

    await container.start();
  }

  Future<void> stopContainer(DockerContainer container) async {
    await container.stop();
  }
}
