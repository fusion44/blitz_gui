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
    required this.redisHost,
    this.lnContainerId = '',
    this.redisPort = 6379,
    this.redisDB = 0,
    this.clnMode = ClnConnectionMode.jRPC,
    super.image = 'blitz_api:latest',
    super.workDir = dockerDataDir,
  });

  /// factory with a fake Ln node
  factory BlitzApiOptions.empty() => BlitzApiOptions(
        btccContainerId: '',
        name: '',
        lnContainerId: '',
        redisHost: '',
      );

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

  // This private constructor is only available for instantiating from
  // an actual running docker container. At this point we do have an internalId
  // already defined and we won't create a new one.
  BlitzApiContainer._(
    this.opts,
    ContainerData cd,
    final Function()? onDeleted,
  ) : super(
          opts,
          internalId: cd.internalId,
          onDeleted: onDeleted,
        ) {
    dockerId = cd.dockerId.trim();
    setStatus(ContainerStatusMessage(cd.status, ''));
  }

  static Future<BlitzApiContainer> fromRunningContainer(
    ContainerData c,
    Function()? onDeleted,
  ) async {
    final envList = c.inspectData['Config']['Env'];
    late final String? btccId;
    late final String? redisHost;
    late final int? redisDb;
    for (final String e in envList) {
      if (e.contains('REDIS_DB')) {
        final env = e.split('=');
        redisDb = int.parse(env[1]);
      } else if (e.contains('REDIS_HOST')) {
        final env = e.split('=');
        redisHost = env[1];
      } else if (e.contains('bitcoind_ip_regtest')) {
        final env = e.split('=');
        btccId = env[1].split(dockerContainerNameDelimiter)[1];
      }
    }

    if (btccId == null || btccId.isEmpty) {
      throw StateError('Bitcoin Core container ID not found');
    }

    if (redisHost == null || redisHost.isEmpty) {
      throw StateError('Redis Host container ID not found');
    }

    if (redisDb == null || redisDb < 0) {
      throw StateError('Redis DB not found');
    }

    final newContainer = BlitzApiContainer._(
      BlitzApiOptions(
        name: c.name,
        btccContainerId: btccId,
        image: c.image,
        redisHost: redisHost,
        redisDB: redisDb,
      ),
      c,
      onDeleted,
    );
    await newContainer.subscribeLogs();

    if (c.status == ContainerStatus.started) {
      newContainer.running = true;
    }

    return newContainer;
  }

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

    argBuilder.addArg('--detach').addArg(image);

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
        .addOption('--volume', '$dockerDataDir:/root/data')
        .addOption('--network', projectNetwork)
        .addOption('--name', containerName)
        .addEnv('secret=please_please_update_me_please')
        .addEnv('algorithm=HS256')
        .addEnv('jwt_expiry_time=999999999')
        .addEnv('login_password=12345678')
        .addEnv('enable_local_cookie_auth=true')
        .addEnv('gather_hw_info_interval = 60')
        .addEnv('cpu_usage_averaging_period=0.5')
        .addEnv('gather_ln_info_interval=5.0')
        .addEnv('shell_script_path = /root')
        .addEnv('log_level=DEBUG')
        .addEnv('log_file=blitz_api.log')
        .addEnv('REDIS_HOST=${opts.redisHost}')
        .addEnv('REDIS_PORT=${opts.redisPort}')
        .addEnv('REDIS_DB=${opts.redisDB}')
        .addEnv('bitcoind_ip_regtest=${btcc.containerName}')
        .addEnv('bitcoind_port_rpc_regtest=18443')
        .addEnv('bitcoind_zmq_block_rpc=rawblock')
        .addEnv('bitcoind_zmq_block_port_regtest=29001')
        .addEnv('bitcoind_user=regtester')
        .addEnv('bitcoind_pw=regtester')
        .addEnv('network=regtest')
        .addEnv('platform=native_python');
  }

  void _buildClnGrpcArgs(DockerArgBuilder argBuilder, CLNContainer n) {
    argBuilder
        .addEnv('ln_node=cln_grpc')
        .addEnv('cln_grpc_cert=${n.gRPCCert}')
        .addEnv('cln_grpc_key=${n.gRPCClientKey}')
        .addEnv('cln_grpc_ca=${n.gRPCCACert}')
        .addEnv('cln_grpc_ip=${n.containerName}')
        .addEnv('cln_grpc_port=${n.gRPCPort}');
  }

  void _buildLndArgs(DockerArgBuilder argBuilder, LndContainer n) {
    argBuilder
        .addEnv('ln_node=lnd_grpc')
        .addEnv(
          'lnd_macaroon=/root/data/${n.name}/data/chain/bitcoin/regtest/admin.macaroon',
        )
        .addEnv('lnd_cert=/root/data/${n.name}/tls.cert')
        .addEnv('lnd_grpc_ip=${n.containerName}')
        .addEnv('lnd_grpc_port=${n.gRPCPort}')
        .addEnv('lnd_rest_port=${n.restPort}');
  }

  void _buildClnJrpcArgs(LnNode ln, DockerArgBuilder argBuilder) {
    final n = ln as CLNContainer;
    argBuilder
        .addEnv('ln_node=cln_jrpc')
        .addEnv('cln_jrpc_path=${n.jRPCFilePath}');
  }
}
