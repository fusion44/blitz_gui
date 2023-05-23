import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import 'exceptions.dart';

export 'containers/containers.dart';

Future<List<String>> getRunningContainerNames() async {
  final proc = await Process.run('docker', ['ps']);
  final output = <String>[];

  if (proc.exitCode != 0) {
    throw DockerException(
      "Failed to get container names. Error: ${proc.stderr.toString()}",
    );
  }

  proc.stdout.split("\n").forEach((line) {
    final spl = line.split(projectName);
    if (spl.length < 2) return;
    output.add("$projectName${spl[1]}");
  });

  return output;
}

Future<List<String>> getLogsFromDocker(
  String containerName, {
  int tail = 0,
}) async {
  final proc = await Process.run('docker', [
    'logs',
    if (tail > 0) ...['-n', tail.toString()],
    containerName,
  ]);
  final output = <String>[];

  if (proc.exitCode != 0) {
    throw DockerException(
        "Failed to get logs from docker. Error: ${proc.stderr.toString()}");
  }
  print(proc.stdout);
  output.addAll(proc.stdout.split("\n"));

  return output;
}

Future<Stream<String>> followDockerLogs(String container,
    {int tail = 0}) async {
  final proc = await Process.start('docker', [
    'logs',
    '-f',
    if (tail > 0) ...['-n', tail.toString()],
    container,
  ]);

  proc.stderr.transform(utf8.decoder).transform(const LineSplitter()).listen(
    (line) {
      print('Error while listening to $container logs: $line');
    },
  );

  return proc.stdout
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .asBroadcastStream();
}

enum DockerMessageType {
  stdout,
  stderr,
}

class DockerMessage {
  final String message;
  final DockerMessageType type;

  DockerMessage(this.message, this.type);
}

Future<ProcessResult> dockerCmd(List<String> args, String workDir) async {
  final p = await Process.run('docker', args, workingDirectory: workDir);
  return p;
}
