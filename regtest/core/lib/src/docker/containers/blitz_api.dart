library docker.containers;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:regtest_core/core.dart';

import '../arg_builder.dart';
import '../exceptions.dart';

class BlitzAPIContainer extends DockerContainer {
  String btcContainerName = '';
  String redisHost;
  int redisPort;
  int redisDB;
  LnNode node;

  BlitzAPIContainer({
    image = 'blitz_api:latest',
    required this.node,
    this.btcContainerName = defaultBitcoinCoreName,
    this.redisHost = 'redis',
    this.redisPort = 6379,
    this.redisDB = 0,
  }) : super('${projectName}_${node.containerName}_api', image);

  @override
  Future<void> start() async {
    // docker run --restart on-failure --entrypoint sh /code/entrypoint.sh
    //    --publish "8822:80" --volume "/tmp/regtest-data:/root/data"
    //    --environment "REDIS_HOST=redis" --environment "REDIS_PORT=6379"
    //    --environment "REDIS_DB=0" --environment "LN_BACKEND=lnd1"
    //    --network workspace_network --name workspace_lnd1-blitz
    //    --detach blitz_api:latest

    statusCtrl.add(StatusMessage(ContainerStatus.starting, ''));
    final argBuilder = DockerArgBuilder()
        .addArg('run')
        .addOption('--restart', 'on-failure')
        .addOption('--entrypoint', 'sh /code/entrypoint.sh')
        .addOption('--volume', '/tmp/regtest-data:/root/data')
        .addOption('--network', projectNetwork)
        .addOption('--name', containerName)
        .addOption('--environment', 'REDIS_HOST=$redisHost')
        .addOption('--environment', 'REDIS_PORT=$redisPort')
        .addOption('--environment', 'REDIS_DB=$redisDB')
        .addOption('--environment', 'bitcoind_ip_regtest=$btcContainerName')
        .addOption('--environment', 'bitcoind_port_rpc_regtest=18443')
        .addOption('--environment', 'bitcoind_user=regtester')
        .addOption('--environment', 'bitcoind_pw=regtester');

    if (node.runtimeType is CLNContainer) {
      final n = node as CLNContainer;
      argBuilder
          .addOption('--environment', 'ln_node=cln_grpc')
          .addOption('--environment', 'cln_grpc_cert=${n.gRPCCert}')
          .addOption('--environment', 'cln_grpc_key=${n.gRPCClientKey}')
          .addOption('--environment', 'cln_grpc_ca=${n.gRPCCACert}')
          .addOption('--environment', 'cln_grpc_ip=${n.containerName}')
          .addOption('--environment', 'cln_grpc_port=${n.gRPCPort}')
          .addOption('--environment', 'ln_node=cln_jrpc')
          .addOption('--environment', 'cln_jrpc_path=${n.jRPCFilePath}');
    }

    if (node.runtimeType is LNDContainer) {
      final n = node as LNDContainer;
      argBuilder
          .addOption('--environment', 'ln_node=lnd_grpc')
          .addOption('--environment', 'lnd_macaroon="${n.adminMacaroonPath}')
          .addOption('--environment', 'lnd_cert="${n.tlsCertPath}')
          .addOption('--environment', 'lnd_grpc_ip="${n.containerName}')
          .addOption('--environment', 'lnd_grpc_port="${n.gRPCPort}')
          .addOption('--environment', 'lnd_rest_port="${n.restPort}');
    }

    argBuilder
        .addArg('--detach')
        .addOption('--publish', '${8820 + node.id}:80')
        .addArg(image);

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
    print(containerId);
    super.subscribeLogs();

    statusCtrl.add(StatusMessage(ContainerStatus.started, ''));
  }

  @override
  Future<void> stop() async {}
}
