import 'package:flutter/material.dart';

import 'package:common_widgets/common_widgets.dart';

class BigButton extends StatelessWidget {
  final TextStyle? style;
  final IconData icon;
  final String label;
  final String description;
  final String id;
  final Function(String) onPressed;

  const BigButton({
    Key? key,
    this.style,
    required this.icon,
    required this.label,
    required this.description,
    required this.id,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _buildWidget(
        theme: theme,
        label: TrText(
          label,
          isButton: true,
        ),
        description: TrText(
          description,
          textAlign: TextAlign.center,
          style: style ?? theme.textTheme.labelMedium!,
        ),
        icon: icon,
        onPressed: onPressed);
  }

  Widget _buildWidget({
    required ThemeData theme,
    required Widget label,
    required IconData icon,
    Widget? description,
    double size = 150,
    required Function onPressed,
  }) {
    final btn = SizedBox(
      width: size,
      height: size,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) => theme.highlightColor,
          ),
        ),
        onPressed: () => onPressed(id),
        icon: Icon(icon),
        label: label,
      ),
    );

    if (description != null) {
      return SizedBox(
        width: size,
        child: Column(children: [
          btn,
          const SizedBox(height: 8.0),
          description,
        ]),
      );
    } else {
      return btn;
    }
  }
}
