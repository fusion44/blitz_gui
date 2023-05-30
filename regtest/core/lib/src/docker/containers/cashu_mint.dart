library docker.containers;

import 'dart:async';
import 'dart:io';

import '../../constants.dart';
import '../arg_builder.dart';
import '../docker.dart';
import '../exceptions.dart';

class CashuMintContainer extends DockerContainer {
  CashuMintContainer({
    name = defaultCashMintName,
    image = "cashu:0.12.0",
  }) : super(name, image);

  @override
  Future<void> start() async {
    statusCtrl.add(ContainerStatusMessage(ContainerStatus.starting, ""));
    final argBuilder = DockerArgBuilder()
        .addArg("run")
        .addOption('--restart', 'on-failure')
        .addOption('--expose', '3338')
        .addOption('--publish-all')
        .addOption('--network', projectNetwork)
        .addOption('--name', containerName)
        .addOption('--volume', '$dataPath:/root/.cashu/')
        .addOption('--detach')
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

    containerId = result.stdout as String;
    containerId = containerId?.trim();

    statusCtrl.add(ContainerStatusMessage(ContainerStatus.started, ''));

    super.subscribeLogs();
  }

  @override
  Future<void> stop() async {}
}
