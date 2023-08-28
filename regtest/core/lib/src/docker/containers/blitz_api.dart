library docker.containers;

import 'dart:async';

import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:regtest_core/core.dart';

import '../../regtest_bapi_subscription_repo.dart';
import '../arg_builder.dart';

enum ClnConnectionMode { gRPC, jRPC }

class BlitzApiOptions extends ContainerOptions {
  /// Can be one of LnNode and descendants or a BitcoinCore Container
  final String lnContainerId;
  final String btccContainerId;
  final String redisHost;
  final int redisPort;
  final int redisDB;
  final int apiRestPort;
  final ClnConnectionMode clnMode;

  BlitzApiOptions({
    required super.name,
    required this.btccContainerId,
    required this.redisHost,
    required this.apiRestPort,
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
        apiRestPort: 0,
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
  static const portRange = ValueRange(8800, 8899);

  BlitzApiOptions opts;

  bool _apiInitialized = false;
  bool get bootstrapped => _apiInitialized;
  late final BlitzApiClient _api;
  String? _token;
  String? get token => _token;
  BlitzApiClient get api {
    if (!_apiInitialized) {
      throw Exception("Node $containerName not initialized");
    }

    return _api;
  }

  late final RegtestBapiSubRepo _repo;
  RegtestBapiSubRepo get subRepo {
    if (!_apiInitialized) {
      throw Exception("Node $containerName not initialized");
    }

    return _repo;
  }

  final _apiInitializedCompleter = Completer();

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
    String? btccId;
    String? redisHost;
    int? redisDb;
    String lnContainerId = '';
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
      } else if (!e.contains('ln_node=none')) {
        final spl = c.name.split('___');
        if (spl.length != 3) {
          throw StateError('Invalid BlitzAPI container name: ${c.name}');
        }

        lnContainerId = spl[1];
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

    if (!c.inspectData.containsKey('NetworkSettings') ||
        !c.inspectData['NetworkSettings'].containsKey('Ports')) {
      throw StateError('NetworkSettings or Port keys not found');
    }

    final ports = c.inspectData['NetworkSettings']['Ports'] as Map;

    if (ports.length > 1) {
      throw StateError('Multiple ports found');
    }

    int port = 0;
    if (ports.isNotEmpty) {
      port = int.tryParse(ports.values.first.first['HostPort']) ?? -1;
    }

    if (port < 0) {
      throw StateError('Unable to determine REST port from container info.');
    }

    final newContainer = BlitzApiContainer._(
      BlitzApiOptions(
        name: c.name,
        btccContainerId: btccId,
        image: c.image,
        redisHost: redisHost,
        redisDB: redisDb,
        apiRestPort: port,
        lnContainerId: lnContainerId,
      ),
      c,
      onDeleted,
    );
    await newContainer.subscribeLogs();
    await newContainer.initApi();

    if (c.status == ContainerStatus.started) {
      newContainer.running = true;
    }

    return newContainer;
  }

  @override
  ContainerType get type => ContainerType.blitzApi;

  int get restPort => opts.apiRestPort;

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

    argBuilder.addOption(
      '--publish',
      '${opts.apiRestPort}:80',
      omit: opts.apiRestPort == 0,
    );

    usedPorts.add(opts.apiRestPort);

    argBuilder.addArg('--detach').addArg(image);

    if (dockerId.isNotEmpty) {
      await runDockerCommand(["start", dockerId]);
    } else {
      await prepareDataDir(dataPath);
      dockerId = await runDockerCommand(argBuilder.build());
      dockerId = dockerId.trim();
    }

    if (dockerId.isEmpty) {
      throw DockerException('Failed to start BlitzApi container: $dockerId');
    }

    await super.subscribeLogs();
    await initApi();

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
          'lnd_macaroon=/root/data/${n.containerName}/data/chain/bitcoin/regtest/admin.macaroon',
        )
        .addEnv('lnd_cert=/root/data/${n.containerName}/tls.cert')
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

  Future<void> initApi({String host = 'localhost', String path = ''}) async {
    if (_apiInitialized) {
      throw Exception("API for $containerName already initialized");
    }

    final url = 'http://$host:${opts.apiRestPort}$path';
    _api = BlitzApiClient(basePathOverride: '$url/latest');
    _api.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) {
          if (_token != null && _token!.isNotEmpty) {
            options.headers["AUTHORIZATION"] = _token;
          }
          handler.next(options);
        },
      ),
    );

    final api = _api.getSystemApi();
    final builder = LoginInputBuilder()..password = "12345678";

    try {
      final response = await api.systemLoginSystemLoginPost(
        loginInput: builder.build(),
      );

      final data = response.data;
      if (data == null || data.value is! String) {
        throw StateError("Login response data was null");
      }

      _token = "Bearer ${data.value.toString()}";

      _repo = RegtestBapiSubRepo(url, _token!);
      await _repo.init();

      _apiInitialized = true;
      _apiInitializedCompleter.complete();
    } on DioError catch (e) {
      printDioError(
        e,
        'Node $containerName: Exception when calling SystemApi->systemLoginSystemLoginPost',
      );
    }

    logMessage(
      "Initialized $containerName using ${_api.dio.options.baseUrl}",
    );
  }

  Future<void> ensureApiInitialized() async {
    if (_apiInitialized) return;

    return _apiInitializedCompleter.future;
  }

  Future<String> newLightningAddress() async {
    if (opts.lnContainerId == '') {
      // Bitcoin only
      throw StateError('This is a Bitcoin only node.');
    }

    try {
      final builder = NewAddressInputBuilder()..type = OnchainAddressType.p2wkh;

      final resp = await _api
          .getLightningApi()
          .lightningNewAddressLightningNewAddressPost(
              newAddressInput: builder.build());

      final d = resp.data;
      if (resp.statusCode == 200 && d != null) return d;

      throw Exception(
        "Failed to get new address, status code: ${resp.statusCode}, ${resp.statusMessage}",
      );
    } catch (e) {
      throw Exception("Failed to get new address: $e");
    }
  }
}
