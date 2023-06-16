library docker.containers;

import 'dart:async';

import 'package:regtest_core/core.dart';

class FakeLnOptions extends LnNodeOptions {
  FakeLnOptions({
    String? name,
    super.image = 'boltz/c-lightning:23.02.2',
    super.alias = '',
    super.btccContainerId = '',
    super.workDir = dockerDataDir,
    int id = 0,
  })  : assert(id >= 0),
        super(name: name ?? '${projectName}_cln_$id', id: id);
}

class FakeLnContainer extends LnNode {
  FakeLnContainer({required super.opts});

  factory FakeLnContainer.defaultOptions() =>
      FakeLnContainer(opts: FakeLnOptions());

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
