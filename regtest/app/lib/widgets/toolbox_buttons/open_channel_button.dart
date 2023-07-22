import 'package:flutter/material.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ndialog/ndialog.dart';
import 'package:regtest_core/core.dart';

import '../open_channel_dlg_content.dart';
import '../tool_button.dart';
import '../widget_utils.dart';

class OpenChannelButton extends StatefulWidget {
  final LnNode node;
  const OpenChannelButton(this.node, {super.key});

  @override
  State<OpenChannelButton> createState() => _OpenChannelButtonState();
}

class _OpenChannelButtonState extends State<OpenChannelButton> {
  String _status = '';
  @override
  Widget build(BuildContext context) {
    return ToolButton(
      onPressed: () => _openChannel(context, widget.node),
      tooltip: "Open a channel to another node",
      label: "Open",
      icon: Icons.new_label,
      status: _status,
      disabled: _status.isNotEmpty,
    );
  }

  _openChannel(BuildContext context, LnNode n) async {
    final ValueNotifier<OpenChannelDialogData> notifier =
        ValueNotifier<OpenChannelDialogData>(OpenChannelDialogData.empty());

    final ok = await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text("Open Channel [${n.name}]"),
      content: OpenChannelDlgContent(notifier, n),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () => Navigator.pop(context, "OK"),
        ),
      ],
    ).show(context);

    if (ok == null || ok != "OK") return;

    final data = notifier.value;

    if (data.delayBroadcast) {
      for (var x = 0; x < data.broadcastDelay; x++) {
        setState(
          () => _status = "Broadcasting in ${data.broadcastDelay - x} s",
        );
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    final destNode = data.destination;
    assert(destNode != null);

    try {
      setState(() => _status = "Broadcasting ...");
      final res = await n.openChannel(
        destNode!,
        localFundingAmount: data.numSats,
        pushAmountSat: data.numPushSats,
      );

      if (!mounted) return;

      buildSnackbar(
        context,
        ct: ContentType.success,
        title: "Success",
        msg: res,
      );
    } catch (e) {
      if (!mounted) return;

      setState(() => _status = "");
      debugPrint(e.toString());
      buildSnackbar(context, title: "Error", msg: e.toString());
    }

    if (data.autoMine) {
      for (var x = 0; x < data.numBlocks; x++) {
        if (data.mineDelay > 0) {
          for (var y = 0; y < data.mineDelay; y++) {
            setState(() => _status = """
Mining in ${data.mineDelay - y} s
${data.numBlocks - x} blocks left
                                """);
            await Future.delayed(const Duration(seconds: 1));
          }
        }

        try {
          final btcc = NetworkManager().findFirstOf<BitcoinCoreContainer>();
          if (btcc == null) {
            throw StateError('BitcoinCoreContainer not found');
          }

          await btcc.mineBlocks(1);
        } catch (e) {
          debugPrint(e.toString());
        }
        setState(() => _status = "");
      }
    }

    setState(() => _status = "");
  }
}
