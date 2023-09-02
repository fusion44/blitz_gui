library docker.containers;

import 'dart:async';
import 'dart:io';

import '../../constants.dart';
import '../../utils.dart';
import '../arg_builder.dart';
import '../docker.dart';

class CashuMintOptions extends ContainerOptions {
  CashuMintOptions({
    String? name,
    super.image = "cashu:0.12.0",
    super.workDir = dockerDataDir,
  }) : super(name: name ?? '${projectName}_${generateRandomName()}');
}

class CashuMintContainer extends DockerContainer {
  CashuMintOptions opts;

  CashuMintContainer(this.opts) : super(opts);

  @override
  ContainerType get type => ContainerType.cashuMint;

  @override
  Future<void> start() async {
    setStatus(ContainerStatusMessage(ContainerStatus.starting, ""));
    final argBuilder = DockerArgBuilder()
        .addArg("run")
        .addOption('--restart', 'on-failure')
        .addOption('--expose', '3338')
        .addArg('--publish-all')
        .addOption('--network', projectNetwork)
        .addOption('--name', containerName)
        .addOption('--volume', '$dataPath:/root/.cashu/')
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
