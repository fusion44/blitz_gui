import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../wallet/lightning_info/bloc/lightning_info_bloc.dart';
import '../wallet/pages/lightning_info_widget.dart';
import '../wallet/wallet_balance/bloc/wallet_balance.dart';
import '../wallet/wallet_locked_checker/wallet_locked_checker_bloc.dart';
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

    return BlocBuilder<WalletLockedCheckerBloc, WalletLockedCheckerState>(
      builder: (context, state) {
        bool walletLocked = state is WalletLocked;
        return Column(
          children: [
            SizedBox(height: spacing),
            _buildSystemInfo(walletLocked, theme),
            const Divider(),
            SizedBox(height: spacing),
            _buildHardwareInfo(),
            if (!walletLocked) const Divider(),
            _buildBitcoinInfo(walletLocked),
            if (!walletLocked) const Divider(),
            _buildLightningInfo(walletLocked),
          ],
        );
      },
    );
  }

  Widget _buildSystemInfo(bool locked, ThemeData theme) {
    if (locked) return _buildWalletLockedText(theme);

    return BlocBuilder<SystemInfoBloc, SystemInfoBaseState>(
      bloc: widget.systemBloc,
      builder: (context, state) {
        if (state is SystemInfoState) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Blitz ${state.info.platformVersion}'),
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
              Text('Network: ${state.info.chain} + ${state.info.lanApi} + TOR'),
            ],
          );
        } else {
          return const Center(
            child: SpinKitChasingDots(color: Colors.red),
          );
        }
      },
    );
  }

  Widget _buildHardwareInfo() {
    return BlocBuilder<HardwareInfoBloc, HardwareInfoBaseState>(
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
      },
    );
  }

  Widget _buildBitcoinInfo(bool locked) {
    if (locked) return Container();

    return BlocBuilder<BitcoinInfoBloc, BitcoinInfoBaseState>(
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
    );
  }

  Widget _buildLightningInfo(bool locked) {
    if (locked) return Container();

    return BlocBuilder<LightningInfoBloc, LightningInfoBaseState>(
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
    );
  }

  Widget _buildWalletLockedText(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.lock, size: 60),
        const SizedBox(width: 8.0),
        Text(
          tr('Wallet is locked.\nUnlock via SSH menu.'),
          style: theme.textTheme.headline5,
        )
      ],
    );
  }
}
