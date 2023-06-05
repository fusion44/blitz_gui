library docker.containers;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:regtest_core/core.dart';

import '../arg_builder.dart';
import '../exceptions.dart';

class LNDOptions extends LnNodeOptions {
  LNDOptions({
    String? name,
    super.image = 'boltz/lnd:0.16.2-beta',
    super.alias = '',
    super.btcContainerName = defaultBitcoinCoreName,
    super.workDir = dockerDataDir,
    int id = 0,
  })  : assert(id >= 0),
        super(name: name ?? '${projectName}_lnd_$id', id: id);
}

class LNDContainer extends LnNode {
  final LNDOptions opts;
  final int _gRPCPort;
  final int _restPort;

  LNDContainer({required this.opts})
      : _gRPCPort = 11109 + opts.id,
        _restPort = 8081 + opts.id,
        super(opts: opts);

  factory LNDContainer.defaultOptions() => LNDContainer(opts: LNDOptions());

  @override
  ContainerType get type => ContainerType.lnd;
  int get gRPCPort => _gRPCPort;
  int get restPort => _restPort;
  String get adminMacaroonPath =>
      '$dataPath/data/chain/bitcoin/regtest/admin.macaroon';
  String get tlsCertPath => '$dataPath/tls.cert';

  @override
  Future<void> start() async {
    final o = opts;

    statusCtrl.add(ContainerStatusMessage(ContainerStatus.starting, ''));
    final argBuilder = DockerArgBuilder()
        .addArg('run')
        .addOption('--restart', 'on-failure')
        .addOption('--expose', '${8081 + o.id}')
        .addOption('--expose', '$_gRPCPort')
        .addArg('--publish-all')
        .addOption('--volume', '$dataPath:/root/.lnd/')
        .addOption('--network', projectNetwork)
        .addOption('--name', name)
        .addArg('--detach')
        .addArg(image)
        .addArg('--alias=$o.alias')
        .addArg('--listen=$name:9735')
        .addArg('--rpclisten=$name:$_gRPCPort')
        .addArg('--restlisten=$name:$_restPort')
        .addArg('--bitcoin.active')
        .addArg('--bitcoin.regtest')
        .addArg('--bitcoin.node=bitcoind')
        .addArg('--bitcoind.rpchost=${o.btcContainerName}')
        .addArg('--bitcoind.zmqpubrawtx=tcp://${o.btcContainerName}:29000')
        .addArg('--bitcoind.zmqpubrawblock=tcp://${o.btcContainerName}:29001')
        .addArg('--bitcoind.rpcuser=regtester')
        .addArg('--bitcoind.rpcpass=regtester')
        .addArg('--noseedbackup')
        .addArg('--protocol.wumbo-channels')
        .addArg('--tlsextraip=127.0.0.1')
        .addArg('--tlsextraip=0.0.0.0')
        .addArg('--tlsextradomain=localhost')
        .addArg('--tlsextradomain=$name');

    print(argBuilder.debugCommand());

    final result = await Process.start(
      'docker',
      argBuilder.build(),
      workingDirectory: workDir,
    );

    dockerId = await Future.any([
      result.stderr.transform(utf8.decoder).asBroadcastStream().first,
      result.stdout.transform(utf8.decoder).asBroadcastStream().first
    ]);

    if (dockerId.isEmpty || dockerId.length != 65) {
      throw DockerException('Failed to start LND container: $dockerId');
    }

    super.subscribeLogs();

    statusCtrl.add(ContainerStatusMessage(ContainerStatus.started, ''));
  }

  @override
  Future<void> stop() async {}
}
