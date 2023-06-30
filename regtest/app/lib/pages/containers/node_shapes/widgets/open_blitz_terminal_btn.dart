import 'package:flutter/material.dart';

class OpenBlitzTerminalBtn extends StatelessWidget {
  final void Function()? onPressed;

  const OpenBlitzTerminalBtn(this.onPressed, {super.key});

  static PopupMenuItem<String> asMenuItem(
    String value, {
    Color? iconColor,
  }) =>
      PopupMenuItem<String>(
        value: value,
        child: Row(children: [
          Icon(Icons.terminal, color: iconColor),
          const SizedBox(width: 8),
          const Text('Blitz Api Terminal'),
        ]),
      );

  @override
  Widget build(BuildContext context) => Tooltip(
        message: 'Delete container',
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.delete),
        ),
      );
}
