import 'package:flutter/material.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ndialog/ndialog.dart';
import 'package:regtest_core/core.dart';

import '../send_onchain_dlg_content.dart';
import '../tool_button.dart';
import '../widget_utils.dart';

class SendOnchainButton extends StatefulWidget {
  final LnNode node;
  const SendOnchainButton(this.node, {super.key});

  @override
  State<SendOnchainButton> createState() => _SendOnchainButtonState();
}

class _SendOnchainButtonState extends State<SendOnchainButton> {
  String _status = '';
  @override
  Widget build(BuildContext context) {
    return ToolButton(
      onPressed: () => _sendOnchain(context, widget.node),
      tooltip: "Send coins on-chain",
      label: "Send Coins",
      icon: Icons.send,
      status: _status,
      disabled: _status.isNotEmpty,
    );
  }

  _sendOnchain(BuildContext context, LnNode n) async {
    final ValueNotifier<SendOnchainDialogData> notifier =
        ValueNotifier<SendOnchainDialogData>(SendOnchainDialogData.empty());

    final ok = await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text("Send Coins [${n.id}]"),
      content: SendOnchainDlgContent(notifier, n),
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

    String destAddr = data.address;
    final destNode = data.destination;

    assert(destNode != null || destAddr.isNotEmpty);

    if (destAddr.isEmpty) {
      destAddr = await destNode!.newAddress();
    }

    try {
      setState(() => _status = "Broadcasting ...");
      final res = await n.sendOnChain(data.numSats, destAddr, data.sendAll);

      if (!mounted) return;

      buildSnackbar(
        context,
        ct: ContentType.success,
        title: "Success",
        msg: res!.txid,
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
          await doMineBlocks(1);
        } catch (e) {
          debugPrint(e.toString());
        }
        setState(() => _status = "");
      }
    }

    setState(() => _status = "");
  }
}
