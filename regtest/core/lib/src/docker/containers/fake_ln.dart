library docker.containers;

import 'dart:async';

import 'package:regtest_core/core.dart';

class FakeLnOptions extends LnNodeOptions {
  FakeLnOptions({
    String? name,
    super.image = 'boltz/c-lightning:23.02.2',
    super.btccContainerId = '',
    super.workDir = dockerDataDir,
  }) : super(
          ContainerType.fakeLn,
          name: name ?? '${projectName}_${generateRandomName()}',
        );
}

class FakeLnContainer extends LnContainer {
  FakeLnContainer(super.opts);

  factory FakeLnContainer.defaultOptions() => FakeLnContainer(FakeLnOptions());

  @override
  ContainerType get type => ContainerType.fakeLn;

  @override
  Future<void> start() async {
    setStatus(ContainerStatusMessage(ContainerStatus.starting, ''));

    await Future.delayed(Duration(seconds: 1));
    setStatus(ContainerStatusMessage(ContainerStatus.starting, 'Step 1'));

    await Future.delayed(Duration(seconds: 1));
    setStatus(ContainerStatusMessage(ContainerStatus.starting, 'Step 2'));

    await Future.delayed(Duration(seconds: 1));
    setStatus(ContainerStatusMessage(ContainerStatus.started, 'Up'));
  }

  @override
  Future<void> stop() async {}
}
