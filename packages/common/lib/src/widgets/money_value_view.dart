import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoneyValueView extends StatelessWidget {
  final int amount;
  final String langCode;
  final bool? currSymbolIsLeft;
  final int? fee;
  final bool hero;
  final bool settled;
  final TextAlign textAlign;

  const MoneyValueView({
    Key? key,
    required this.amount,
    required this.langCode,
    this.currSymbolIsLeft,
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

    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: textAlign == TextAlign.start
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              if (currSymbolIsLeft != null && currSymbolIsLeft == true)
                _buildSatIcon(isLeft: true, darkMode: true),
              Text(
                numberFormat.format(amount),
                style: style,
                textAlign: textAlign,
              ),
              if (currSymbolIsLeft != null && currSymbolIsLeft == false)
                _buildSatIcon(isLeft: false, darkMode: true),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: textAlign == TextAlign.start
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                if (currSymbolIsLeft != null && currSymbolIsLeft == true)
                  _buildSatIcon(isLeft: true, darkMode: true),
                Text(
                  numberFormat.format(fee),
                  style: style!.copyWith(fontSize: 11),
                  textAlign: textAlign,
                ),
                if (currSymbolIsLeft != null && currSymbolIsLeft == false)
                  _buildSatIcon(isLeft: false, darkMode: true),
              ],
            ),
          ),
        ],
      ),
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
