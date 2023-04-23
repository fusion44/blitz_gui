// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blitz_api_client/blitz_api_client.dart';

import 'commands/bitcoind.dart';
import 'commands/docker.dart';
import 'constants.dart';
import 'model_extensions.dart';
import 'models.dart';
import 'utils.dart';

const dataDir = "/tmp/regtest-data";

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
  final Map<NodeId, LnNode> _nodeMap = {};

  static final NetworkManager _instance = NetworkManager._internal();

  bool _bootstrapped = false;
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

  Map<NodeId, LnNode> get nodeMap => _nodeMap;
  List<LnNode> get nodeList => _nodeMap.values.toList();

  LnNode? nodeByPubKey(String key) =>
      _nodeMap.values.firstWhere((node) => node.pubKey == key);

  /// Starts the network if down
  ///
  /// If [exposeDataDirToHost] is true, the data directory will not be made
  /// public. ⚠️ This will ask for root password! The value is currently
  /// hardcoded to /tmp/regtest-data
  ///
  /// If [autoFundNodes] is true, the nodes will be funded with 15 rBTC each
  Future<void> start({
    bool exposeDataDirToHost = false,
    bool autoFundNodes = true,
  }) async {
    _sendMessage(NetworkState.startingUp);

    await _prepareDataDir(dataDir, getComposeString());

    final args = ["compose", "-p", projectName, "up", "-d", "--remove-orphans"];
    final output = await _command(args, dataDir);

    logMessage("Ensuring Bitcoin daemon wallet exists");
    await ensureWalletLoaded();
    // Consensus mechanism requires 100 blocks to be mined
    // before reward can be spent
    logMessage("Mining 110 blocks to get and unlock block reward");
    await mineBlocks(110);

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

    await mineBlocks(3);
    await _bootstrapNodeData();
    if (exposeDataDirToHost) {
      await _makeDataDirsPublic();
    }

    await Future.delayed(const Duration(seconds: 10));
    _sendMessage(NetworkState.up);
    logMessage(output);
  }

  Future<void> stop() async {
    final args = ["compose", "-p", projectName, "down", "--volumes"];
    try {
      _sendMessage(NetworkState.shuttingDown);
      final output = await _command(args, dataDir);

      await _cleanDataDirectories();

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

  Future<String> _command(List<String> args, String workDir) async {
    final c = Completer<String>();
    final p = await Process.start('docker', args, workingDirectory: workDir);

    p.stdout.transform(utf8.decoder).listen(
      (event) => logMessage(event),
      onDone: () async {
        logMessage("_command: onDone");
        if (!c.isCompleted) c.complete("$args");
      },
      onError: (error) {
        logMessage("_command: onError");

        if (!c.isCompleted) c.completeError(error);
      },
    );

    p.stderr.transform(utf8.decoder).listen((error) {
      final message = error.toString().trim();
      if (message.contains("Creating") ||
          message.contains("Created") ||
          message.contains("Starting") ||
          message.contains("Started")) {
        return logMessage(message);
      }

      logMessage(message);
    });

    return c.future;
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

    final futures = <Future>[];
    for (final id in NodeId.values) {
      if (id != NodeId.empty) {
        final n = LnNode(id);
        _nodeMap[id] = n;
        futures.add(n.bootstrap());
      }
    }

    await Future.wait(futures);
    _bootstrapped = true;
  }

  Future<void> fundNodes({
    bool autoMine = true,
    double amountInBtc = 15.0,
  }) async {
    logMessage("Funding nodes");

    await ensureWalletLoaded();

    final futures = <Future>[];
    for (final n in nodeList) {
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
      final res = await fundFromDaemonWallet(a, amountInBtc);
      logMessage(res);
    }

    if (autoMine) {
      int iterations = 0;
      bool isHigher = false;
      while (!isHigher) {
        if (iterations > 25) {
          print("Nodes not funded after 25 iterations");
          return;
        }

        await mineBlocks(1);
        await Future.delayed(const Duration(seconds: 2));
        final after = await getWalletBalances();
        isHigher = after.areAllHigherThan(before, confirmedOnly: true);

        iterations++;
      }
      print("Funds arrived at all nodes after $iterations iterations");
    }

    print("Funding done");
  }

  Future<void> applyNetwork([String fileName = 'net-1.json']) async {
    final file = File(fileName);
    final txt = await file.readAsString();
    final json = jsonDecode(txt);

    for (var entry in json) {
      final from = entry['from'];
      final channels = entry['channels'];

      final fromNode = _nodeMap[NodeId.values.byName(from)];

      for (var c in channels) {
        final to = c['to'];
        final toNode = _nodeMap[NodeId.values.byName(to)];
        if (fromNode == null || toNode == null) {
          logMessage("Can't find node $from or $to");
          continue;
        }

        final txid = await fromNode.openChannel(toNode);

        for (var i = 0; i < 10; i++) {
          // mine every second to allow nodes to catch up timely
          await mineBlocks(1);
          await Future.delayed(const Duration(seconds: 1));
        }
        await Future.delayed(const Duration(seconds: 2));

        logMessage(
          "Opened channel from ${fromNode.id} to ${toNode.id}, txid: $txid",
        );
      }
    }
  }

  Future<int> sweepAllChannels({bool autoMine = false}) async {
    print("Sweeping all channels");

    int numClosed = 0;
    for (final n in nodeList) {
      numClosed += await n.sweepChannels();
    }

    if (autoMine && numClosed > 0) await mineBlocks(15, delayBetweenBlocks: 1);

    return numClosed;
  }

  Future<String> sweepOnchain({
    List<LnNode> nodes = const [],
    String destAddress = "",
    autoMine = false,
  }) async {
    print("Sweeping onchain funds");
    await ensureWalletLoaded();
    final address =
        destAddress.isEmpty ? await getNewBitcoinDAddress() : destAddress;

    final balancesBefore = await getWalletBalances();

    final l = nodes.isEmpty ? nodeList : nodes;
    for (final LnNode n in l) {
      if (balancesBefore.balances[n]!.hasOnchainFunds) {
        await n.sendOnChain(0, address, true);
      }
    }

    if (autoMine) {
      await mineBlocks(10, delayBetweenBlocks: 1, printStatus: true);
    }

    return address;
  }

  Future<void> mineBlocks(
    int numBlocks, {
    int delayBetweenBlocks = 0,
    bool printStatus = false,
  }) async {
    if (delayBetweenBlocks > 0) {
      for (var i = 1; i < numBlocks + 1; i++) {
        if (printStatus) {
          print("Mining block $i of $numBlocks with delay $delayBetweenBlocks");
        }
        await Future.delayed(Duration(seconds: delayBetweenBlocks));
        await doMineBlocks(1);
      }
    }

    if (printStatus) print("Mining $numBlocks blocks");

    await doMineBlocks(numBlocks);
  }

  Future<WalletBalances> getWalletBalances() async {
    final futures = <Future<WalletBalance>>[];
    for (final n in nodeList) {
      futures.add(n.walletBalance());
    }

    final b = await Future.wait<WalletBalance>(futures);

    final balances = <LnNode, WalletBalance>{};
    for (var i = 0; i < b.length; i++) {
      balances[nodeList[i]] = b[i];
    }

    return WalletBalances(balances);
  }

  Future<String> getNewBitcoinDAddress() async => await getNewAddress();

  Future<void> _prepareDataDir(String dir, String fileContents) async {
    final directory = Directory(dir);

    if (await directory.exists()) {
      logMessage("$dir exists => deleting ...");

      await directory.delete(recursive: true);
    }
    logMessage("Creating data directory $dir");

    await directory.create(recursive: true);

    final file = File('${directory.path}/docker-compose.yml');

    await file.writeAsString(fileContents);
  }

  Future<void> _makeDataDirsPublic() async {
    // Docker is usually a root run application, so the data directories
    // are owned by root. This makes it hard to access the data
    // change ownership from root to current user

    final su = isHeadless() ? 'sudo' : 'pkexec';
    final modRes = await Process.run(
      su,
      ["chmod" "-R", "777", Directory("/tmp/regtest-data").absolute.path],
      workingDirectory: dataDir,
    );

    // TODO: unhardcodify the username
    await Process.run(
      su,
      ["chown", "-R", "f44", Directory("/tmp/regtest-data").absolute.path],
      workingDirectory: dataDir,
    );
  }

  Future<void> _cleanDataDirectories() async {
    for (var d in dataDirs) {
      await Directory(d).delete(recursive: true);
    }
  }
}
