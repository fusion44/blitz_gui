import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/settings_bloc/settings_bloc.dart';

class MoneyValueView extends StatelessWidget {
  final int amount;
  final int fee;
  final bool hero;
  final bool settled;
  final TextAlign textAlign;

  const MoneyValueView({
    Key key,
    this.amount,
    this.hero = false,
    this.settled = true,
    this.textAlign = TextAlign.start,
    this.fee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return BlocBuilder(
      bloc: BlocProvider.of<SettingsBloc>(context),
      builder: (BuildContext context, SettingsState state) {
        final numberFormat = NumberFormat.currency(
          locale: state.langCode,
          symbol: '',
          decimalDigits: 0,
        );

        final left = state.currSymbolIsLeft;

        var style = hero ? textTheme.headline5 : textTheme.bodyText2;
        if (!settled) style = style.copyWith(color: Colors.grey);

        if (fee != null) {
          return Container(
            width: 120,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: textAlign == TextAlign.start
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      if (left) _buildSatIcon(isLeft: left),
                      Text(
                        '${numberFormat.format(amount)}',
                        style: style,
                        textAlign: textAlign,
                      ),
                      if (!left) _buildSatIcon(isLeft: left),
                    ]),
                Row(
                    mainAxisAlignment: textAlign == TextAlign.start
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      if (left) _buildSatIcon(isLeft: left),
                      Text(
                        '${numberFormat.format(fee)}',
                        style: style.copyWith(fontSize: 11),
                        textAlign: textAlign,
                      ),
                      if (!left) _buildSatIcon(isLeft: left),
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
      },
    );
  }

  Widget _buildSatIcon({bool isLeft = true, dense = true}) {
    if (isLeft) {
      return Padding(
        padding: const EdgeInsets.only(right: 2.0),
        child: Image.asset('assets/icons/satoshi-v2.png'),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 2.0),
        child: Image.asset('assets/icons/satoshi-v2.png'),
      );
    }
  }
}
