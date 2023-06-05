import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../core.dart';
import 'exceptions.dart';

export 'blocs/blocs.dart';
export 'containers/containers.dart';

class ContainerData {
  final String internalId;
  final String dockerId;
  final String name;
  final String image;

  ContainerData(this.internalId, this.dockerId, this.image, this.name);
}

/// Returns a list of running containers
///
/// If [filterName] is set it will only return containers that contain
/// [filterName] in the containers name field. If [filterName] is not set
/// it'll return all running containers
Future<List<ContainerData>> getRunningContainerNames(
    [String filterName = '']) async {
  final proc = await Process.run('docker', ['ps']);
  final output = <ContainerData>[];

  if (proc.exitCode != 0) {
    throw DockerException(
      "Failed to get container names. Error: ${proc.stderr.toString()}",
    );
  }

  final lines = proc.stdout.split("\n");

  for (int i = 1; i < lines.length; i++) {
    final String line = lines[i];
    if (line.isEmpty) continue;
    final spl = line.split(RegExp(r'\s{2,}'));

    if (spl.length < 7) {
      logMessage("Failed to parse line: $line");
      continue;
    }

    spl[6] = spl[6].trim();
    if (!spl[6].contains(dockerContainerNameDelimiter)) continue;

    var [name, internalId] =
        spl[6].split(dockerContainerNameDelimiter).toList();

    final data = ContainerData(internalId, spl[0], spl[1], name);
    if (data.name.contains(filterName)) {
      output.add(data);
    }
  }

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
