import 'package:flutter/material.dart';

class ShowBlitzLogsBtn extends StatelessWidget {
  final void Function()? onPressed;

  const ShowBlitzLogsBtn(this.onPressed, {super.key});

  static PopupMenuItem<String> asMenuItem(
    String value, {
    Color? iconColor,
  }) =>
      PopupMenuItem<String>(
        value: value,
        child: Row(children: [
          Icon(Icons.bug_report, color: iconColor),
          const SizedBox(width: 8),
          const Text('Blitz Logs'),
        ]),
      );

  @override
  Widget build(BuildContext context) => Tooltip(
        message: 'Logs',
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.bug_report),
        ),
      );
}
