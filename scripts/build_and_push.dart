import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_console/dart_console.dart';
import 'package:watcher/watcher.dart';

// Take screenshot on PI (fbgrab must be installed):
// sudo fbgrab -d /dev/fb1 screenshot1.png
// -------------------------------------
// download to dev computer:
// scp pi@192.168.1.254:/home/pi/screenshot1.png screenshot1.png

class Remote {
  final String name;
  final String ip;
  final String username;
  final String password;
  final bool attachFlutterTools;
  final int? displayWidth;
  final int? displayHeight;

  Remote(
    this.name,
    this.ip,
    this.username,
    this.password,
    this.attachFlutterTools, {
    this.displayWidth,
    this.displayHeight,
  });
}

final remotes = [
  Remote(
    'testiblitz1',
    '192.168.1.11',
    'admin',
    'password',
    true,
    displayWidth: 201,
    displayHeight: 101,
  ),
  Remote(
    'testiblitz2',
    '192.168.1.12',
    'admin',
    'password',
    true,
    displayWidth: 373,
    displayHeight: 305,
  ),
];

final progress = <String, String>{};

final console = Console();
late final Coordinate printPos;

final String pwd = '${Directory.current.path}/packages/apps/blitz_app';

void main() async {
  console.hideCursor();

  _listenForCommands();

  await buildBinaries();

  if (console.cursorPosition == null) {
    console.writeErrorLine("Can't access console: cursorPosition is null");
    console.showCursor();
    return;
  }

  printPos = console.cursorPosition!;

  copyRestartShellFiles();

  await startAndWaitForRsyncProcesses();
  final fsWatchSub = watchFileSystem();
  await restartApps();

  fsWatchSub.cancel();
  console.cursorPosition = Coordinate(console.windowHeight, 0);
  await Future.delayed(const Duration(seconds: 2));
  console.writeLine('Finish - cool');
  console.showCursor();
  inputSub?.cancel();
  exit(0);
}

StreamSubscription<WatchEvent> watchFileSystem() {
  var watcher = DirectoryWatcher('.');
  return watcher.events.listen((event) {
    if (event.path.startsWith('./lib') || event.path.startsWith('./packages')) {
      scheduleRestart();
    }
  });
}

bool restarting = false;
void scheduleRestart() async {
  if (!restarting) {
    restarting = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    for (final p in flutterProcesses.values) {
      p.stdin.add('r'.codeUnits);
    }
    restarting = false;
  }
}

StreamSubscription<String>? inputSub;
void _listenForCommands() async {
  inputSub = stdin.transform(const Utf8Decoder()).listen((data) {
    switch (data.trim()) {
      case 'exit':
        console.writeLine(
          'Closing ${processes.length + flutterProcesses.length} processes',
        );
        for (final p in processes) {
          p.kill();
        }
        for (final p in flutterProcesses.values) {
          p.stdin.add('q'.codeUnits);
        }
        break;
      case 'r':
        for (final p in flutterProcesses.values) {
          p.stdin.add('r'.codeUnits);
        }
        break;
      case 'R':
        for (final p in flutterProcesses.values) {
          p.stdin.add('R'.codeUnits);
        }
        break;
      case 'd':
        for (final p in flutterProcesses.values) {
          p.stdin.add('d'.codeUnits);
        }
        break;
      default:
        console.writeLine('Unrecognized command: $data');
    }
  });
}

Future<void> restartApps() async {
  final processes = <Future<int>>[];
  for (final r in remotes) {
    progress[r.name] = '0%';
    processes.add(executeApp(r));
  }

  await Future.wait(processes);
}

final processes = <Process>[];
Future<int> executeApp(Remote r) async {
  final p = await Process.start('bash', [
    '${Directory.current.path}/scripts/restart_ui.sh',
    r.password,
    r.username,
    r.ip,
    r.name,
  ]);

  processes.add(p);

  p.stdout.transform(utf8.decoder).transform(const LineSplitter()).listen(
    (event) {
      if (event.startsWith('flutter: Observatory listening on')) {
        String url = event.replaceAll('flutter: Observatory listening on ', '');
        url = url.replaceAll('0.0.0.0', r.ip);
        console.writeLine('${r.name} Observatory listening on $url');
        if (r.attachFlutterTools) {
          attachFlutterProcess(
            r,
            url.replaceAll('flutter: Observatory listening on ', '').trim(),
          );
        }
      }
    },
    onDone: () {
      processes.remove(p);
      console.writeLine('${r.name} is done.');
    },
    onError: (error) => console.writeErrorLine('${r.name} error: $error'),
  );

  p.stderr
      .transform(utf8.decoder)
      .listen((error) => console.writeErrorLine('${r.name} error: $error'));

  return p.exitCode;
}

final Map<String, Process> flutterProcesses = {};
Future<void> attachFlutterProcess(
  Remote remote,
  String observatoryUrl,
) async {
  await Future.delayed(const Duration(seconds: 4));
  console.writeLine('Attaching to ${remote.name}');
  // flutter attach --debug-url http://192.168.1.254:45363/fvjF6cnC46g= -d linux
  final p = await Process.start('flutter', [
    'attach',
    '--debug-url',
    observatoryUrl,
    '-d',
    'linux',
  ]);
  flutterProcesses[remote.name] = p;

  p.stdout.transform(utf8.decoder).transform(const LineSplitter()).listen(
        (event) => console.writeLine(event),
        onDone: () {
          flutterProcesses.remove(remote.name);
          console.writeLine('Flutter attachment to ${remote.name} is done.');
        },
        onError: (error) => console.writeErrorLine(
            'Flutter attachment to ${remote.name} error: $error'),
      );

  p.stderr.transform(utf8.decoder).listen(
      (error) => console.writeErrorLine('${remote.name} error: $error'));
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

void copyRestartShellFiles() {
  for (final r in remotes) {
    final newFile = File(
      '$pwd/build/flutter_assets/${r.name}_restart_ui.sh',
    );

    String displayOption = '';
    if (r.displayWidth != null && r.displayHeight != null) {
      displayOption = "-d '${r.displayWidth}, ${r.displayHeight}' ";
    }

    newFile.writeAsStringSync('''
sudo setfacl -m u:admin:rw /dev/input/event*
sudo kill -9 \$(pidof flutter-pi)
sleep 1
flutter-pi $displayOption~/dev/blitz_gui/ --observatory-host=0.0.0.0
''');
  }
}

Future<int> buildBinaries() async {
  var process = await Process.start(
    'flutter',
    ['build', 'bundle'],
    workingDirectory: pwd,
  );
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
    '$pwd/build/flutter_assets',
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
