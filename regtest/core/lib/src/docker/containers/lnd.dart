library docker.containers;

import 'dart:async';

import 'package:regtest_core/core.dart';

import '../arg_builder.dart';

class LndOptions extends LnNodeOptions {
  LndOptions({
    String? name,
    super.image = 'boltz/lnd:0.16.2-beta',
    super.alias = '',
    super.btccContainerId = '',
    super.workDir = dockerDataDir,
    int id = 0,
  })  : assert(id >= 0),
        super(name: name ?? '${projectName}_lnd_$id', id: id);

  LndOptions copyWith({
    String? name,
    String? image,
    String? alias,
    String? btccContainerId,
    String? workDir,
    int? id,
  }) {
    return LndOptions(
      name: name ?? this.name,
      image: image ?? this.image,
      alias: alias ?? this.alias,
      btccContainerId: btccContainerId ?? this.btccContainerId,
      workDir: workDir ?? this.workDir,
      id: id ?? this.id,
    );
  }
}

class LndContainer extends LnNode {
  late final LndOptions lndOpts;
  final int _gRPCPort;
  final int _restPort;

  LndContainer({required this.lndOpts, final Function()? onDeleted})
      : _gRPCPort = 11109 + lndOpts.id,
        _restPort = 8081 + lndOpts.id,
        super(opts: lndOpts, onDeleted: onDeleted);

  // This private constructor is only available for instantiating from
  // an actual running docker container. At this point we do have an internalId
  // already defined and we won't create a new one.
  LndContainer._(
    this.lndOpts,
    ContainerData cd,
    final Function()? onDeleted,
  )   : _gRPCPort = 11109 + lndOpts.id,
        _restPort = 8081 + lndOpts.id,
        super(
          opts: lndOpts,
          internalId: cd.internalId,
          onDeleted: onDeleted,
        ) {
    dockerId = cd.dockerId.trim();
    setStatus(ContainerStatusMessage(cd.status, ''));
  }

  factory LndContainer.defaultOptions() => LndContainer(lndOpts: LndOptions());

  static Future<LndContainer> fromRunningContainer(
      ContainerData c, Function()? onDeleted) async {
    final newContainer =
        LndContainer._(LndOptions(name: c.name, image: c.image), c, onDeleted);
    await newContainer.subscribeLogs();
    return newContainer;
  }

  @override
  ContainerType get type => ContainerType.lnd;
  int get gRPCPort => _gRPCPort;
  int get restPort => _restPort;
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
        .addOption('--expose', '${8081 + o.id}')
        .addOption('--expose', '$_gRPCPort')
        .addArg('--publish-all')
        .addOption('--volume', '$dataPath:/root/.lnd/')
        .addOption('--network', projectNetwork)
        .addOption('--name', containerName)
        .addArg('--detach')
        .addArg(image)
        .addArg('--alias=$alias')
        .addArg('--listen=0.0.0.0:9735')
        .addArg('--rpclisten=0.0.0.0:$_gRPCPort')
        .addArg('--restlisten=0.0.0.0:$_restPort')
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
