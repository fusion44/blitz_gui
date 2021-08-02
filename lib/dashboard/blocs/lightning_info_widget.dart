import 'package:flutter/material.dart';

import '../../common/utils.dart';
import '../text_fragment.dart';
import '../../common/models/lightning_info.dart';

class LightningInfoWidget extends StatelessWidget {
  final LightningInfo info;

  const LightningInfoWidget(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Column(
        children: [
          Row(children: [
            _buildTextFragment('LND ', theme),
            _buildTextFragment(info.version!, theme, Colors.green),
            Spacer(),
            _buildTextFragment('wallet ', theme),
            _buildTextFragment('68892 sat', theme, Colors.orange),
          ]),
          Row(
            children: [
              _buildTextFragment(_getChannelText(), theme),
              Spacer(),
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
              _buildTextFragment('Fee Report in sat: ', theme),
              _buildTextFragment('11-124-497', theme, Colors.orange),
              _buildTextFragment(' (Day-Week-Month)', theme),
            ],
          ),
        ],
      ),
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
