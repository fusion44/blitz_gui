import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_screen_plus_plus/widgets/balance_overview.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LnInfoCard extends StatelessWidget {
  const LnInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final dense = constraints.maxWidth < 300;
        return BlocBuilder<LightningInfoBloc, LightningInfoBaseState>(
          builder: (context, state) {
            return BlitzCard(
              title: tr('lightning.next_gen_info_screen_card_header'),
              subtitle: state is LightningInfoState && state.info != null
                  ? state.info!.alias
                  : '',
              child: Column(
                children: [
                  _buildWalletLine(theme, dense, state),
                  _buildLnInfoTable(theme, dense, state),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildWalletLine(
    ThemeData theme,
    bool dense,
    LightningInfoBaseState state,
  ) {
    if (state is LightningInfoInitial) {
      return const Text('loading ...');
    } else if (state is LightningInfoState && state.walletBalance != null) {
      final wb = state.walletBalance;
      if (wb == null) {
        return const Center(
          child: Text('Error: walletBalance is null'),
        );
      }

      return Row(
        children: [
          _buildFirstColumn(true, theme),
          Expanded(child: _buildBalanceOverview(theme, true, wb)),
        ],
      );
    }
    return Center(
      child: Text(
        'Error: unknown state: $state',
      ),
    );
  }

  dynamic _buildLnInfoTable(
    ThemeData theme,
    bool dense,
    LightningInfoBaseState state,
  ) {
    if (state is LightningInfoInitial) {
      return const Text('loading ...');
    } else if (state is LightningInfoState) {
      if (state.info == null) {
        return const Center(
          child: Text('Error: state.info is null'),
        );
      }
      final i = state.info;

      return Table(
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: IntrinsicColumnWidth(),
          2: IntrinsicColumnWidth(),
          3: IntrinsicColumnWidth(),
        },
        children: [
          _buildChannelsLine(theme, dense, i!),
          _buildNetworkLine(theme, dense, i),
        ],
      );
    }
    return Center(
      child: Text(
        'Error: unknown state: $state',
      ),
    );
  }

  TableRow _buildChannelsLine(ThemeData theme, bool dense, LightningInfo i) {
    return TableRow(children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.fill,
        child: dense
            ? const Icon(MdiIcons.graph)
            : TrText(
                'lightning.channels.header_description',
                style: theme.textTheme.headline6,
              ),
      ),
      DataItem(
        text: i.numActiveChannels.toString(),
        label: 'Active',
      ),
      DataItem(
        text: i.numInactiveChannels.toString(),
        label: 'Inactive',
      ),
      DataItem(
        text: i.numPendingChannels.toString(),
        label: 'Pending',
      ),
    ]);
  }

  TableRow _buildNetworkLine(ThemeData theme, bool dense, LightningInfo i) {
    return TableRow(children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.fill,
        child: dense
            ? const Icon(Icons.sync)
            : TrText(
                'Sync',
                style: theme.textTheme.headline6,
              ),
      ),
      DataItem(text: i.blockHeight.toString(), label: 'Height'),
      DataItem(
        color: i.syncedToChain ? Colors.greenAccent : Colors.red,
        text: i.syncedToChain ? 'OK' : 'NOK',
        label: 'Chain',
      ),
      DataItem(
        color: i.syncedToChain ? Colors.greenAccent : Colors.red,
        text: i.syncedToGraph ? 'OK' : 'NOK',
        label: 'Graph',
      ),
    ]);
  }

  Widget _buildBalanceOverview(ThemeData theme, bool dense, WalletBalance i) {
    var total = i.localBalance.sat +
        i.onchainConfirmedBalance +
        i.onchainUnconfirmedBalance;
    final t = buildTextThemeWithEczar(theme.textTheme);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TrText(
            'wallet.total_balance',
            style: theme.textTheme.headline6,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 32,
              child: Text(
                total.toString(),
                style: t.bodyText2,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0, bottom: 5),
              child: Image.asset(
                'assets/icons/satoshi-v2.png',
                color: t.bodyText2?.color,
                scale: 0.85,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildFirstColumn(bool dense, ThemeData theme) {
    if (dense) return const Icon(MdiIcons.wallet);

    return TrText('wallet.wallet', style: theme.textTheme.headline6);
  }
}
