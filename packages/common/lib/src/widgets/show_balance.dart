import 'package:flutter/material.dart';

import 'package:common/common.dart';
import 'package:common/src/widgets/sats_display.dart';

class ShowBalanceWidget extends StatelessWidget {
  final WalletBalance balance;

  const ShowBalanceWidget(this.balance, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = balance.onchainTotalBalance + balance.localBalance.sat;
    final theme = Theme.of(context);

    return Column(
      children: buildAnimatedVerticalColumnChildren([
        TrText(
          'wallet.balances_headline',
          style: theme.textTheme.displaySmall!,
        ),
        const SizedBox(height: 16),

        // Total balance
        TrText(
          'wallet.total_balance_subtitle',
          style: theme.textTheme.headline5!,
        ),
        const SizedBox(height: 8),
        SatsDisplay(value: total, locale: 'en'),

        // Onchain balance
        const SizedBox(height: 24),
        TrText(
          'wallet.confirmed_onchain_balance',
          style: theme.textTheme.headline5!,
        ),
        const SizedBox(height: 8),
        SatsDisplay(value: balance.localBalance.sat, locale: 'en'),

        // Local channel balance
        const SizedBox(height: 24),
        TrText(
          'wallet.channel_local_balance',
          style: theme.textTheme.headline5!,
        ),
        const SizedBox(height: 8),
        SatsDisplay(value: balance.localBalance.sat, locale: 'en'),
      ]),
    );
  }
}
