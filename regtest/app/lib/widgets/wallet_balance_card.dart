import 'package:common/common.dart' show BtcValue;
import 'package:flutter/material.dart';

import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:regtest_core/core.dart';

class WalletBalanceCard extends StatefulWidget {
  final LnNode node;
  const WalletBalanceCard(this.node, {super.key});

  @override
  State<WalletBalanceCard> createState() => _WalletBalanceCardState();
}

class _WalletBalanceCardState extends State<WalletBalanceCard> {
  WalletBalance? _balance;

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  Future<void> _loadBalance() async {
    final b = await widget.node.walletBalance();
    setState(() => _balance = b);
  }

  @override
  Widget build(BuildContext context) {
    if (_balance == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final WalletBalance b = _balance!;

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
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _loadBalance,
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
                              b.channelLocalBalance + b.channelRemoteBalance)
                          .formatted(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 8.0),
                    const Icon(Icons.home, size: 16.0),
                    const Spacer(),
                    Text(
                      BtcValue.fromMilliSat(b.channelLocalBalance).formatted(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 8.0),
                    const Icon(Icons.airline_stops, size: 16.0),
                    const Spacer(),
                    Text(
                      BtcValue.fromMilliSat(b.channelRemoteBalance).formatted(),
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
