// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bitcoin_info_card.dart';
import 'hardware_info_card.dart';
import 'ln_info_card.dart';
import 'system_info_card.dart';

class InfoScreenPlusPlus extends StatefulWidget {
  const InfoScreenPlusPlus({Key? key}) : super(key: key);

  @override
  _InfoScreenPlusPlusState createState() => _InfoScreenPlusPlusState();
}

class _InfoScreenPlusPlusState extends State<InfoScreenPlusPlus> {
  final double spacing = 4.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<WalletLockedCheckerBloc, WalletLockedCheckerState>(
      builder: (context, state) {
        if (state is WalletLocked) {
          return _buildWalletLockedText(theme);
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      children: const [
                        Expanded(child: BitcoinInfoCard()),
                        Expanded(child: HardwareInfoCard()),
                      ],
                    ),
                  ),
                  const Expanded(child: LnInfoCard()),
                ],
              );
            } else {
              return GridView.count(
                crossAxisCount: 2,
                children: const [
                  BitcoinInfoCard(),
                  LnInfoCard(),
                  SystemInfoCard(),
                  HardwareInfoCard(),
                ],
              );
            }
          },
        );
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
          tr('wallet_locked_message_two_line'),
          style: theme.textTheme.headlineSmall,
        )
      ],
    );
  }
}
