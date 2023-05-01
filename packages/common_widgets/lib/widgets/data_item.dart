import 'package:flutter/material.dart';

import 'translated_text.dart';

class DataItem extends StatelessWidget {
  final String text;
  final String label;
  final Color? color;
  final bool showSatSymbol;
  final bool showNotificationContainer;

  const DataItem({
    Key? key,
    required this.text,
    required this.label,
    this.color,
    this.showSatSymbol = false,
    this.showNotificationContainer = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Stack(
      children: <Widget>[
        if (showNotificationContainer)
          Container(
            width: 3,
            height: 45,
            color: color,
          ),
        if (showNotificationContainer)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildColumn(theme),
          ),
        if (!showNotificationContainer) _buildColumn(theme),
      ],
    );
  }

  Column _buildColumn(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            TrText(
              text,
              style: theme.textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
            if (showSatSymbol) ...[
              const SizedBox(width: 2.0),
              Image.asset(
                'assets/icons/satoshi-v2.png',
                color: theme.textTheme.bodyLarge!.color,
                width: 9,
              )
            ]
          ],
        ),
        if (label != '')
          TrText(
            label,
            style: theme.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          )
      ],
    );
  }
}
