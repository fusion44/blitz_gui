import 'package:flutter/material.dart';

import 'package:common_widgets/common_widgets.dart';

class MenuButton extends StatelessWidget {
  final Function()? onPressed;
  final Function(bool)? onHover;
  final IconData icon;
  final String labelText;
  final double? minWidth;
  final bool highlight;

  const MenuButton({
    Key? key,
    required this.icon,
    required this.labelText,
    this.minWidth,
    this.onPressed,
    this.onHover,
    this.highlight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final w = TextButton.icon(
      onPressed: onPressed,
      onHover: onHover,
      icon: Icon(icon, color: highlight ? theme.indicatorColor : null),
      label: TrText(
        labelText,
        style: theme.textTheme.labelLarge!.copyWith(
          color: highlight ? theme.indicatorColor : null,
        ),
      ),
    );

    if (minWidth != null && minWidth! > 0.0) {
      return ConstrainedBox(
        constraints: BoxConstraints(minWidth: minWidth!),
        child: w,
      );
    }

    return w;
  }
}
