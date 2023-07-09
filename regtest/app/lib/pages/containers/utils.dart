import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:regtest_core/core.dart';

import '../../widgets/show_logs_widget.dart';
import '../../widgets/terminal_widget.dart';
import '../../widgets/widget_utils.dart';

String getContainerLogo(ContainerType type) => switch (type) {
      ContainerType.bitcoinCore => 'assets/images/bitcoin_core_logo.png',
      ContainerType.blitzApi => '',
      ContainerType.cashuMint => 'assets/images/cashu_logo.png',
      ContainerType.cln => 'assets/images/cln_logo.png',
      ContainerType.fakeLn => '',
      ContainerType.lnbits => 'assets/images/lnbits_logo.png',
      ContainerType.lnd => 'assets/images/lnd_logo.png',
      ContainerType.redis => '',
    };

Future<void> openTerminalInDialog(BuildContext c, String containerId) async {
  final container = NetworkManager().findContainerById(containerId);

  if (container == null) {
    buildSnackbar(c, msg: 'Unable to find container $containerId');
    return;
  }

  await NDialog(
    dialogStyle: DialogStyle(titleDivider: true),
    title: Row(
      children: [
        Text(container.containerName),
        const Spacer(),
        Tooltip(
          message:
              'Opens this terminal into a new window.\n\n⚠️⚠️ Currently, there is a bug that closes ALL application windows when this new pup-out window is closed. ⚠️⚠️',
          child: IconButton(
            onPressed: () async {
              final window = await DesktopMultiWindow.createWindow(jsonEncode({
                'title': container.containerName,
                'autoCommands': container.bootstrapCommands(),
              }));
              window
                ..center()
                ..setFrame(const Offset(0, 0) & const Size(720, 480))
                ..show();
            },
            icon: const Icon(Icons.open_in_new),
          ),
        )
      ],
    ),
    content: TerminalWidget(autoCommands: container.bootstrapCommands()),
    actions: <Widget>[
      ElevatedButton(
        child: const Text("OK"),
        onPressed: () => Navigator.pop(c, "OK"),
      ),
    ],
  ).show(c);
}

Future<void> openLogWindowInDialog(BuildContext c, String containerId) async {
  final container = NetworkManager().findContainerById(containerId);

  if (container == null) {
    buildSnackbar(c, msg: 'Unable to find container $containerId');
    return;
  }

  await NDialog(
    dialogStyle: DialogStyle(titleDivider: true),
    title: Text(container.containerName),
    content: ShowLogsWidget(containerId),
    actions: <Widget>[
      ElevatedButton(
        child: const Text("OK"),
        onPressed: () => Navigator.pop(c, "OK"),
      ),
    ],
  ).show(c);
}

extension OffsetExtension on Offset {
  static Offset fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);
    return Offset(data['dx'], data['dy']);
  }

  String toJson() => jsonEncode({'dx': dx, 'dy': dy});
}
