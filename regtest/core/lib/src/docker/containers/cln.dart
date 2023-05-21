library docker.containers;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:regtest_core/core.dart';

import '../arg_builder.dart';
import 'base.dart';

class CLNContainer extends DockerContainer {
  final int id;
  final String alias;
  final String btcContainerName;
  final int _gRPCPort;

  CLNContainer({
    image = 'boltz/c-lightning:23.02.2',
    this.alias = '',
    this.id = 0,
    this.btcContainerName = defaultBitcoinCoreName,
  })  : assert(id >= 0),
        _gRPCPort = 11109 + id,
        super('${projectName}_cln_$id', image);

  int get gRPCPort => _gRPCPort;
  String get gRPCCert => '$dataPath/regtest/client.pem';
  String get gRPCClientKey => '$dataPath/regtest/client-key.pem';
  String get gRPCCACert => '$dataPath/regtest/ca.pem';
  String get jRPCFilePath => '$dataPath/regtest/lightning-rpc';

  @override
  Future<void> start() async {
    statusCtrl.add(StatusMessage(ContainerStatus.starting, ''));
    final argBuilder = DockerArgBuilder()
        .addArg('run')
        .addOption('--restart', 'on-failure')
        .addOption('--expose', 9735)
        .addOption('--expose', _gRPCPort)
        .addArg('--publish-all')
        .addOption('--volume', '$dataPath:/root/.lightning/')
        .addOption('--network', projectNetwork)
        .addOption('--name', name)
        .addArg('--detach')
        .addArg(image)
        .addArg('--alias=$alias')
        .addArg('--large-channels')
        .addArg('--network=regtest')
        .addArg('--bind-addr=0.0.0.0:9735')
        .addArg('--bitcoin-rpcconnect=$btcContainerName')
        .addArg('--bitcoin-rpcport=18443')
        .addArg('--bitcoin-rpcuser=regtester')
        .addArg('--bitcoin-rpcpassword=regtester')
        .addArg('--grpc-port=$_gRPCPort');

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
