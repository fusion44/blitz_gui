library docker.containers;

import 'dart:async';
import 'dart:io';

import '../../constants.dart';
import '../arg_builder.dart';
import '../docker.dart';
import '../exceptions.dart';

class LNbitsOptions extends ContainerOptions {
  const LNbitsOptions({
    super.name = defaultLNbitsName,
    super.image = "lnbitsdocker/lnbits-legend",
    super.workDir = dockerDataDir,
  });
}

class LNbitsContainer extends DockerContainer {
  LNbitsOptions opts;

  LNbitsContainer({this.opts = const LNbitsOptions()}) : super(opts);

  @override
  ContainerType get type => ContainerType.lnbits;

  @override
  Future<void> start() async {
    statusCtrl.add(ContainerStatusMessage(ContainerStatus.starting, ""));
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
        .addOption('--publish-all')
        .addOption('--network', projectNetwork)
        .addOption('--name', name)
        .addOption('--volume', '$dataPath:/root/.cashu/')
        .addOption('--volume', './data/lnd3:/app/lnd:uid=1000,gid=1000')
        .addEnv('HOST=$name')
        .addEnv('PORT=5001')
        .addEnv('DEBUG=true')
        .addEnv('LNBITS_BACKEND_WALLET_CLASS="LndRestWallet"')
        .addEnv('LNBITS_DATA_FOLDER="./data"')
        .addEnv('LND_REST_ENDPOINT="http://lnd3:8081/"')
        .addEnv('LND_REST_CERT="./lnd/tls.cert"')
        .addEnv(
          'LND_REST_MACAROON=./lnd/data/chain/bitcoin/regtest/admin.macaroon"',
        )
        .addOption('--detach')
        .addArg(image);

    final result = await Process.run(
      'docker',
      argBuilder.build(),
      workingDirectory: workDir,
    );

    if (result.exitCode != 0) {
      throw DockerException(
        "Failed to start container $name. Error: ${result.stderr.toString()}",
      );
    }

    dockerId = result.stdout as String;
    dockerId = dockerId.trim();

    statusCtrl.add(ContainerStatusMessage(ContainerStatus.started, ''));

    super.subscribeLogs();
  }

  @override
  Future<void> stop() async {}
}
