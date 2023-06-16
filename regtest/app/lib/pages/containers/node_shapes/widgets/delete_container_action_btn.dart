import 'package:flutter/material.dart';

class DeleteContainerBtn extends StatelessWidget {
  final void Function()? onPressed;

  const DeleteContainerBtn(this.onPressed, {super.key});

  static PopupMenuItem<String> asMenuItem(
    String value,
    String text, {
    Color? iconColor,
  }) =>
      PopupMenuItem<String>(
        value: value,
        child: Row(children: [
          Icon(Icons.delete, color: iconColor),
          const SizedBox(width: 8),
          Text(text),
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
