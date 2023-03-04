import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../utils.dart';

class SatsDisplay extends StatelessWidget {
  final num value;
  final String? locale;
  final double fontSize;
  final double fontHeight;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool showDecimal;

  const SatsDisplay({
    Key? key,
    required this.value,
    this.locale,
    this.fontSize = 32,
    this.fontHeight = 1.2,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
    this.showDecimal = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat.currency(
      symbol: '',
      locale: locale,
      decimalDigits: showDecimal ? 3 : 0,
    );
    final t = buildTextThemeWithEczar(
      theme.textTheme,
      fontSize: fontSize,
      height: fontHeight,
    );

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: [
        Text(
          numberFormat.format(value),
          style: t.bodyMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
          child: Transform.rotate(
            angle: 0.2617994, // 15 degrees
            child: SizedBox(
              height: fontSize,
              child: Image.asset(
                'assets/icons/satoshi-v2.png',
                color: t.bodyMedium?.color,
                scale: 0.75,
              ),
            ),
          ),
        )
      ],
    );
  }
}
