library docker.containers;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:regtest_core/core.dart';

import '../arg_builder.dart';

class CLNOptions extends LnNodeOptions {
  CLNOptions({
    String? name,
    super.image = 'boltz/c-lightning:23.02.2',
    super.alias = '',
    super.btccContainerId = '',
    super.workDir = dockerDataDir,
    int id = 0,
  })  : assert(id >= 0),
        super(name: name ?? '${projectName}_cln_$id', id: id);
}

class CLNContainer extends LnNode {
  final int _gRPCPort;

  CLNContainer({required super.opts}) : _gRPCPort = 11109 + opts.id;

  factory CLNContainer.defaultOptions() => CLNContainer(opts: CLNOptions());

  @override
  ContainerType get type => ContainerType.cln;

  int get gRPCPort => _gRPCPort;
  String get gRPCCert => '$dataPath/regtest/client.pem';
  String get gRPCClientKey => '$dataPath/regtest/client-key.pem';
  String get gRPCCACert => '$dataPath/regtest/ca.pem';
  String get jRPCFilePath => '$dataPath/regtest/lightning-rpc';

  @override
  Future<void> start() async {
    setStatus(ContainerStatusMessage(ContainerStatus.starting, ''));
    final argBuilder = DockerArgBuilder()
        .addArg('run')
        .addOption('--restart', 'on-failure')
        .addOption('--expose', 9735)
        .addOption('--expose', _gRPCPort)
        .addArg('--publish-all')
        .addOption('--volume', '$dataPath:/root/.lightning/')
        .addOption('--network', projectNetwork)
        .addOption('--name', containerName)
        .addArg('--detach')
        .addArg(image)
        .addArg('--alias=$opts.alias')
        .addArg('--large-channels')
        .addArg('--network=regtest')
        .addArg('--bind-addr=0.0.0.0:9735')
        .addArg('--bitcoin-rpcconnect=$opts.btcContainerName')
        .addArg('--bitcoin-rpcport=18443')
        .addArg('--bitcoin-rpcuser=regtester')
        .addArg('--bitcoin-rpcpassword=regtester')
        .addArg('--grpc-port=$_gRPCPort');

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
      throw DockerException('Failed to start CLN container: $dockerId');
    }

    super.subscribeLogs();

    setStatus(ContainerStatusMessage(ContainerStatus.started, ''));
  }

  @override
  Future<void> stop() async {}
}
