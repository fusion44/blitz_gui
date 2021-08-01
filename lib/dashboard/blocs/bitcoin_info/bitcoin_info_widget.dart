import 'package:flutter/material.dart';

import '../../../common/utils.dart';
import '../../text_fragment.dart';
import 'bitcoin_info_model.dart';

class BitcoinInfoWidget extends StatelessWidget {
  final BitcoinInfo info;

  const BitcoinInfoWidget(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              _buildTextFragment('Bitcoin ', theme),
              _buildTextFragment(info.subversion!, theme, Colors.green),
              Spacer(),
              _buildTextFragment(
                trp('bitcoin.connections', info.connections),
                theme,
                _getConnectionsColor(),
              ),
            ],
          ),
          Row(
            children: [
              _buildTextFragment('${tr('bitcoin.block_height_short')} ', theme),
              _buildTextFragment(_buildBlocksText(), theme, Colors.green),
              Spacer(),
              _buildTextFragment('${tr('bitcoin.sync_status_short')} ', theme),
              _buildTextFragment(_buildSyncText(), theme, Colors.green),
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

  String _buildSyncText() {
    if (info.verificationProgress == 1) return '100%';
    return '${(100 * info.verificationProgress!).toStringAsFixed(1)}%';
  }

  String _buildBlocksText() {
    if (info.verificationProgress == 1) return '${info.blocks}';
    return '${info.blocks}/${info.headers}';
  }

  Color? _getConnectionsColor() {
    if (info.connections == 0) {
      return Colors.red;
    } else if (info.connections == 1) {
      return Colors.orange;
    }
  }
}
