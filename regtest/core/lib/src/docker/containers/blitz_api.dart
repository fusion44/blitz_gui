library docker.containers;

import 'dart:async';

import 'package:regtest_core/core.dart';

import '../arg_builder.dart';

enum ClnConnectionMode { gRPC, jRPC }

class BlitzApiOptions extends ContainerOptions {
  /// Can be one of LnNode and descendants or a BitcoinCore Container
  final String lnContainerId;
  final String btccContainerId;
  final String redisHost;
  final int redisPort;
  final int redisDB;
  final ClnConnectionMode clnMode;

  BlitzApiOptions({
    required super.name,
    required this.btccContainerId,
    this.lnContainerId = '',
    this.redisHost = 'redis',
    this.redisPort = 6379,
    this.redisDB = 0,
    this.clnMode = ClnConnectionMode.jRPC,
    super.image = 'blitz_api:latest',
    super.workDir = dockerDataDir,
  });

  /// factory with a fake Ln node
  factory BlitzApiOptions.empty() =>
      BlitzApiOptions(btccContainerId: '', name: '', lnContainerId: '');

  @override
  List<Object?> get props => [
        name,
        image,
        workDir,
        btccContainerId,
        redisHost,
        redisPort,
        redisDB,
      ];
}

class BlitzApiContainer extends DockerContainer {
  static const requirements = [ContainerType.bitcoinCore, ContainerType.redis];
  static const optionals = [ContainerType.cln, ContainerType.lnd];

  BlitzApiOptions opts;

  BlitzApiContainer({required this.opts}) : super(opts);

  @override
  ContainerType get type => ContainerType.blitzApi;

  @override
  Future<void> start() async {
    // docker run --restart on-failure --entrypoint sh /code/entrypoint.sh
    //    --publish "8822:80" --volume "/tmp/regtest-data:/root/data"
    //    -e "REDIS_HOST=redis" -e "REDIS_PORT=6379"
    //    -e "REDIS_DB=0" -e "LN_BACKEND=lnd1"
    //    --network workspace_network --name workspace_lnd1-blitz
    //    --detach blitz_api:latest

    final o = opts;
    setStatus(ContainerStatusMessage(ContainerStatus.starting, ''));

    final btcc = NetworkManager()
        .findContainerById<BitcoinCoreContainer>(o.btccContainerId);

    if (btcc == null) {
      throw StateError('BitcoinCore container not found');
    }

    final ln = NetworkManager().findContainerById<LnNode>(o.lnContainerId);

    final DockerArgBuilder argBuilder = _buildCoreArgs(btcc);

    if (ln == null) {
      argBuilder.addEnv('ln_node=none');
      logMessage('BAPI: Running in bitcoin only mode');
    } else if (ln.type == ContainerType.cln &&
        o.clnMode == ClnConnectionMode.gRPC) {
      _buildClnGrpcArgs(argBuilder, ln as CLNContainer);
    } else if (ln.type == ContainerType.cln &&
        o.clnMode == ClnConnectionMode.jRPC) {
      _buildClnJrpcArgs(ln, argBuilder);
    } else if (ln.type == ContainerType.lnd) {
      _buildLndArgs(argBuilder, ln as LndContainer);
    }

    if (ln != null) {
      argBuilder.addOption('--publish', '${8820 + ln.opts.id}:80');
    }

    argBuilder.addArg('--detach').addArg(image).addArg('/code/entrypoint.sh');

    if (dockerId.isNotEmpty) {
      await runDockerCommand(["start", dockerId]);
    } else {
      await prepareDataDir(dataPath);
      dockerId = await runDockerCommand(argBuilder.build());
      dockerId = dockerId.trim();
    }

    if (dockerId.isEmpty || dockerId.length != 65) {
      throw DockerException('Failed to start BlitzApi container: $dockerId');
    }

    super.subscribeLogs();
    running = true;
    setStatus(ContainerStatusMessage(ContainerStatus.started, ''));
  }

  DockerArgBuilder _buildCoreArgs(BitcoinCoreContainer btcc) {
    return DockerArgBuilder()
        .addArg('run')
        .addOption('--restart', 'on-failure')
        .addOption('--entrypoint', 'sh')
        .addOption('--volume', '$dockerDataDir:/root/data')
        .addOption('--network', projectNetwork)
        .addOption('--name', name)
        .addEnv('REDIS_HOST=${opts.redisHost}')
        .addEnv('REDIS_PORT=${opts.redisPort}')
        .addEnv('REDIS_DB=${opts.redisDB}')
        .addEnv('bitcoind_ip_regtest=${btcc.name}')
        .addEnv('bitcoind_port_rpc_regtest=18443')
        .addEnv('bitcoind_user=regtester')
        .addEnv('bitcoind_pw=regtester');
  }

  void _buildClnGrpcArgs(DockerArgBuilder argBuilder, CLNContainer n) {
    argBuilder
        .addEnv('ln_node=cln_grpc')
        .addEnv('cln_grpc_cert=${n.gRPCCert}')
        .addEnv('cln_grpc_key=${n.gRPCClientKey}')
        .addEnv('cln_grpc_ca=${n.gRPCCACert}')
        .addEnv('cln_grpc_ip=${n.name}')
        .addEnv('cln_grpc_port=${n.gRPCPort}');
  }

  void _buildLndArgs(DockerArgBuilder argBuilder, LndContainer n) {
    argBuilder
        .addEnv('ln_node=lnd_grpc')
        .addEnv('lnd_macaroon="${n.adminMacaroonPath}')
        .addEnv('lnd_cert="${n.tlsCertPath}')
        .addEnv('lnd_grpc_ip="${n.name}')
        .addEnv('lnd_grpc_port="${n.gRPCPort}')
        .addEnv('lnd_rest_port="${n.restPort}');
  }

  void _buildClnJrpcArgs(LnNode ln, DockerArgBuilder argBuilder) {
    final n = ln as CLNContainer;
    argBuilder
        .addEnv('ln_node=cln_jrpc')
        .addEnv('cln_jrpc_path=${n.jRPCFilePath}');
  }
}
