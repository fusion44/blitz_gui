import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pty/flutter_pty.dart';
import 'package:xterm/xterm.dart';

String get shell {
  if (Platform.isMacOS || Platform.isLinux) {
    return Platform.environment['SHELL'] ?? 'bash';
  }

  if (Platform.isWindows) {
    return 'cmd.exe';
  }

  return 'sh';
}

class TerminalWidget extends StatefulWidget {
  final List<String> autoCommands;
  const TerminalWidget({Key? key, this.autoCommands = const []})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TerminalWidgetState createState() => _TerminalWidgetState();
}

class _TerminalWidgetState extends State<TerminalWidget> {
  final terminal = Terminal(maxLines: 10000);

  final terminalController = TerminalController();

  late final Pty pty;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.endOfFrame.then((_) {
      if (mounted) _startPty();
    });

    if (widget.autoCommands.isNotEmpty) {
      _connect();
    }
  }

  Future<void> _connect() async {
    await Future.delayed(const Duration(milliseconds: 700));

    for (var c in widget.autoCommands) {
      if (c.startsWith('sleep')) {
        await Future.delayed(
          Duration(milliseconds: int.parse(c.split(' ')[1])),
        );

        continue;
      }

      terminal.textInput(c);
    }
  }

  void _startPty() {
    pty = Pty.start(
      shell,
      columns: terminal.viewWidth,
      rows: terminal.viewHeight,
    );

    pty.output
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);

    pty.exitCode.then((code) {
      terminal.write('the process exited with exit code $code');
    });

    terminal.onOutput = (data) {
      pty.write(const Utf8Encoder().convert(data));
    };

    terminal.onResize = (w, h, pw, ph) {
      pty.resize(h, w);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 750, maxHeight: 500),
      child: TerminalView(
        terminal,
        controller: terminalController,
        autofocus: true,
        backgroundOpacity: 0.7,
        onSecondaryTapDown: (details, offset) async {
          final selection = terminalController.selection;
          if (selection != null) {
            final text = terminal.buffer.getText(selection);
            terminalController.clearSelection();
            await Clipboard.setData(ClipboardData(text: text));
          } else {
            final data = await Clipboard.getData('text/plain');
            final text = data?.text;
            if (text != null) {
              terminal.paste(text);
            }
          }
        },
      ),
    );
  }
}
