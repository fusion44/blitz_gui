library docker.containers;

import 'dart:async';

import '../../constants.dart';
import '../../utils.dart';
import '../arg_builder.dart';
import '../docker.dart';

class RedisOptions extends ContainerOptions {
  const RedisOptions({
    super.name = defaultRedisName,
    super.image = "redis:7.0.5",
  });
}

class RedisContainer extends DockerContainer {
  RedisContainer({opts = const RedisOptions()}) : super(opts);

  // This private constructor is only available for instantiating from
  // an actual running docker container. At this point we do have an internalId
  // already defined and we won't create a new one.
  RedisContainer._(
    RedisOptions opts,
    ContainerData cd,
    final Function()? onDeleted,
  ) : super(
          opts,
          internalId: cd.internalId,
          onDeleted: onDeleted,
        ) {
    dockerId = cd.dockerId.trim();
    setStatus(ContainerStatusMessage(cd.status, ''));
  }

  static Future<RedisContainer> fromRunningContainer(
      ContainerData c, Function()? onDeleted) async {
    final newContainer = RedisContainer._(
      RedisOptions(name: c.name, image: c.image),
      c,
      onDeleted,
    );
    await newContainer.subscribeLogs();

    if (c.status == ContainerStatus.started) {
      newContainer.running = true;
    }

    return newContainer;
  }

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

    if (dockerId.isEmpty) {
      throw DockerException('Failed to start Redis container: $dockerId');
    }

    running = true;
    setStatus(ContainerStatusMessage(ContainerStatus.started, ''));
    super.subscribeLogs();
  }
}
