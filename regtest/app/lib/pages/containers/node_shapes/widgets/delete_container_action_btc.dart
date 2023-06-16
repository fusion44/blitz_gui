import 'package:flutter/material.dart';

class DeleteContainerBtn extends StatelessWidget {
  final void Function()? onPressed;

  const DeleteContainerBtn(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) => Tooltip(
        message: 'Delete container',
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.delete),
        ),
      );
}
