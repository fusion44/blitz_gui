import 'package:flutter/material.dart';

class ShowLogsBtn extends StatelessWidget {
  final void Function()? onPressed;

  const ShowLogsBtn(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) => Tooltip(
        message: 'Logs',
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.bug_report),
        ),
      );
}
