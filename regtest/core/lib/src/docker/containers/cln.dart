library docker.containers;

import 'dart:async';
import 'dart:convert';

import 'package:common/common.dart';
import 'package:regtest_core/core.dart';

import '../arg_builder.dart';

class ClnOptions extends LnNodeOptions {
  final int? gRPCPort;

  ClnOptions({
    String? name,
    super.image = 'boltz/c-lightning:23.02.2',
    super.alias = '',
    super.btccContainerId = '',
    super.workDir = dockerDataDir,
    this.gRPCPort,
  }) : super(
          ContainerType.cln,
          name: name ?? '${projectName}_${generateRandomName()}',
        );

  ClnOptions copyWith({
    String? name,
    String? image,
    String? alias,
    String? btccContainerId,
    String? workDir,
    int? gRPCPort,
  }) {
    return ClnOptions(
      name: name ?? this.name,
      image: image ?? this.image,
      alias: alias ?? this.alias,
      btccContainerId: btccContainerId ?? this.btccContainerId,
      workDir: workDir ?? this.workDir,
      gRPCPort: gRPCPort ?? this.gRPCPort,
    );
  }
}

class ClnContainer extends LnContainer {
  static const grpcPortRange = ValueRange(10509, 10580 + 50);

  final int? _gRPCPort;
  final ClnOptions clnOpts;
  ClnContainer(this.clnOpts)
      : _gRPCPort = clnOpts.gRPCPort,
        super(clnOpts) {
    bootstrapCli();
  }

  // This private constructor is only available for instantiating from
  // an actual running docker container. At this point we do have an internalId
  // already defined and we won't create a new one.
  ClnContainer._(
    this.clnOpts,
    ContainerData cd,
    final Function()? onDeleted,
  )   : _gRPCPort = clnOpts.gRPCPort,
        super(clnOpts, internalId: cd.internalId, onDeleted: onDeleted) {
    running = true;
    dockerId = cd.dockerId.trim();
    bootstrapCli();
    setStatus(ContainerStatusMessage(cd.status, ''));
  }

  factory ClnContainer.defaultOptions() => ClnContainer(ClnOptions());

  static Future<ClnContainer> fromRunningContainer(
    ContainerData c,
    Function()? onDeleted,
  ) async {
    final cmd = c.inspectData['Config']['Cmd'] as List;
    final int gRPCPort = int.tryParse(cmd[8].split('=')[1]) ?? -1;

    if (gRPCPort < 0) {
      throw Exception('Invalid port number');
    }

    await PortManager().setPortUsed(gRPCPort);

    final newContainer = ClnContainer._(
      ClnOptions(name: c.name, image: c.image, gRPCPort: gRPCPort),
      c,
      onDeleted,
    );
    await newContainer.subscribeLogs();

    return newContainer;
  }

  @override
  ContainerType get type => ContainerType.cln;

  int? get gRPCPort => _gRPCPort;
  String get gRPCCert => '$dataPath/regtest/client.pem';
  String get gRPCClientKey => '$dataPath/regtest/client-key.pem';
  String get gRPCCACert => '$dataPath/regtest/ca.pem';
  String get jRPCFilePath => '$dataPath/regtest/lightning-rpc';

  @override
  Future<void> start() async {
    setStatus(ContainerStatusMessage(ContainerStatus.starting, ''));

    if (dockerId.isNotEmpty) {
      await runDockerCommand(['start', dockerId]);
    } else {
      await prepareDataDir(dataPath);
      dockerId = await runDockerCommand(_buildRunDockerArgs());
      dockerId = dockerId.trim();

      if (dockerId.isEmpty || dockerId.length != 64) {
        throw DockerException('Failed to start CLN container: $dockerId');
      }

      super.subscribeLogs();
    }

    setStatus(ContainerStatusMessage(ContainerStatus.started, ''));
  }

  @override
  Future<void> bootstrapCli() async {
    if (!running) return;
    try {
      final res = await execCommand(
        'lightning-cli --network regtest getinfo'.split(' '),
      );
      final json = jsonDecode(res);
      pubKey = json['id'];
    } on DockerException catch (e) {
      print(e.message);
    }

    return super.bootstrapCli();
  }

  List<String> _buildRunDockerArgs() {
    final btcc = NetworkManager().findContainerById<BitcoinCoreContainer>(
      opts.btccContainerId,
    );

    if (btcc == null) {
      throw StateError(
        'BitcoinCoreContainer with ID ${opts.btccContainerId} not found',
      );
    }

    final argBuilder = DockerArgBuilder()
        .addArg('run')
        .addOption('--restart', 'on-failure')
        .addOption('--expose', 9735)
        .addOption('--expose', _gRPCPort, omit: _gRPCPort == null)
        .addArg('--publish-all')
        .addOption('--volume', '$dataPath:/root/.lightning/')
        .addOption('--network', projectNetwork)
        .addOption('--name', containerName)
        .addArg('--detach')
        .addArg(image)
        .addArg('--alias=${clnOpts.alias}')
        .addArg('--large-channels')
        .addArg('--network=regtest')
        .addArg('--bind-addr=0.0.0.0:9735')
        .addArg('--bitcoin-rpcconnect=${btcc.containerName}')
        .addArg('--bitcoin-rpcport=18443')
        .addArg('--bitcoin-rpcuser=regtester')
        .addArg('--bitcoin-rpcpassword=regtester')
        .addArg('--grpc-port=$_gRPCPort', omit: _gRPCPort == null);

    return argBuilder.build();
  }

  @override
  Future<void> stop() async {}

  @override
  List<String> bootstrapCommands() => [
        ...super.bootstrapCommands(),
        'alias lightning-cli="lightning-cli --network regtest"\n',
        'alias lcli="lightning-cli"\n'
      ];
}
