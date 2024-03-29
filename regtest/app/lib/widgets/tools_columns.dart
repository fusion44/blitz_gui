import 'package:flutter/material.dart';

import 'package:regtest_core/core.dart';

import 'channels_card.dart';
import 'tools_buttons_card.dart';
import 'wallet_balance_card.dart';
import 'widget_utils.dart';

class ToolsColumns extends StatefulWidget {
  final void Function(String message) setNotificationCallback;
  final List<LnNode> nodes;
  const ToolsColumns(this.setNotificationCallback, this.nodes, {Key? key})
      : super(key: key);

  @override
  State<ToolsColumns> createState() => _ToolsColumnsState();
}

class _ToolsColumnsState extends State<ToolsColumns> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: _buildColumns(theme),
    );
  }

  List<Widget> _buildColumns(ThemeData theme) {
    final c = <Widget>[];
    final l = widget.nodes;
    final last = l.length - 1;
    for (var i = 0; i < l.length; i++) {
      final n = l[i];
      c.add(
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(n, theme),
                WalletBalanceCard(n),
                ToolButtonsCard(n, widget.setNotificationCallback),
                ChannelsCard(n),
              ],
            ),
          ),
        ),
      );

      if (i < last) c.add(const VerticalDivider());
    }

    return c;
  }

  Row _buildHeader(LnNode n, ThemeData theme) {
    return Row(
      children: [
        const SizedBox(width: 12.0),
        Text(
          n.id.name,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall,
        ),
        const Spacer(),
        PopupMenuButton<String>(
          onSelected: (String text) {
            if (text == 'logs' || text == 'logs_blitz') {
              getLogs(text, n);
              return;
            }
            copyToClipboardWithNotification(context, text);
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            _buildPopupItem(
              header: 'hostname',
              body: n.hostname,
              value: n.hostname,
              showDivider: true,
            ),
            PopupMenuItem<String>(
              value: 'logs',
              child: Column(
                children: const [
                  Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Node Logs')),
                  Divider(),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'logs_blitz',
              child: Column(
                children: const [
                  Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Blitz Logs')),
                  Divider(),
                ],
              ),
            ),
            _buildPopupItem(
              header: 'token',
              body: n.token ?? 'not loaded ...',
              value: n.token ?? 'not loaded ...',
              showDivider: true,
            ),
            _buildPopupItem(
              header: 'pubkey',
              body: n.pubKey,
              value: n.pubKey,
              showDivider: true,
            ),
            _buildPopupItem(
              header: 'full uri',
              body: n.fullUri,
              value: n.fullUri,
              showDivider: false,
            ),
          ],
        ),
        const SizedBox(width: 12.0),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupItem({
    required String header,
    required String body,
    required String value,
    bool showDivider = true,
  }) {
    return PopupMenuItem<String>(
      value: value,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(header),
          ),
          Text(body),
          if (showDivider) const Divider(),
        ],
      ),
    );
  }

  getLogs(String type, LnNode n) async {
    try {
      List<String> logs = [];
      switch (type) {
        case 'logs':
          logs.addAll(await n.getLogs());
          break;
        case 'logs_blitz':
          logs.addAll(await n.getLogsBlitz());
          break;
        default:
          buildSnackbar(
            context,
            title: 'Failed to get logs',
            msg: 'Log type $type not found',
          );

          return;
      }

      print(logs);
    } on DockerException catch (e) {
      buildSnackbar(context, title: 'Failed to get logs', msg: e.message);
    }
  }
}
