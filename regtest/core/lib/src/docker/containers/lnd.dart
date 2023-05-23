library docker.containers;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:regtest_core/core.dart';

import '../arg_builder.dart';
import '../exceptions.dart';

class LNDContainer extends LnNode {
  final int _gRPCPort;
  final int _restPort;

  LNDContainer({
    btcContainerName = defaultBitcoinCoreName,
    alias = '',
    int id = 0,
    image = 'boltz/lnd:0.16.2-beta',
  })  : assert(id >= 0),
        _gRPCPort = 11109 + id,
        _restPort = 8081 + id,
        super(
          '${projectName}_cln_$id',
          image,
          id,
          alias,
          btcContainerName,
        );

  int get gRPCPort => _gRPCPort;
  int get restPort => _restPort;
  String get adminMacaroonPath =>
      '$dataPath/data/chain/bitcoin/regtest/admin.macaroon';
  String get tlsCertPath => '$dataPath/tls.cert';

  @override
  Future<void> start() async {
    statusCtrl.add(StatusMessage(ContainerStatus.starting, ''));
    final argBuilder = DockerArgBuilder()
        .addArg('run')
        .addOption('--restart', 'on-failure')
        .addOption('--expose', '${8081 + id}')
        .addOption('--expose', '$_gRPCPort')
        .addArg('--publish-all')
        .addOption('--volume', '$dataPath:/root/.lnd/')
        .addOption('--network', projectNetwork)
        .addOption('--name', containerName)
        .addArg('--detach')
        .addArg(image)
        .addArg('--alias=$alias')
        .addArg('--listen=$containerName:9735')
        .addArg('--rpclisten=$containerName:$_gRPCPort')
        .addArg('--restlisten=$containerName:$_restPort')
        .addArg('--bitcoin.active')
        .addArg('--bitcoin.regtest')
        .addArg('--bitcoin.node=bitcoind')
        .addArg('--bitcoind.rpchost=$btcContainerName')
        .addArg('--bitcoind.zmqpubrawtx=tcp://$btcContainerName:29000')
        .addArg('--bitcoind.zmqpubrawblock=tcp://$btcContainerName:29001')
        .addArg('--bitcoind.rpcuser=regtester')
        .addArg('--bitcoind.rpcpass=regtester')
        .addArg('--noseedbackup')
        .addArg('--protocol.wumbo-channels')
        .addArg('--tlsextraip=127.0.0.1')
        .addArg('--tlsextraip=0.0.0.0')
        .addArg('--tlsextradomain=localhost')
        .addArg('--tlsextradomain=$containerName');

    print(argBuilder.debugCommand());

    final result = await Process.start(
      'docker',
      argBuilder.build(),
      workingDirectory: workDir,
    );

    containerId = await Future.any([
      result.stderr.transform(utf8.decoder).asBroadcastStream().first,
      result.stdout.transform(utf8.decoder).asBroadcastStream().first
    ]);

    if (containerId == null ||
        containerId!.isEmpty ||
        containerId!.length != 65) {
      throw DockerException('Failed to start LND container: $containerId');
    }

    super.subscribeLogs();

    statusCtrl.add(StatusMessage(ContainerStatus.started, ''));
  }

  @override
  Future<void> stop() async {}
}
