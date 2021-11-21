import '../common/blocs/auth/auth_repository.dart';
import 'blocs/system_info/system_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../common/models/models.dart';
import '../common/subscription_repository.dart';
import 'blocs/bitcoin_info/bitcoin_info_bloc.dart';
import 'blocs/bitcoin_info/bitcoin_info_widget.dart';
import 'blocs/hardware_info/hardware_info_bloc.dart';
import 'blocs/hardware_info/hardware_info_widget.dart';
import 'blocs/lightning_info/lightning_info_bloc.dart';
import 'lightning_info_widget.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final double spacing = 4.0;

  late SystemInfoBloc _systemBloc;
  late HardwareInfoBloc _hardwareBloc;
  late BitcoinInfoBloc _btcInfoBloc;
  late LightningInfoBloc _lnInfoBloc;

  @override
  void initState() {
    super.initState();

    final subRepo = RepositoryProvider.of<SubscriptionRepository>(context);
    final authRepo = RepositoryProvider.of<AuthRepo>(context);
    _hardwareBloc = HardwareInfoBloc(subRepo, authRepo);
    _hardwareBloc.add(StartListenHardwareInfo());
    _systemBloc = SystemInfoBloc(subRepo);
    _systemBloc.add(StartListenSystemInfo());
    _btcInfoBloc = BitcoinInfoBloc(subRepo);
    _btcInfoBloc.add(StartListenBitcoinInfo());
    _lnInfoBloc = LightningInfoBloc(subRepo);
    _lnInfoBloc.add(StartListenLightningInfo());
  }

  @override
  void dispose() {
    super.dispose();
    _hardwareBloc.add(StopListenHardwareInfo());
    _systemBloc.add(StopListenSystemInfo());
    _btcInfoBloc.add(StopListenBitcoinInfo());
    _lnInfoBloc.add(StopListenLightningInfo());
  }

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
              bloc: _systemBloc,
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
                bloc: _hardwareBloc,
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
              bloc: _btcInfoBloc,
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
              bloc: _lnInfoBloc,
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
