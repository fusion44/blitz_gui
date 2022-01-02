import 'package:flutter/material.dart';

class BlitzCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const BlitzCard({
    Key? key,
    required this.child,
    required this.title,
    this.subtitle = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildChild(constraints, theme),
          ),
        );
      },
    );
  }

  Widget _buildChild(BoxConstraints constraints, ThemeData theme) {
    final titleText = Text(title, style: theme.textTheme.headline5);
    final subtitleText = Text(
      subtitle,
      style: theme.textTheme.subtitle2,
    );
    const divider = Divider(thickness: 2, height: 3);

    if (constraints.maxWidth < 300) {
      return Column(
        children: [
          titleText,
          subtitleText,
          divider,
          Expanded(child: child),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [titleText, const Spacer(), subtitleText],
          ),
          divider,
          Expanded(child: child),
        ],
      );
    }
  }
}
