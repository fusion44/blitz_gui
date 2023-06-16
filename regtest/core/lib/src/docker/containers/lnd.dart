library docker.containers;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:regtest_core/core.dart';

import '../arg_builder.dart';
import '../exceptions.dart';

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
    final o = opts;

    setStatus(ContainerStatusMessage(ContainerStatus.starting, ''));
    final argBuilder = DockerArgBuilder()
        .addArg('run')
        .addOption('--restart', 'always')
        .addOption('--expose', '${8081 + o.id}')
        .addOption('--expose', '$_gRPCPort')
        .addArg('--publish-all')
        .addOption('--volume', '$dataPath:/root/.lnd/')
        .addOption('--network', projectNetwork)
        .addOption('--name', name)
        .addArg('--detach')
        .addArg(image)
        .addArg('--alias=$o.alias')
        .addArg('--listen=$name:9735')
        .addArg('--rpclisten=$name:$_gRPCPort')
        .addArg('--restlisten=$name:$_restPort')
        .addArg('--bitcoin.active')
        .addArg('--bitcoin.regtest')
        .addArg('--bitcoin.node=bitcoind')
        .addArg('--bitcoind.rpchost=${o.btccContainerId}')
        .addArg('--bitcoind.zmqpubrawtx=tcp://${o.btccContainerId}:29000')
        .addArg('--bitcoind.zmqpubrawblock=tcp://${o.btccContainerId}:29001')
        .addArg('--bitcoind.rpcuser=regtester')
        .addArg('--bitcoind.rpcpass=regtester')
        .addArg('--noseedbackup')
        .addArg('--protocol.wumbo-channels')
        .addArg('--tlsextraip=127.0.0.1')
        .addArg('--tlsextraip=0.0.0.0')
        .addArg('--tlsextradomain=localhost')
        .addArg('--tlsextradomain=$name');

    final result = await Process.start(
      'docker',
      argBuilder.build(),
      workingDirectory: workDir,
    );

    dockerId = await Future.any([
      result.stderr.transform(utf8.decoder).asBroadcastStream().first,
      result.stdout.transform(utf8.decoder).asBroadcastStream().first
    ]);
    dockerId = dockerId.trim();

    if (dockerId.isEmpty || dockerId.length != 65) {
      throw DockerException('Failed to start LND container: $dockerId');
    }

    super.subscribeLogs();

    setStatus(ContainerStatusMessage(ContainerStatus.started, ''));
  }

  @override
  List<String> bootstrapCommands() => [
        ...super.bootstrapCommands(),
        'alias lncli="lncli --network regtest --rpcserver=localhost:$_gRPCPort"\n',
      ];
}
