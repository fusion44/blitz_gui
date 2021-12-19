import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoneyValueView extends StatelessWidget {
  final int amount;
  final String langCode;
  final bool currSymbolIsLeft;
  final int? fee;
  final bool hero;
  final bool settled;
  final TextAlign textAlign;

  const MoneyValueView({
    Key? key,
    required this.amount,
    required this.langCode,
    required this.currSymbolIsLeft,
    this.hero = false,
    this.settled = true,
    this.textAlign = TextAlign.start,
    this.fee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    final numberFormat = NumberFormat.currency(
      locale: langCode,
      symbol: '',
      decimalDigits: 0,
    );

    var style = hero ? textTheme.headline5 : textTheme.bodyText2;
    if (!settled) style = style!.copyWith(color: Colors.grey);

    if (fee != null) {
      return SizedBox(
        width: 120,
        child: Column(
          children: [
            Row(
                mainAxisAlignment: textAlign == TextAlign.start
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  if (currSymbolIsLeft)
                    _buildSatIcon(isLeft: currSymbolIsLeft, darkMode: true),
                  Text(
                    numberFormat.format(amount),
                    style: style,
                    textAlign: textAlign,
                  ),
                  if (!currSymbolIsLeft)
                    _buildSatIcon(isLeft: currSymbolIsLeft, darkMode: true),
                ]),
            Row(
                mainAxisAlignment: textAlign == TextAlign.start
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  if (currSymbolIsLeft)
                    _buildSatIcon(isLeft: currSymbolIsLeft, darkMode: true),
                  Text(
                    numberFormat.format(fee),
                    style: style!.copyWith(fontSize: 11),
                    textAlign: textAlign,
                  ),
                  if (!currSymbolIsLeft)
                    _buildSatIcon(isLeft: currSymbolIsLeft, darkMode: true),
                ]),
          ],
        ),
      );
    }

    return Text(
      numberFormat.format(amount),
      style: style,
      textAlign: textAlign,
    );
  }
}

Widget _buildSatIcon({bool isLeft = true, bool darkMode = false}) {
  final color = darkMode ? Colors.white : Colors.black;
  if (isLeft) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: Image.asset('assets/icons/satoshi-v2.png', color: color),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: Image.asset('assets/icons/satoshi-v2.png', color: color),
    );
  }
}
