library docker.containers;

import 'dart:async';
import 'dart:io';

import '../../constants.dart';
import '../arg_builder.dart';
import '../docker.dart';
import '../exceptions.dart';

class RedisOptions extends ContainerOptions {
  const RedisOptions({
    super.name = defaultRedisName,
    super.image = "redis:7.0.5",
  });
}

class RedisContainer extends DockerContainer {
  RedisContainer({opts = const RedisOptions()}) : super(opts);

  @override
  ContainerType get type => ContainerType.redis;

  @override
  Future<void> start() async {
    statusCtrl.add(ContainerStatusMessage(ContainerStatus.starting, ""));
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

    dockerId = result.stdout as String;
    dockerId = dockerId.trim();

    statusCtrl.add(ContainerStatusMessage(ContainerStatus.started, ''));

    super.subscribeLogs();
  }

  @override
  Future<void> stop() async {}
}
