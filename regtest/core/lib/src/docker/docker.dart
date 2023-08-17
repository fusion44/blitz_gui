import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../core.dart';

export 'blocs/blocs.dart';
export 'containers/containers.dart';
export 'exceptions.dart';

class ContainerData {
  final String internalId;
  final String dockerId;
  final String name;
  final String image;
  final ContainerStatus status;
  final Map<String, dynamic> inspectData;

  ContainerData(
    this.internalId,
    this.dockerId,
    this.image,
    this.name,
    this.status, {
    this.inspectData = const {},
  });
}

/// Returns a list of running containers
///
/// If [filterName] is set it will only return containers that contain
/// [filterName] in the containers name field. If [filterName] is not set
/// it'll return all running containers
Future<List<ContainerData>> getRunningContainerNames(
    [String filterName = '']) async {
  final proc = await Process.run('docker', ['ps', '-a']);
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
    String dockerId = spl[0];

    if (dockerId.length != 12) {
      print('Ignoring docker id length: $dockerId');

      continue;
    }

    final inspectData = (await Process.run('docker', ['inspect', dockerId]))
        .stdout
        .toString()
        .trim();
    final Map<String, dynamic> inspectJson = jsonDecode(inspectData)[0];
    dockerId = inspectJson['Id'];

    final dockerStatus = inspectJson['State']['Status'];
    final ContainerStatus status = switch (dockerStatus) {
      'created' => ContainerStatus.created,
      'starting' => ContainerStatus.starting,
      'restarting' => ContainerStatus.starting,
      'running' => ContainerStatus.started,
      'exited' => ContainerStatus.stopped,
      _ => ContainerStatus.uninitialized,
    };

    if (status == ContainerStatus.uninitialized) {
      // we treat ContainerStatus.uninitialized as an error here as it means we
      // have a state that isn't handled yet
      throw StateError('Unknown container status: $dockerStatus');
    }

    final dockerName = inspectJson['Name'] as String;
    if (!dockerName.contains(dockerContainerNameDelimiter)) continue;

    var res = dockerName.split(dockerContainerNameDelimiter).toList();
    String name = '', internalId = '';

    if (res.length == 2) {
      name = res[0];
      internalId = res[1];
    } else if (res.length == 4) {
      name =
          '${res[0]}$dockerContainerNameDelimiter${res[1]}$dockerContainerNameDelimiter${res[2]}';
      internalId = res[3];
    } else {
      logMessage('Ignoring unparsable container name: $dockerName');
      continue;
    }

    final data = ContainerData(
      internalId,
      dockerId,
      inspectJson['Config']['Image'],
      name.replaceFirst('/', ''),
      status,
      inspectData: inspectJson,
    );

    if (filterName.isEmpty) {
      output.add(data);
    } else if (data.name.contains(filterName)) {
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
