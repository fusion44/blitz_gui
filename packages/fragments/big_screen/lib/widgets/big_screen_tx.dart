import 'package:flutter/material.dart';

import 'package:list_transactions_fragment/list_transactions.dart';

class BigScreenTxWidget extends StatelessWidget {
  const BigScreenTxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Column(
          children: [
            Text(
              'Overview Widget goes here',
              style: theme.textTheme.headline3,
            ),
            Expanded(child: FundsPage((visible) => print(visible))),
          ],
        ),
      ),
    );
  }
}
