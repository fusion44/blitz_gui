import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/models/lightning_info.dart';
import '../common/models/wallet_balance.dart';
import '../common/utils.dart';
import 'text_fragment.dart';

class LightningInfoWidget extends StatelessWidget {
  final LightningInfo info;
  final WalletBalance wb;

  const LightningInfoWidget({
    this.info = const LightningInfo(),
    this.wb = const WalletBalance(),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat.simpleCurrency(name: 'sat', decimalDigits: 0);

    final theme = Theme.of(context);
    return Column(
      children: [
        Row(children: [
          _buildTextFragment('LND ', theme),
          _buildTextFragment(info.version!, theme, Colors.green),
          const Spacer(),
          _buildTextFragment('${tr("wallet.wallet")} ', theme),
          _buildTextFragment(
              f.format(wb.localBalance.sat + wb.onchainConfirmedBalance),
              theme,
              Colors.orange),
        ]),
        Row(
          children: [
            _buildTextFragment(_getChannelText(), theme),
            const Spacer(),
            _buildTextFragment(
              '${info.numPeers!} ',
              theme,
              Colors.purple[200],
            ),
            _buildTextFragment(tr('lightning.peers'), theme),
          ],
        ),
        Row(
          children: [
            _buildTextFragment('${tr('lightning.fee_report_in_sats')} ', theme),
            _buildTextFragment('11-124-494', theme, Colors.orange),
            _buildTextFragment(' ${tr("lightning.fee_report_desc")}', theme),
          ],
        ),
      ],
    );
  }

  Widget _buildTextFragment(String text, ThemeData theme, [Color? color]) {
    return TextFragment(
      text,
      color == null
          ? theme.textTheme.bodyText1!
          : theme.textTheme.bodyText1!.copyWith(
              color: color,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.w700,
            ),
    ).toTextWidget();
  }

  String _getChannelText() {
    final total = info.numActiveChannels! + info.numInactiveChannels!;
    var pendingText = '';
    if (info.numPendingChannels! > 0) {
      pendingText = trp(
        'lightning.channels.pending_channels',
        info.numPendingChannels,
      );
    }
    if (total == 0) {
      // user has no channels at all
      return tr('lightning.channels.has_no_channel') + pendingText;
    } else if (info.numInactiveChannels == 0 && info.numActiveChannels! > 0) {
      // user has only active channels
      final txt = trp(
        'lightning.channels.has_only_active',
        info.numActiveChannels,
      );
      return txt + pendingText;
    } else if (info.numInactiveChannels! > 0 && info.numActiveChannels == 0) {
      // user has only inactive channels
      final txt = trp(
        'lightning.channels.has_only_inactive',
        info.numActiveChannels,
      );
      return txt + pendingText;
    } else {
      final txt = tr(
        'lightning.channels.has_active_and_inactive',
        {
          'active': info.numActiveChannels,
          'inactive': info.numInactiveChannels,
          'total': total,
        },
      );
      return txt + pendingText;
    }
  }
}
