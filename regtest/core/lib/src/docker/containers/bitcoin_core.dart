library docker.containers;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../constants.dart';
import '../../utils.dart';
import '../arg_builder.dart';
import '../docker.dart';

const defaultWalletName = "regtest";

class BitcoinCoreOptions extends ContainerOptions {
  final bool fundWallet;
  final String walletName;
  final bool makeDataDirPublic;

  const BitcoinCoreOptions({
    super.name = defaultBitcoinCoreName,
    super.image = 'boltz/bitcoin-core:24.0.1',
    super.workDir = dockerDataDir,
    this.fundWallet = true,
    this.walletName = defaultWalletName,
    this.makeDataDirPublic = false,
  });

  @override
  List<Object?> get props => [
        name,
        image,
        workDir,
        fundWallet,
        walletName,
        makeDataDirPublic,
      ];

  @override
  String toString() {
    return "BitcoinCoreOptions{name: $name, image: $image, workDir: $workDir, fundWallet: $fundWallet, walletName: $walletName, makeDataDirPublic: $makeDataDirPublic}";
  }

  // copyWith method
  BitcoinCoreOptions copyWith({
    String? name,
    String? image,
    String? workDir,
    bool? fundWallet,
    String? walletName,
    bool? makeDataDirPublic,
  }) {
    return BitcoinCoreOptions(
      name: name ?? this.name,
      image: image ?? this.image,
      workDir: workDir ?? this.workDir,
      fundWallet: fundWallet ?? this.fundWallet,
      walletName: walletName ?? this.walletName,
      makeDataDirPublic: makeDataDirPublic ?? this.makeDataDirPublic,
    );
  }
}

class BitcoinCoreContainer extends DockerContainer {
  BitcoinCoreOptions opts;

  BitcoinCoreContainer({
    this.opts = const BitcoinCoreOptions(),
    String? internalId,
  }) : super(opts, internalId: internalId);

  BitcoinCoreContainer._(ContainerData cd, Function()? onDeleted)
      : opts = BitcoinCoreOptions(name: cd.name, image: cd.image),
        super(
          ContainerOptions(name: cd.name, image: cd.image),
          internalId: cd.internalId,
          onDeleted: onDeleted,
        ) {
    dockerId = cd.dockerId;
    setStatus(ContainerStatusMessage(cd.status, ''));
  }

  @override
  ContainerType get type => ContainerType.bitcoinCore;

  static Future<BitcoinCoreContainer> fromRunningContainer(
    ContainerData c,
    Function()? onDeleted,
  ) async {
    final newContainer = BitcoinCoreContainer._(c, onDeleted);
    await newContainer.subscribeLogs();
    return newContainer;
  }

  @override
  Future<void> start() async {
    setStatus(ContainerStatusMessage(ContainerStatus.starting, ""));

    if (dockerId.isNotEmpty) {
      await runDockerCommand(["start", dockerId]);
      await ensureWalletLoaded(walletName: opts.walletName);
    } else {
      await prepareDataDir(dataPath);
      dockerId = await runDockerCommand(_buildRunDockerArgs());
      dockerId = dockerId.trim();
      super.subscribeLogs();

      if (opts.fundWallet) {
        await ensureWalletLoaded(walletName: opts.walletName);
        // Bitcoin block rewards get unlocked after 100 blocks
        await mineBlocks(110);
      }

      if (opts.makeDataDirPublic) {
        await Future.delayed(Duration(seconds: 1));
        await makeDataDirsPublic(dataPath);
      }
    }

    running = true;
    setStatus(ContainerStatusMessage(ContainerStatus.started, ''));
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

  Future<void> ensureWalletLoaded({
    String walletName = defaultWalletName,
  }) async {
    const maxAttempts = 5;
    var attempt = 0;
    while (attempt < maxAttempts) {
      try {
        final output = await _command(['loadwallet', walletName]);
        final json = jsonDecode(output);
        if (json["walletname"] != null && json["walletname"] == walletName) {
          return;
        }
        break;
      } on BitcoinCoreNotReadyException {
        attempt++;
      } on DockerException catch (e) {
        attempt++;
        final error = e.message;
        // Different bitcoin core versions have different error messages
        if (error.contains(
              'SQLiteDatabase: Unable to obtain an exclusive lock on the database',
            ) ||
            error.contains(
              'sqlitedatabase: unable to obtain an exclusive lock on the database,',
            ) ||
            error.contains(
              'database already exists',
            )) {
          // wallet is loaded
          return;
        }

        if (error.contains('path does not exist.')) {
          logMessage("Creating Bitcoin Core wallet $walletName");
          await _command(['createwallet', walletName]);
        }
      }

      if (attempt < maxAttempts) {
        await Future.delayed(
          const Duration(seconds: 2),
        ); // wait for 2 seconds before the next attempt
      } else {
        print('Max attempts reached. Stopping execution.');
      }
    }
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
    if (dockerId.isEmpty) {
      throw StateError('dockerId is empty');
    }

    final p = await Process.run('docker', [
      'exec',
      dockerId,
      'bitcoin-cli',
      '-rpcuser=regtester',
      '-rpcpassword=regtester',
      '-regtest',
      ...args,
    ]);

    var err = p.stderr;
    if (err != null && err is String && err.isNotEmpty) {
      err = err.toLowerCase();
      if (err.contains("loading block index") ||
          err.contains('verifying blocks') ||
          err.contains('loading banlist')) {
        throw BitcoinCoreNotReadyException.isStartingUp();
      }

      if (err.contains(
          'Wallet file verification failed. Failed to load database path')) {
        throw BitcoinCoreNotReadyException.walletError(err);
      }

      throw DockerException('Unknown Docker Error: $err');
    }

    return p.stdout;
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

  List<String> _buildRunDockerArgs() {
    final builder = DockerArgBuilder()
        .addArg("run")
        .addOption('--restart', 'always')
        .addOption('--expose', '18443')
        .addOption('--expose', '29000')
        .addOption('--expose', '29001')
        .addOption('--publish-all')
        .addOption('--network', projectNetwork)
        .addOption('--name', containerName)
        .addOption('--detach');

    if (opts.makeDataDirPublic) {
      builder.addOption('--volume', '$dataPath:/root/.bitcoin/');
    }

    builder
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

    return builder.build();
  }

  @override
  List<String> bootstrapCommands() => [
        ...super.bootstrapCommands(),
        'alias bitcoin-cli="bitcoin-cli -rpcuser=regtester -rpcpassword=regtester -regtest"\n',
      ];
}
