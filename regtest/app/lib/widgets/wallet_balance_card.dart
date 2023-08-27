import 'package:common/common.dart' show BtcValue;
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regtest_app/pages/containers/utils.dart';
import 'package:regtest_core/core.dart';

import '../blocs/wallet_balance_cubit/wallet_balance_cubit.dart';

class WalletBalanceCard extends StatefulWidget {
  final LnNode node;
  const WalletBalanceCard(this.node, {super.key});

  @override
  State<WalletBalanceCard> createState() => _WalletBalanceCardState();
}

class _WalletBalanceCardState extends State<WalletBalanceCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBalanceCubit, WalletBalanceState>(
      bloc: WalletBalanceCubit(
        NetworkManager().findContainerById(findComplementaryNode(widget.node))!,
      ),
      builder: (context, state) {
        if (state is WalletBalanceUpdated) {
          return _buildCard(state);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildCard(WalletBalanceUpdated state) {
    final b = state.balance;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Balances',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Column(
              children: [
                Row(
                  children: [
                    const Text('Onchain'),
                    const Spacer(),
                    Text(BtcValue.fromSats(b.onchainTotalBalance).formatted()),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 8.0),
                    const Icon(Icons.check, size: 16.0),
                    const Spacer(),
                    Text(
                      BtcValue.fromSats(b.onchainConfirmedBalance).formatted(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 8.0),
                    const Icon(Icons.hourglass_bottom_rounded, size: 16.0),
                    const Spacer(),
                    Text(
                      BtcValue.fromSats(b.onchainUnconfirmedBalance)
                          .formatted(),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Text('Channel'),
                    const Spacer(),
                    Text(
                      BtcValue.fromMilliSat(
                        (b.localBalance + b.remoteBalance).msat,
                      ).formatted(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 8.0),
                    const Icon(Icons.home, size: 16.0),
                    const Spacer(),
                    Text(
                      BtcValue.fromMilliSat(
                        b.localBalance.msat,
                      ).formatted(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 8.0),
                    const Icon(Icons.airline_stops, size: 16.0),
                    const Spacer(),
                    Text(
                      BtcValue.fromMilliSat(
                        b.remoteBalance.msat,
                      ).formatted(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
