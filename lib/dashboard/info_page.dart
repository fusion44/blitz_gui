import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../common/subscription_repository.dart';
import 'blocs/bitcoin_info/bitcoin_info_bloc.dart';
import 'blocs/bitcoin_info/bitcoin_info_widget.dart';
import 'blocs/lightning_info/lightning_info_bloc.dart';
import 'blocs/system_info/system_info_bloc.dart';
import 'blocs/system_info/system_info_widget.dart';
import 'lightning_info_widget.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final double spacing = 4.0;

  late SystemInfoBloc _bloc;
  late BitcoinInfoBloc _btcInfoBloc;
  late LightningInfoBloc _lnInfoBloc;

  @override
  void initState() {
    super.initState();

    final repo = RepositoryProvider.of<SubscriptionRepository>(context);
    _bloc = SystemInfoBloc(repo);
    _bloc.add(StartListenSystemInfo());
    _btcInfoBloc = BitcoinInfoBloc(repo);
    _btcInfoBloc.add(StartListenBitcoinInfo());
    _lnInfoBloc = LightningInfoBloc(repo);
    _lnInfoBloc.add(StartListenLightningInfo());
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.add(StopListenSystemInfo());
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Raspiblitz v1.7'),
                Text(
                  'RecklessBlitz',
                  style: theme.textTheme.bodyText1!.copyWith(
                    color: Colors.green[600],
                  ),
                )
              ],
            ),
            SizedBox(height: spacing),
            const Text('Bitcoin Fullnode + Lightning Network + TOR'),
            const Divider(),
            SizedBox(height: spacing),
            BlocBuilder<SystemInfoBloc, SystemInfoBaseState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is SystemInfoState) {
                    return SystemInfoWidget(
                      state.info,
                      state.downloadRate,
                      state.uploadRate,
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
                    wb: state.walletBalance!,
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
