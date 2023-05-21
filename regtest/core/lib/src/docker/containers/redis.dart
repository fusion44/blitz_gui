library docker.containers;

import 'dart:async';
import 'dart:io';

import '../../constants.dart';
import '../arg_builder.dart';
import '../docker.dart';
import 'base.dart';

class RedisContainer extends DockerContainer {
  RedisContainer({
    name = defaultRedisName,
    image = "redis:7.0.5",
  }) : super(name, image);

  @override
  Future<void> start() async {
    statusCtrl.add(StatusMessage(ContainerStatus.starting, ""));
    final argBuilder = DockerArgBuilder()
        .addArg("run")
        .addOption('--restart', 'on-failure')
        .addOption('--expose', '6379')
        .addOption('--network', projectNetwork)
        .addOption('--name', name)
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

    containerId = result.stdout as String;
    containerId = containerId?.trim();

    statusCtrl.add(StatusMessage(ContainerStatus.started, ''));

    super.subscribeLogs();
  }

  @override
  Future<void> stop() async {}
}
