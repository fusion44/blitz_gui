import 'package:flutter/material.dart';

class OpenTerminalBtn extends StatelessWidget {
  final void Function()? onPressed;

  const OpenTerminalBtn(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) => Tooltip(
        message: 'Open terminal',
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.terminal),
        ),
      );
}
