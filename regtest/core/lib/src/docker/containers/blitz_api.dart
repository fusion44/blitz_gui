library docker.containers;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:regtest_core/core.dart';
import 'package:regtest_core/src/docker/containers/fake_ln.dart';

import '../arg_builder.dart';
import '../exceptions.dart';

class BlitzAPIOptions extends ContainerOptions {
  final LnNode node;
  final String btcContainerName;
  final String redisHost;
  final int redisPort;
  final int redisDB;

  BlitzAPIOptions({
    required this.node,
    this.btcContainerName = defaultBitcoinCoreName,
    this.redisHost = 'redis',
    this.redisPort = 6379,
    this.redisDB = 0,
    image = 'blitz_api:latest',
    String workDir = dockerDataDir,
  }) : super(
          name: '${projectName}_${node.name}_api',
          image: image,
          workDir: workDir,
        );

  /// factory with a fake Ln node
  factory BlitzAPIOptions.empty() =>
      BlitzAPIOptions(node: FakeLnContainer.defaultOptions());

  @override
  List<Object?> get props => [
        name,
        image,
        workDir,
        btcContainerName,
        redisHost,
        redisPort,
        redisDB,
      ];
}

class BlitzAPIContainer extends DockerContainer {
  BlitzAPIOptions opts;

  BlitzAPIContainer({required this.opts}) : super(opts);

  @override
  ContainerType get type => ContainerType.blitzAPI;

  @override
  Future<void> start() async {
    // docker run --restart on-failure --entrypoint sh /code/entrypoint.sh
    //    --publish "8822:80" --volume "/tmp/regtest-data:/root/data"
    //    --environment "REDIS_HOST=redis" --environment "REDIS_PORT=6379"
    //    --environment "REDIS_DB=0" --environment "LN_BACKEND=lnd1"
    //    --network workspace_network --name workspace_lnd1-blitz
    //    --detach blitz_api:latest
    final o = opts;
    statusCtrl.add(ContainerStatusMessage(ContainerStatus.starting, ''));
    final argBuilder = DockerArgBuilder()
        .addArg('run')
        .addOption('--restart', 'on-failure')
        .addOption('--entrypoint', 'sh /code/entrypoint.sh')
        .addOption('--volume', '$dockerDataDir:/root/data')
        .addOption('--network', projectNetwork)
        .addOption('--name', name)
        .addOption('--environment', 'REDIS_HOST=${o.redisHost}')
        .addOption('--environment', 'REDIS_PORT=${o.redisPort}')
        .addOption('--environment', 'REDIS_DB=${o.redisDB}')
        .addOption('--environment', 'bitcoind_ip_regtest=${o.btcContainerName}')
        .addOption('--environment', 'bitcoind_port_rpc_regtest=18443')
        .addOption('--environment', 'bitcoind_user=regtester')
        .addOption('--environment', 'bitcoind_pw=regtester');

    if (o.node.runtimeType is CLNContainer) {
      final n = o.node as CLNContainer;
      argBuilder
          .addOption('--environment', 'ln_node=cln_grpc')
          .addOption('--environment', 'cln_grpc_cert=${n.gRPCCert}')
          .addOption('--environment', 'cln_grpc_key=${n.gRPCClientKey}')
          .addOption('--environment', 'cln_grpc_ca=${n.gRPCCACert}')
          .addOption('--environment', 'cln_grpc_ip=${n.name}')
          .addOption('--environment', 'cln_grpc_port=${n.gRPCPort}')
          .addOption('--environment', 'ln_node=cln_jrpc')
          .addOption('--environment', 'cln_jrpc_path=${n.jRPCFilePath}');
    }

    if (o.node.runtimeType is LNDContainer) {
      final n = o.node as LNDContainer;
      argBuilder
          .addOption('--environment', 'ln_node=lnd_grpc')
          .addOption('--environment', 'lnd_macaroon="${n.adminMacaroonPath}')
          .addOption('--environment', 'lnd_cert="${n.tlsCertPath}')
          .addOption('--environment', 'lnd_grpc_ip="${n.name}')
          .addOption('--environment', 'lnd_grpc_port="${n.gRPCPort}')
          .addOption('--environment', 'lnd_rest_port="${n.restPort}');
    }

    argBuilder
        .addArg('--detach')
        .addOption('--publish', '${8820 + o.node.opts.id}:80')
        .addArg(image);

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
    print(dockerId);
    super.subscribeLogs();

    statusCtrl.add(ContainerStatusMessage(ContainerStatus.started, ''));
  }

  @override
  Future<void> stop() async {}
}
