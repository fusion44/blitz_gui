import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

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
              child: LayoutGrid(
                rowGap: 4.0,
                columnGap: 4.0,
                gridFit: GridFit.loose,
                areas: '''
                      b0 bal bal bal
                      d1 d1  d1  d1
                      c0 c1  c2  c3
                      d2 d2  d2  d2
                      n0 n1  n2  n3
                      d3 d3  d3  d3
                      f0 f1  f2  f3
                    ''',
                columnSizes: [auto, auto, auto, 1.fr],
                rowSizes: const [auto, auto, auto, auto, auto, auto, auto],
                children: [
                  ..._buildWalletRow(theme, dense, state),
                  _buildDivider('d1', dense),
                  ..._buildLnInfoTable(theme, dense, state),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildWalletRow(
    ThemeData theme,
    bool dense,
    LightningInfoBaseState state,
  ) {
    final l = <Widget>[];
    l.add(_buildFirstColumn(MdiIcons.wallet, 'wallet.wallet', dense, theme)
        .inGridArea('b0'));

    Widget w;
    if (state is LightningInfoInitial) {
      w = const Text('loading ...');
    } else if (state is LightningInfoState && state.walletBalance != null) {
      final wb = state.walletBalance;
      if (wb == null) w = _buildErrorWidget('Error: walletBalance is null');
      w = _buildBalanceOverview(theme, dense, wb!);
    } else {
      w = _buildErrorWidget('Error: unknown state: $state');
    }

    l.add(w.inGridArea('bal'));

    return l;
  }

  List<Widget> _buildLnInfoTable(
    ThemeData theme,
    bool dense,
    LightningInfoBaseState state,
  ) {
    final l = <Widget>[];

    if (state is LightningInfoInitial) {
      l.add(
        _buildFirstColumn(MdiIcons.loading, 'wallet.wallet', dense, theme)
            .withGridPlacement(
          columnStart: 0,
          columnSpan: 1,
          rowStart: 1,
          rowSpan: 2,
        ),
      );
      l.add(
        const Text('loading ...').withGridPlacement(
          columnStart: 1,
          columnSpan: 3,
          rowStart: 1,
          rowSpan: 2,
        ),
      );
      return l;
    } else if (state is LightningInfoState) {
      if (state.info == null || state.feeRevenueData == null) {
        return [
          _buildErrorWidget(
                  'Error: state.info and/or state.feeRevenueData is null')
              .withGridPlacement(
            columnStart: 1,
            columnSpan: 3,
            rowStart: 1,
            rowSpan: 2,
          )
        ];
      }

      final i = state.info;
      l.addAll(_buildChannelsLine(theme, dense, i!));
      l.add(_buildDivider('d2', dense));
      l.addAll(_buildNetworkLine(theme, dense, i));
      l.add(_buildDivider('d3', dense));
      l.addAll(_buildFeeLine(theme, dense, state.feeRevenueData!));
    } else {
      return [
        _buildErrorWidget('Error: unknown state: $state').withGridPlacement(
          columnStart: 1,
          columnSpan: 3,
          rowStart: 1,
          rowSpan: 2,
        )
      ];
    }

    return l;
  }

  List<Widget> _buildChannelsLine(
      ThemeData theme, bool dense, LightningInfo i) {
    return [
      _buildFirstColumn(
        MdiIcons.graph,
        'lightning.channels.header_description',
        dense,
        theme,
      ).inGridArea('c0'),
      DataItem(
        text: i.numActiveChannels.toString(),
        label: 'Active',
      ).inGridArea('c1'),
      DataItem(
        text: i.numInactiveChannels.toString(),
        label: 'Inactive',
      ).inGridArea('c2'),
      DataItem(
        text: i.numPendingChannels.toString(),
        label: 'Pending',
      ).inGridArea('c3'),
    ];
  }

  List<Widget> _buildNetworkLine(ThemeData theme, bool dense, LightningInfo i) {
    final format = NumberFormat.compact(locale: 'en');

    return [
      _buildFirstColumn(
        Icons.sync,
        'lightning.sync_header_description',
        dense,
        theme,
      ).inGridArea('n0'),
      DataItem(
              text: format.format(i.blockHeight),
              label: 'bitcoin.block_height_short')
          .inGridArea('n1'),
      DataItem(
        color: i.syncedToChain ? Colors.greenAccent : Colors.red,
        text: i.syncedToChain ? 'yes' : 'no',
        label: 'lightning.synced_to_chain_label',
      ).inGridArea('n2'),
      DataItem(
        color: i.syncedToChain ? Colors.greenAccent : Colors.red,
        text: i.syncedToGraph ? 'yes' : 'no',
        label: 'lightning.synced_to_graph_label',
      ).inGridArea('n3'),
    ];
  }

  List<Widget> _buildFeeLine(ThemeData theme, bool dense, FeeRevenueData r) {
    final format = NumberFormat.compact(locale: 'en');

    return [
      _buildFirstColumn(
        MdiIcons.rayStartArrow,
        'lightning.forwarding_fees',
        dense,
        theme,
      ).inGridArea('f0'),
      DataItem(text: format.format(r.day), label: 'lightning.fee_revenue_daily')
          .inGridArea('f1'),
      DataItem(
        text: format.format(r.week),
        label: 'lightning.fee_revenue_weekly',
      ).inGridArea('f2'),
      DataItem(
        text: format.format(r.month),
        label: 'lightning.fee_revenue_monthly',
      ).inGridArea('f3'),
    ];
  }

  Widget _buildBalanceOverview(ThemeData theme, bool dense, WalletBalance i) {
    var total = i.localBalance.sat +
        i.onchainConfirmedBalance +
        i.onchainUnconfirmedBalance;
    final t = buildTextThemeWithEczar(theme.textTheme);

    final numberFormat = NumberFormat.decimalPattern('en');

    return Column(
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
                numberFormat.format(total),
                style: t.bodyText2,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 5.0),
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

  Widget _buildFirstColumn(
    IconData iconData,
    String text,
    bool dense,
    ThemeData theme,
  ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: dense
          ? Icon(iconData, size: 30)
          : TrText(
              text,
              style: theme.textTheme.headline6,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
    );
  }

  Widget _buildDivider(String area, bool dense) =>
      Divider(height: dense ? 2 : 8).inGridArea(area);

  Widget _buildErrorWidget(String text) => Center(child: Text(text));
}
