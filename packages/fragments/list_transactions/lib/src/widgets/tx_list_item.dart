import 'package:flutter/material.dart';

import 'package:common/common.dart';

import '../models/transaction.dart';

const _kLeftTextPadding = 38.0;

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

    final isOnchain = tx.category == TxCategory.onchain;
    var subtitleTextStyle = theme.textTheme.labelSmall;
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
    } else if (isOnchain) {
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
        subtitleTextStyle = theme.textTheme.caption!.copyWith(
          color: Colors.deepOrangeAccent,
        );
      }
      memo = 'Confirmations: ${tx.numConfs}';
    }

    return _TheDisplay(
      memo,
      theme.textTheme.bodyText2,
      subtitleTextStyle,
      icon,
      tx,
    );
  }
}

class _TheDisplay extends StatelessWidget {
  final String memo;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final Icon? icon;
  final Transaction tx;

  const _TheDisplay(
    this.memo,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.icon,
    this.tx, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: _kLeftTextPadding),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                memo,
                style: titleTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 22.0, left: _kLeftTextPadding),
            child: TimeAgoText(
              tx.timeStamp,
              'en',
              allowFromNow: false,
              style: subtitleTextStyle,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: icon,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: _buildValueDisplay(context: context, tx: tx),
          ),
        ),
      ],
    );
  }

  Widget _buildValueDisplay({
    required BuildContext context,
    required Transaction tx,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SatsDisplay(
            value: tx.amount,
            fontSize: 16.0,
            mainAxisAlignment: MainAxisAlignment.end,
            showDecimal: tx.hasRemainder,
          ),
          if (tx.totalFees != 0)
            SatsDisplay(
              value: tx.totalFees,
              fontSize: 12.0,
              mainAxisAlignment: MainAxisAlignment.end,
              showDecimal: tx.hasRemainder,
            )
        ],
      ),
    );
  }
}
