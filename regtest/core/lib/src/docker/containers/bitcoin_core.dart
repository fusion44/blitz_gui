library docker.containers;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../constants.dart';
import '../../utils.dart';
import '../arg_builder.dart';
import '../docker.dart';
import '../exceptions.dart';

class BitcoinCoreOptions extends ContainerOptions {
  const BitcoinCoreOptions({
    super.name = defaultBitcoinCoreName,
    super.image = "boltz/bitcoin-core:24.0.1",
    super.workDir = dockerDataDir,
  });

  @override
  List<Object?> get props => [name, image, workDir];
}

class BitcoinCoreContainer extends DockerContainer {
  BitcoinCoreOptions opts;

  BitcoinCoreContainer({
    this.opts = const BitcoinCoreOptions(),
    String? internalId,
  }) : super(opts, internalId: internalId);

  BitcoinCoreContainer._(ContainerData cd)
      : opts = BitcoinCoreOptions(name: cd.name, image: cd.image),
        super(ContainerOptions(name: cd.name, image: cd.image)) {
    dockerId = cd.dockerId;
  }

  @override
  ContainerType get type => ContainerType.bitcoinCore;

  static Future<BitcoinCoreContainer> fromRunningContainer(
      ContainerData c) async {
    final newContainer = BitcoinCoreContainer._(c);
    await newContainer.subscribeLogs();
    return newContainer;
  }

  @override
  Future<void> start() async {
    statusCtrl.add(ContainerStatusMessage(ContainerStatus.starting, ""));
    final argBuilder = DockerArgBuilder()
        .addArg("run")
        .addOption('--restart', 'on-failure')
        .addOption('--expose', '18443')
        .addOption('--expose', '29000')
        .addOption('--expose', '29001')
        .addOption('--publish-all')
        .addOption('--network', projectNetwork)
        .addOption('--name', name)
        .addOption('--detach')
        .addArg(image)
        .addArg('-regtest')
        .addArg('-fallbackfee=0.00000253')
        .addArg('-zmqpubrawtx=tcp://0.0.0.0:29000')
        .addArg('-zmqpubrawblock=tcp://0.0.0.0:29001')
        .addArg('-txindex')
        .addArg('-rpcallowip=0.0.0.0/0')
        .addArg('-rpcbind=0.0.0.0')
        .addArg('-rpcuser=regtester')
        .addArg('-rpcpassword=regtester');

    final result = await Process.run(
      'docker',
      argBuilder.build(),
      workingDirectory: workDir,
    );

    if (result.exitCode != 0) {
      throw DockerException(
        "Failed to start container $name. Error: ${result.stderr.toString()}",
      );
    }

    dockerId = result.stdout as String;
    dockerId = dockerId.trim();

    statusCtrl.add(ContainerStatusMessage(ContainerStatus.started, ''));

    super.subscribeLogs();
  }

  @override
  Future<void> stop() async {}

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
        await _doMineBlocks(1);
      }

      return;
    }

    if (printStatus) print("Mining $numBlocks blocks");

    await _doMineBlocks(numBlocks);
  }

  Future<String> newAddress() async {
    try {
      final output = await _command(['getnewaddress']);
      if (output.isNotEmpty) {
        return output.trim();
      }

      logMessage("Something went wrong trying to get a new address");
    } catch (e) {
      logMessage(e.toString());
    }

    return "error, see logs";
  }

  Future<void> ensureWalletLoaded({String walletName = "regtest"}) async {
    try {
      final output = await _command(['loadwallet', walletName]);
      final json = jsonDecode(output);
      if (json["walletname"] != null && json["walletname"] == walletName) {
        return;
      }
    } catch (e) {
      final error = e.toString();
      if (error.contains(
          "SQLiteDatabase: Unable to obtain an exclusive lock on the database")) {
        // wallet is loaded
        return;
      }

      logMessage("Creating Bitcoin Core wallet $walletName");
    }

    await _command(['createwallet', walletName]);
  }

  Future<String> sendFunds(String address, [double amountInBtc = 15.0]) async {
    try {
      final output = await _command([
        "-named",
        "sendtoaddress",
        "address=$address",
        "amount=$amountInBtc",
        "fee_rate=100"
      ]);

      if (output.isNotEmpty) {
        return output.trim();
      }

      logMessage(
        "Something went wrong trying to send funds from Bitcoin Core to $address",
      );
    } catch (e) {
      logMessage(e.toString());
    }

    return "error, see logs";
  }

  Future<String> _command(List<String> args) async {
    final c = Completer<String>();
    final p = await Process.start('docker', [
      'exec',
      defaultBitcoinCoreName,
      'bitcoin-cli',
      '-rpcuser=regtester',
      '-rpcpassword=regtester',
      '-regtest',
      ...args,
    ]);

    p.stdout.transform(utf8.decoder).listen(
          (event) => c.complete(event),
          onError: (error) => c.completeError(error),
        );

    p.stderr.transform(utf8.decoder).listen((error) => c.completeError(error));

    return c.future;
  }

  Future<void> _doMineBlocks(int numBlocks) async {
    try {
      final output = await _command(['-generate', '$numBlocks']);
      final json = jsonDecode(output);
      if (json["address"] != null &&
          json["blocks"] != null &&
          json["blocks"].length == numBlocks) {
        return;
      }

      logMessage("Something went wrong trying to mine $numBlocks blocks");
    } catch (e) {
      logMessage(e.toString());
    }
  }

  BitcoinCoreContainer copyWith({
    String? name,
    String? image,
    String? workDir,
  }) {
    if (dockerId.isNotEmpty) {
      throw StateError('Container is already running');
    }

    return BitcoinCoreContainer(
      opts: BitcoinCoreOptions(
        name: name ?? opts.name,
        image: image ?? opts.image,
        workDir: workDir ?? opts.workDir,
      ),
      internalId: internalId,
    );
  }
}
