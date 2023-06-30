library docker.containers;

import 'dart:async';

import '../../constants.dart';
import '../../utils.dart';
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
    setStatus(ContainerStatusMessage(ContainerStatus.starting, ""));
    final argBuilder = DockerArgBuilder()
        .addArg("run")
        .addOption('--restart', 'on-failure')
        .addOption('--expose', '6379')
        .addOption('--network', projectNetwork)
        .addOption('--name', name)
        .addOption('--detach')
        .addArg(image);

    if (dockerId.isNotEmpty) {
      await runDockerCommand(["start", dockerId]);
    } else {
      await prepareDataDir(dataPath);
      dockerId = await runDockerCommand(argBuilder.build());
      dockerId = dockerId.trim();
    }

    if (dockerId.isEmpty || dockerId.length != 65) {
      throw DockerException('Failed to start BlitzApi container: $dockerId');
    }

    running = true;
    setStatus(ContainerStatusMessage(ContainerStatus.started, ''));
    super.subscribeLogs();
  }
}
