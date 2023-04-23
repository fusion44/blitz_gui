import 'package:flutter/material.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ndialog/ndialog.dart';
import 'package:regtest_core/core.dart';

import 'gen_invoice_dlg_content.dart';
import 'toolbox_buttons/add_junk_tx_button.dart';
import 'toolbox_buttons/send_onchain_button.dart';
import 'widget_utils.dart';

class ToolButtonsCard extends StatefulWidget {
  final void Function(String message) setNotificationCallback;
  final LnNode node;
  const ToolButtonsCard(this.node, this.setNotificationCallback, {super.key});

  @override
  State<ToolButtonsCard> createState() => _ToolButtonsCardState();
}

class _ToolButtonsCardState extends State<ToolButtonsCard> {
  final Map<String, String> _statuses = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final n = widget.node;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.handyman_rounded),
                const SizedBox(width: 8.0),
                Text(
                  "Toolbox",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            if (_statuses[n.id] != null)
              Text(_statuses[n.id]!, textAlign: TextAlign.center),
            const SizedBox(height: 8.0),
            const SizedBox(height: 8.0),
            _wrapToolBtn(AddJunkTxButton(n)),
            const SizedBox(height: 8.0),
            _addToolBtn(
              () => _genInvoice(context, n),
              "Generates a new invoice.",
              "Gen Invoice",
              Icons.offline_bolt,
            ),
            const SizedBox(height: 8.0),
            _addToolBtn(
              () => _newAddress(context, n),
              "Generates a new on-chain address.",
              "OnChain Addr",
              Icons.link,
            ),
            const SizedBox(height: 8.0),
            _wrapToolBtn(SendOnchainButton(n))
          ],
        ),
      ),
    );
  }

  Padding _addToolBtn(
    VoidCallback? onPressed,
    String tooltip,
    String label,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Tooltip(
        message: tooltip,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          label: Text(label),
          icon: Icon(icon),
        ),
      ),
    );
  }

  Padding _wrapToolBtn(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: child,
    );
  }

  _genInvoice(BuildContext c, LnNode n) async {
    final ValueNotifier<GenInvoiceDialogData> invData =
        ValueNotifier<GenInvoiceDialogData>(GenInvoiceDialogData.empty(n));

    var res = await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text("New Invoice [${n.id}]"),
      content: GenInvoiceDlgContent(invData, n),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () => Navigator.pop(c, "OK"),
        ),
      ],
    ).show(context);

    if (res == null && res != "OK") return;

    String invoice = await n.genInvoice(invData.value);

    if (!mounted) return;

    if (invData.value.payer == null) {
      copyToClipboardWithNotification(c, invoice);
      return;
    }

    if (invData.value.payDelay > 0) {
      await _delayWithNotification(invData.value.payDelay, "pay invoice");
    }

    widget.setNotificationCallback("Attempting send payment");
    res = await invData.value.payer!.payInvoice(
      PayInvoiceData(invoice, invData.value.payAmt),
    );

    if (!mounted) return;

    if (res.success) {
      buildSnackbar(
        context,
        title: "Nice!",
        msg: "Invoice paid successfully",
        ct: ContentType.success,
      );
    }

    widget.setNotificationCallback("");
  }

  _newAddress(BuildContext c, LnNode n) async {
    String addr = await n.newAddress();
    if (addr.isNotEmpty && mounted) {
      copyToClipboardWithNotification(c, addr);
    }
  }

  Future<void> _delayWithNotification(int delay, String message) async {
    for (var i = 0; i < delay; i++) {
      widget.setNotificationCallback(
        "task $message scheduled in ${delay - i} seconds",
      );

      await Future.delayed(const Duration(seconds: 1));
    }

    widget.setNotificationCallback("");
  }
}
