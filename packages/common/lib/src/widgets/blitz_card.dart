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
    final subtitleText = subtitle.isNotEmpty
        ? Text(
            subtitle,
            style: theme.textTheme.subtitle2,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          )
        : Container();
    const divider = Divider(thickness: 2, height: 3);

    if (constraints.maxWidth < 200) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleText,
          subtitleText,
          divider,
          Expanded(child: child),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              titleText,
              const SizedBox(width: 6.0),
              Expanded(child: subtitleText)
            ],
          ),
          divider,
          Expanded(child: child),
        ],
      );
    }
  }
}
