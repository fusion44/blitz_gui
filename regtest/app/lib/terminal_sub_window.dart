import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';

import 'widgets/terminal_widget.dart';

class TerminalSubWindow extends StatelessWidget {
  final String title;
  final WindowController windowCtrl;
  final List<String> bootstrapCommands;

  const TerminalSubWindow(
    this.bootstrapCommands,
    this.title,
    this.windowCtrl, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Text(title.isEmpty ? 'Terminal' : 'Terminal to $title'),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => windowCtrl.close(),
            ),
          ]),
        ),
        body: TerminalWidget(autoCommands: bootstrapCommands),
      ),
    );
  }
}
