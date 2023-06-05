library docker.containers;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:slugid/slugid.dart';

import '../../constants.dart';

enum ContainerStatus {
  uninitialized,
  starting,
  started,
  stopping,
  stopped,
  error,
  deleted,
}

class ContainerStatusMessage {
  final ContainerStatus status;
  final String message;

  ContainerStatusMessage(this.status, this.message);

  @override
  String toString() {
    return "StatusMessage($status, $message)";
  }
}

class ContainerOptions extends Equatable {
  final String name;
  final String image;
  final String workDir;

  const ContainerOptions({
    required this.name,
    required this.image,
    this.workDir = dockerDataDir,
  });

  @override
  List<Object?> get props => [name, image, workDir];
}

abstract class DockerContainer {
  /// The app internal reference ID of the container.
  ///
  /// The internal id is used to identify the container when it is not started
  /// yet and thus, no dockerId is available.
  final String internalId;

  /// The ID of the docker container. Becomes available only after
  /// the container is started.
  String dockerId = '';

  /// The directory to the local docker data directory.
  final String workDir;

  /// The image used for the container.
  final String image;

  /// True if the container was deleted and all resources freed
  bool deleted = false;

  // The name of the docket container.
  final String _name;

  @protected
  Stream<String>? stdOut;
  @protected
  StreamSubscription<String>? stdOutSub;
  @protected
  Stream<String>? stdErr;
  @protected
  StreamSubscription<String>? stdErrSub;
  @protected
  final logCtrl = StreamController<String>.broadcast();
  @protected
  final statusCtrl = StreamController<ContainerStatusMessage>.broadcast();

  ContainerStatusMessage _currentStatus;

  DockerContainer(ContainerOptions opts, {String? internalId})
      : _currentStatus =
            ContainerStatusMessage(ContainerStatus.uninitialized, ''),
        internalId = internalId ?? Slugid.v4().toString(),
        _name = opts.name,
        image = opts.image,
        workDir = opts.workDir;

  String get name => _name + dockerContainerNameDelimiter + internalId;
  String get dataPath => '$workDir/$_name';
  Stream<ContainerStatusMessage> get statusStream => statusCtrl.stream;
  Stream<String> get logStream => logCtrl.stream;
  ContainerStatusMessage get status => _currentStatus;
  ContainerType get type;

  Future<void> start();

  Future<void> stop();

  @mustCallSuper
  Future<void> delete() async {
    stdOutSub?.cancel();
    stdOutSub = null;
    stdErrSub?.cancel();
    stdErrSub = null;
    deleted = true;
  }

  @override
  String toString() {
    return 'DockerContainer{containerName: $name, image: $image, workDir: $workDir}';
  }

  @protected
  Future<void> subscribeLogs() async {
    if (dockerId.isEmpty) {
      throw StateError('Container not started');
    }

    if (stdOut != null ||
        stdErr != null ||
        stdOutSub != null ||
        stdErrSub != null) {
      throw StateError('Logs already subscribed');
    }

    final proc = await Process.start('docker', ['logs', '-f', dockerId]);

    stdOut = proc.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .asBroadcastStream();
    stdOutSub = stdOut?.listen(
      (line) => logCtrl.add(line),
    );

    stdErr = proc.stderr
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .asBroadcastStream();
    stdErrSub = stdErr?.listen(
      (line) => logCtrl.addError(line),
    );
  }

  void setStatus(ContainerStatusMessage status) {
    _currentStatus = status;
    statusCtrl.add(status);
  }
}
