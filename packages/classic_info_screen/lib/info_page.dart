// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'bitcoin_info_widget.dart';
import 'hardware_info_widget.dart';
import 'lightning_info_widget.dart';

class ClassicInfoScreen extends StatefulWidget {
  const ClassicInfoScreen({
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
  _ClassicInfoScreenState createState() => _ClassicInfoScreenState();
}

class _ClassicInfoScreenState extends State<ClassicInfoScreen> {
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
                    style: theme.textTheme.bodyLarge!.copyWith(
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
          return LightningInfoWidget(info: state.info, wb: state.walletBalance);
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
          style: theme.textTheme.headlineSmall,
        )
      ],
    );
  }
}
