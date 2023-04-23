import 'dart:async';
import 'dart:io';

import '../constants.dart';

Future<List<String>> getRunningContainerNames() async {
  final proc = await Process.run('docker', ['ps']);
  final output = <String>[];

  if (proc.exitCode != 0) {
    throw Exception(
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
