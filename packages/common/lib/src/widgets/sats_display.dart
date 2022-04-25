import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../utils.dart';

class SatsDisplay extends StatelessWidget {
  final int value;
  final String? locale;
  final double fontSize;
  final double fontHeight;

  const SatsDisplay({
    Key? key,
    required this.value,
    this.locale,
    this.fontSize = 32,
    this.fontHeight = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat.decimalPattern(locale);
    final t = buildTextThemeWithEczar(
      theme.textTheme,
      fontSize: fontSize,
      height: fontHeight,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          numberFormat.format(value),
          style: t.bodyText2,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
          child: Transform.rotate(
            angle: 0.2617994, // 15 degrees
            child: SizedBox(
              height: fontSize,
              child: Image.asset(
                'assets/icons/satoshi-v2.png',
                color: t.bodyText2?.color,
                scale: 0.75,
              ),
            ),
          ),
        )
      ],
    );
  }
}
