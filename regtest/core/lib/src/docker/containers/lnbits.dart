library docker.containers;

import 'dart:async';
import 'dart:io';

import '../../constants.dart';
import '../../utils.dart';
import '../arg_builder.dart';
import '../docker.dart';

class LNbitsOptions extends ContainerOptions {
  LNbitsOptions({
    String? name,
    super.image = "lnbitsdocker/lnbits-legend",
    super.workDir = dockerDataDir,
  }) : super(name: name ?? '${projectName}_${generateRandomName()}');
}

class LNbitsContainer extends DockerContainer {
  LNbitsOptions opts;

  LNbitsContainer(this.opts) : super(opts);

  factory LNbitsContainer.defaultOptions() => LNbitsContainer(LNbitsOptions());

  @override
  ContainerType get type => ContainerType.lnbits;

  @override
  Future<void> start() async {
    setStatus(ContainerStatusMessage(ContainerStatus.starting, ""));
    // docker run --restart on-failure --entrypoint sh -c 'sleep 30; poetry run lnbits'
    // --entrypoint sh -c 'sleep 30; poetry run lnbits' --environment "HOST=lnbits"
    // --environment "PORT=5001" --environment "DEBUG=True"
    // --environment "LNBITS_BACKEND_WALLET_CLASS=LndRestWallet"
    // --environment "LNBITS_DATA_FOLDER=./data"
    // --environment "LND_REST_ENDPOINT=http://lnd3:8081/"
    // --environment "LND_REST_CERT=./lnd/tls.cert"
    // --environment "LND_REST_MACAROON=./lnd/data/chain/bitcoin/regtest/admin.macaroon"
    // --publish "5001:5001" --volume "lnbits-data:/app/data"
    //--volume "./data/lnd3:/app/lnd:uid=1000,gid=1000"
    //--network workspace_network --name workspace_lnbits --detach
    // lnbitsdocker/lnbits-legend

    final argBuilder = DockerArgBuilder()
        .addArg("run")
        .addOption('--restart', 'on-failure')
        .addOption('--entrypoint', 'sh -c "sleep 30; poetry run lnbits"')
        .addOption('--expose', '5001')
        .addArg('--publish-all')
        .addOption('--network', projectNetwork)
        .addOption('--name', containerName)
        .addOption('--volume', '$dataPath:/root/.cashu/')
        .addOption('--volume', './data/lnd3:/app/lnd:uid=1000,gid=1000')
        .addEnv('HOST=$containerName')
        .addEnv('PORT=5001')
        .addEnv('DEBUG=true')
        .addEnv('LNBITS_BACKEND_WALLET_CLASS="LndRestWallet"')
        .addEnv('LNBITS_DATA_FOLDER="./data"')
        .addEnv('LND_REST_ENDPOINT="http://lnd3:8081/"')
        .addEnv('LND_REST_CERT="./lnd/tls.cert"')
        .addEnv(
          'LND_REST_MACAROON=./lnd/data/chain/bitcoin/regtest/admin.macaroon"',
        )
        .addArg('--detach')
        .addArg(image);

    final result = await Process.run(
      'docker',
      argBuilder.build(),
      workingDirectory: workDir,
    );

    if (result.exitCode != 0) {
      throw DockerException(
        "Failed to start container $containerName. Error: ${result.stderr.toString()}",
      );
    }

    dockerId = result.stdout as String;
    dockerId = dockerId.trim();

    setStatus(ContainerStatusMessage(ContainerStatus.started, ''));

    super.subscribeLogs();
  }

  @override
  Future<void> stop() async {}
}
