import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TxListItem extends StatelessWidget {
  const TxListItem({Key? key, required this.tx}) : super(key: key);

  final Transaction tx;

  @override
  Widget build(BuildContext context) =>
      _buildListTile(context, tx, Theme.of(context));

  Widget _buildListTile(BuildContext context, Transaction tx, ThemeData theme) {
    String memo = tx.comment;
    bool settled = true;
    Icon? icon;

    var textStyle = theme.textTheme.caption;
    if (tx.category == TxCategory.ln && tx.type == TxType.incoming) {
      if (tx.status == TxStatus.succeeded) {
        icon = const Icon(Icons.arrow_forward, color: Colors.greenAccent);
      } else {
        icon = const Icon(Icons.arrow_forward, color: Colors.grey);
        settled = false;
      }
    } else if (tx.category == TxCategory.ln && tx.type == TxType.outgoing) {
      icon = const Icon(Icons.arrow_back, color: Colors.redAccent);
      if (tx.status != TxStatus.succeeded) settled = false;
    } else if (tx.category == TxCategory.onchain) {
      if (tx.numConfs == 0) settled = false;
      if (tx.amount > 0) {
        icon = Icon(
          Icons.arrow_forward,
          color: settled ? Colors.greenAccent : Colors.grey,
        );
      } else {
        icon = Icon(
          Icons.arrow_back,
          color: settled ? Colors.redAccent : Colors.grey,
        );
      }
      if (!settled) {
        textStyle = theme.textTheme.caption!.copyWith(
          color: Colors.deepOrangeAccent,
        );
      }
      memo = 'Confirmations: ${tx.numConfs}';
    }

    int amount = tx.amount;
    if (tx.category == TxCategory.ln) amount = amount ~/ 1000;

    return ListTile(
      leading: icon,
      title: TimeAgoText(tx.timeStamp, 'en', allowFromNow: false),
      subtitle: Text(
        memo,
        style: textStyle,
      ),
      trailing: _buildValueDisplay(
        context: context,
        amount: amount,
        settled: settled,
        fee: tx.totalFees,
      ),
      dense: true,
    );
  }

  Widget _buildValueDisplay({
    required BuildContext context,
    required int amount,
    required bool settled,
    int? fee,
  }) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat.currency(
      locale: 'de',
      symbol: 'sat',
      decimalDigits: 0,
    );

    return SizedBox(
      width: 100,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Text(numberFormat.format(amount)),
          ),
          if (fee != null && fee != 0)
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                numberFormat.format(fee),
                style: theme.textTheme.caption,
              ),
            )
        ],
      ),
    );
  }
}
