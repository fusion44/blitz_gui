import 'package:flutter/material.dart';

import '../../common.dart';

class DataItem extends StatelessWidget {
  final String text;
  final String label;
  final Color? color;

  const DataItem({
    Key? key,
    required this.text,
    required this.label,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Stack(
      children: <Widget>[
        Container(
          width: 3,
          height: 45,
          color: color,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TrText(
                text,
                style: theme.textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
              label != ''
                  ? TrText(
                      label,
                      style: theme.textTheme.caption,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
