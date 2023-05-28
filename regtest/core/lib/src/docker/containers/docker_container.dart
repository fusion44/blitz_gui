library docker.containers;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';

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

class StatusMessage {
  final ContainerStatus status;
  final String message;

  StatusMessage(this.status, this.message);

  @override
  String toString() {
    return "StatusMessage($status, $message)";
  }
}

abstract class DockerContainer {
  final String workDir;
  final String containerName;
  final String image;
  String? containerId;

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
  final statusCtrl = StreamController<StatusMessage>.broadcast();

  DockerContainer(this.containerName, this.image,
      {this.workDir = dockerDataDir});

  String get dataPath => '$workDir/$containerName';
  Stream<StatusMessage> get statusStream => statusCtrl.stream;
  Stream<String> get logStream => logCtrl.stream;

  Future<void> start() async {
    throw UnimplementedError();
  }

  Future<void> stop() async {
    throw UnimplementedError();
  }

  @mustCallSuper
  Future<void> delete() async {
    stdOutSub?.cancel();
    stdOutSub = null;
    stdErrSub?.cancel();
    stdErrSub = null;
  }

  @override
  String toString() {
    return "DockerContainer($containerName, $image)";
  }

  @protected
  Future<void> subscribeLogs() async {
    if (containerId == null || containerId!.isEmpty) {
      throw StateError('Container not started');
    }

    if (stdOut != null ||
        stdErr != null ||
        stdOutSub != null ||
        stdErrSub != null) {
      throw StateError('Logs already subscribed');
    }

    final proc = await Process.start('docker', ['logs', '-f', containerId!]);

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
}