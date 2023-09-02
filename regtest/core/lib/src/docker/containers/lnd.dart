library docker.containers;

import 'dart:async';
import 'dart:convert';

import 'package:common/common.dart';
import 'package:regtest_core/core.dart';

import '../arg_builder.dart';

class LndOptions extends LnNodeOptions {
  final int? gRPCPort;
  final int? restPort;

  LndOptions({
    String? name,
    super.image = 'boltz/lnd:0.16.2-beta',
    super.alias = '',
    super.btccContainerId = '',
    super.workDir = dockerDataDir,
    this.gRPCPort,
    this.restPort,
  }) : super(name: name ?? '${projectName}_${generateRandomName()}');

  LndOptions copyWith({
    String? name,
    String? image,
    String? alias,
    String? btccContainerId,
    String? workDir,
    int? gRPCPort,
    int? restPort,
  }) {
    return LndOptions(
      name: name ?? this.name,
      image: image ?? this.image,
      alias: alias ?? this.alias,
      btccContainerId: btccContainerId ?? this.btccContainerId,
      workDir: workDir ?? this.workDir,
      gRPCPort: gRPCPort ?? this.gRPCPort,
      restPort: restPort ?? this.restPort,
    );
  }
}

class LndContainer extends LnNode {
  static const grpcPortRange = ValueRange(10009, 10080 + 50);
  static const restPortRange = ValueRange(8080, 8080 + 50);

  late final LndOptions lndOpts;
  final int? _gRPCPort;
  final int? _restPort;

  LndContainer(this.lndOpts, {final Function()? onDeleted})
      : _gRPCPort = lndOpts.gRPCPort,
        _restPort = lndOpts.restPort,
        super(lndOpts, onDeleted: onDeleted) {
    bootstrapCli();
  }

  // This private constructor is only available for instantiating from
  // an actual running docker container. At this point we do have an internalId
  // already defined and we won't create a new one.
  LndContainer._(
    this.lndOpts,
    ContainerData cd,
    final Function()? onDeleted,
  )   : _gRPCPort = lndOpts.gRPCPort,
        _restPort = lndOpts.restPort,
        super(lndOpts, internalId: cd.internalId, onDeleted: onDeleted) {
    running = true;
    dockerId = cd.dockerId.trim();
    bootstrapCli();
    setStatus(ContainerStatusMessage(cd.status, ''));
  }

  factory LndContainer.defaultOptions() => LndContainer(LndOptions());

  static Future<LndContainer> fromRunningContainer(
    ContainerData c,
    Function()? onDeleted,
  ) async {
    final cmd = c.inspectData['Config']['Cmd'] as List;
    final int gRPCPort = int.tryParse(cmd[2].split(':')[1]) ?? -1;
    final int restPort = int.tryParse(cmd[3].split(':')[1]) ?? -1;

    if (gRPCPort < 0 || restPort < 0) {
      throw Exception('Invalid port number');
    }

    await PortManager().setPortUsed(gRPCPort);
    await PortManager().setPortUsed(restPort);

    final newContainer = LndContainer._(
      LndOptions(
        name: c.name,
        image: c.image,
        restPort: restPort,
        gRPCPort: gRPCPort,
      ),
      c,
      onDeleted,
    );
    await newContainer.subscribeLogs();
    return newContainer;
  }

  @override
  ContainerType get type => ContainerType.lnd;
  int? get gRPCPort => _gRPCPort;
  int? get restPort => _restPort;
  String get adminMacaroonPath =>
      '$dataPath/data/chain/bitcoin/regtest/admin.macaroon';
  String get tlsCertPath => '$dataPath/tls.cert';

  @override
  Future<void> start() async {
    if (dockerId.isNotEmpty) {
      await runDockerCommand(["start", dockerId]);
    } else {
      await prepareDataDir(dataPath);
      dockerId = await runDockerCommand(_buildRunDockerArgs());
      dockerId = dockerId.trim();

      if (dockerId.isEmpty || dockerId.length != 64) {
        throw DockerException('Failed to start LND container: $dockerId');
      }

      super.subscribeLogs();
    }

    setStatus(ContainerStatusMessage(ContainerStatus.started, ''));
  }

  @override
  Future<void> bootstrapCli() async {
    // docker exec lnbits-legend-lnd-$i-1 lncli --network regtest --rpcserver=lnd-$i:10009 "$@"
    if (!running) return;
    try {
      final res = await execCommand(
        'lncli --network regtest --rpcserver=$containerName:$_gRPCPort getinfo'
            .split(' '),
      );
      final json = jsonDecode(res);
      pubKey = json['identity_pubkey'];
    } on DockerException catch (e) {
      print(e.message);
    }

    return super.bootstrapCli();
  }

  @override
  List<String> bootstrapCommands() => [
        ...super.bootstrapCommands(),
        'alias lncli="lncli --network regtest --rpcserver=$containerName:$_gRPCPort"\n',
      ];

  List<String> _buildRunDockerArgs() {
    final o = opts;
    final btcc = NetworkManager().findContainerById<BitcoinCoreContainer>(
      opts.btccContainerId,
    );

    if (btcc == null) {
      throw StateError(
        'BitcoinCoreContainer with ID ${opts.btccContainerId} not found',
      );
    }

    setStatus(ContainerStatusMessage(ContainerStatus.starting, ''));
    String alias = o.alias.isNotEmpty ? o.alias : o.name;

    return DockerArgBuilder()
        .addArg('run')
        .addOption('--restart', 'always')
        .addOption('--expose', _gRPCPort, omit: _gRPCPort == null)
        .addOption('--expose', _restPort, omit: _restPort == null)
        .addArg('--publish-all')
        .addOption('--volume', '$dataPath:/root/.lnd/')
        .addOption('--network', projectNetwork)
        .addOption('--name', containerName)
        .addArg('--detach')
        .addArg(image)
        .addArg('--alias=$alias')
        .addArg('--listen=0.0.0.0:9735')
        .addArg('--rpclisten=0.0.0.0:$_gRPCPort', omit: _gRPCPort == null)
        .addArg('--restlisten=0.0.0.0:$_restPort', omit: _restPort == null)
        .addArg('--bitcoin.active')
        .addArg('--bitcoin.regtest')
        .addArg('--bitcoin.node=bitcoind')
        .addArg('--bitcoind.rpchost=${btcc.containerName}')
        .addArg('--bitcoind.zmqpubrawtx=tcp://${btcc.containerName}:29000')
        .addArg('--bitcoind.zmqpubrawblock=tcp://${btcc.containerName}:29001')
        .addArg('--bitcoind.rpcuser=regtester')
        .addArg('--bitcoind.rpcpass=regtester')
        .addArg('--noseedbackup')
        .addArg('--protocol.wumbo-channels')
        .addArg('--tlsextraip=127.0.0.1')
        .addArg('--tlsextraip=0.0.0.0')
        .addArg('--tlsextradomain=localhost')
        .addArg('--tlsextradomain=$containerName')
        .build();
  }
}
