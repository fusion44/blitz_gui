import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_console/dart_console.dart';

class Remote {
  final String name;
  final String ip;
  final String username;
  final String password;

  Remote(this.name, this.ip, this.username, this.password);
}

final remotes = [
  Remote('name1', '192.168.1.11', 'admin', 'password'),
  Remote('name2', '192.168.1.12', 'admin', 'password'),
];

final progress = <String, String>{};

final console = Console();
late final Coordinate printPos;

void main() async {
  console.hideCursor();
  await buildBinaries();

  if (console.cursorPosition == null) {
    console.writeErrorLine("Can't access console: cursorPosition is null");
    console.showCursor();
    return;
  }

  printPos = console.cursorPosition!;

  copyRestartShellFile();

  await startAndWaitForRsyncProcesses();

  await restartApps();

  console.cursorPosition = Coordinate(console.windowHeight, 0);
  console.writeLine('Finish - cool');
  console.showCursor();
}

Future<void> restartApps() async {
  final processes = <Future<int>>[];
  for (final r in remotes) {
    progress[r.name] = '0%';
    processes.add(executeApp(r));
  }

  await Future.wait(processes);
}

Future<int> executeApp(Remote r) async {
  final p = await Process.start('bash', [
    '${Directory.current.path}/scripts/restart_ui.sh',
    r.password,
    r.username,
    r.ip,
  ]);

  p.stdout.transform(utf8.decoder).transform(const LineSplitter()).listen(
    (event) {
      if (event.startsWith('flutter: Observatory listening on')) {
        console.writeLine(event.replaceAll('flutter:', r.name));
      }
    },
    onDone: () => console.writeLine('${r.name} is done.'),
    onError: (error) => console.writeErrorLine('${r.name} error: $error'),
  );

  p.stderr
      .transform(utf8.decoder)
      .listen((error) => console.writeErrorLine('${r.name} error: $error'));

  return p.exitCode;
}

Future<void> startAndWaitForRsyncProcesses() async {
  final processes = <Future<int>>[];
  for (final r in remotes) {
    progress[r.name] = '0%';
    processes.add(rsyncToRemote(r));
  }

  console.writeLine('Uploading ...');
  final t = Timer.periodic(
      const Duration(seconds: 1), (timer) => printUploadProgress());

  await Future.wait(processes);
  printUploadProgress();
  t.cancel();
}

void copyRestartShellFile() {
  final newFile = File(
    '${Directory.current.path}/build/flutter_assets/restart_ui.sh',
  );
  newFile.writeAsStringSync(
    "kill -9 \$(pidof flutter-pi)${console.newLine}sleep 1${console.newLine}flutter-pi -d '173.44, 148.96' ~/dev/blitz_gui/ --observatory-host=0.0.0.0",
  );
}

Future<int> buildBinaries() async {
  var process = await Process.start('flutter', ['build', 'bundle']);
  process.stdout
      .transform(utf8.decoder)
      .listen((event) => console.writeLine(event.trim()));
  return process.exitCode;
}

printUploadProgress() {
  if (progress.isNotEmpty) {
    String k;
    String v;
    for (var i = 0; i < progress.keys.length; i++) {
      k = progress.keys.elementAt(i);
      v = progress[k] ?? '0%';
      console.writeLine('$k: $v');
    }
  }
  console.cursorPosition = Coordinate(printPos.row - remotes.length, 0);
}

Future<int> rsyncToRemote(Remote r) async {
  final p = await Process.start('bash', [
    '${Directory.current.path}/scripts/push_files.sh',
    r.password,
    '/home/fusion44/dev/raspiblitz/blitz_gui/build/flutter_assets',
    '${r.username}@${r.ip}:/home/${r.username}/dev/blitz_gui/',
  ]);

  p.stdout.transform(utf8.decoder).map((data) => data.trim().split(' ')).listen(
    (event) {
      final perc = event.firstWhere((d) => d.contains('%'), orElse: () => '');
      if (perc.isNotEmpty) progress[r.name] = perc;
    },
    onDone: () => progress[r.name] = '100%',
    onError: (error) => progress[r.name] = '$error',
  );

  p.stderr.transform(utf8.decoder).listen((error) => progress[r.name] = error);

  return p.exitCode;
}
