import 'package:flutter/material.dart';

class ToolButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String status;
  final String tooltip;
  final String label;
  final IconData icon;
  final bool disabled;

  const ToolButton({
    required this.onPressed,
    required this.status,
    required this.tooltip,
    required this.label,
    required this.icon,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (status.isEmpty) {
      return ElevatedButton.icon(
        onPressed: disabled ? null : onPressed,
        label: Text(label),
        icon: Icon(icon),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: disabled ? null : onPressed,
          label: Text(label),
          icon: Icon(icon),
        ),
        const SizedBox(height: 4),
        Text(status),
      ],
    );
  }
}
