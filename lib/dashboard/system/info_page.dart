import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../wallet/lightning_info/bloc/lightning_info_bloc.dart';
import '../wallet/pages/lightning_info_widget.dart';
import '../wallet/wallet_balance/bloc/wallet_balance.dart';
import 'bitcoin_info/bitcoin_info_bloc.dart';
import 'bitcoin_info/bitcoin_info_widget.dart';
import 'hardware_info/hardware_info_bloc.dart';
import 'hardware_info/hardware_info_widget.dart';
import 'system_info/system_info_bloc.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({
    required this.systemBloc,
    required this.hardwareBloc,
    required this.btcInfoBloc,
    required this.lnInfoBloc,
    Key? key,
  }) : super(key: key);

  final SystemInfoBloc systemBloc;
  final HardwareInfoBloc hardwareBloc;
  final BitcoinInfoBloc btcInfoBloc;
  final LightningInfoBloc lnInfoBloc;

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final double spacing = 4.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            SizedBox(height: spacing),
            BlocBuilder<SystemInfoBloc, SystemInfoBaseState>(
              bloc: widget.systemBloc,
              builder: (context, state) {
                if (state is SystemInfoState) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Blitz ${state.info.version}'),
                          const Spacer(),
                          const Text('Alias: '),
                          Text(
                            state.info.alias,
                            style: theme.textTheme.bodyText1!.copyWith(
                              color: Colors.green[600],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: spacing),
                      Text(
                          'Network: ${state.info.chain} + ${state.info.lanApi} + TOR'),
                    ],
                  );
                } else {
                  return const Center(
                    child: SpinKitChasingDots(color: Colors.red),
                  );
                }
              },
            ),
            const Divider(),
            SizedBox(height: spacing),
            BlocBuilder<HardwareInfoBloc, HardwareInfoBaseState>(
                bloc: widget.hardwareBloc,
                builder: (context, state) {
                  if (state is HardwareInfoState) {
                    return HardwareInfoWidget(
                      state.info,
                      state.downloadRate,
                      state.uploadRate,
                    );
                  } else if (state is HardwareInfoErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: SpinKitChasingDots(color: Colors.red),
                    );
                  }
                }),
            const Divider(),
            BlocBuilder<BitcoinInfoBloc, BitcoinInfoBaseState>(
              bloc: widget.btcInfoBloc,
              builder: (context, state) {
                if (state is BitcoinInfoState) {
                  return BitcoinInfoWidget(state.info);
                } else {
                  return const Center(
                    child: SpinKitChasingDots(color: Colors.red),
                  );
                }
              },
            ),
            const Divider(),
            BlocBuilder<LightningInfoBloc, LightningInfoBaseState>(
              bloc: widget.lnInfoBloc,
              builder: (context, state) {
                if (state is LightningInfoState) {
                  return LightningInfoWidget(
                    info: state.info!,
                    wb: state.walletBalance ?? const WalletBalance(),
                  );
                } else {
                  return const Center(
                    child: SpinKitChasingDots(color: Colors.red),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
