import 'package:blitz_api_client/blitz_api_client.dart';
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
  final LnContainer node;
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
            if (_statuses[n.internalId] != null)
              Text(_statuses[n.internalId]!, textAlign: TextAlign.center),
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

  _genInvoice(BuildContext c, LnContainer n) async {
    final ValueNotifier<GenInvoiceDialogData> invData =
        ValueNotifier<GenInvoiceDialogData>(GenInvoiceDialogData.empty(n));

    var res = await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text("New Invoice [${n.name}]"),
      content: GenInvoiceDlgContent(invData, n),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () => Navigator.pop(c, "OK"),
        ),
      ],
    ).show(context);

    if (res == null && res != "OK") return;

    final bapi = NetworkManager().findComplementaryNode(n);

    if (!mounted) return;
    if (bapi == null) {
      buildSnackbar(
        c,
        msg: "Unable to find complementary node",
        ct: ContentType.failure,
      );

      return;
    }

    Invoice? invoice = await bapi.genInvoice(invData.value);

    if (!mounted || invoice == null) return;

    if (invData.value.payer == null) {
      copyToClipboardWithNotification(c, invoice.paymentRequest ?? '');
      return;
    }

    if (invData.value.payDelay > 0) {
      await _delayWithNotification(invData.value.payDelay, 'pay invoice');
    }

    widget.setNotificationCallback('Attempting send payment');
    try {
      Payment res = await invData.value.payer!.payInvoice(
        PayInvoiceData(
          invoice.paymentRequest!,
          invoice.valueMsat == 0 ? invData.value.payAmt : null,
        ),
      );

      if (mounted && res.status == PaymentStatus.succeeded) {
        buildSnackbar(
          context,
          title: 'Nice!',
          msg: 'Invoice paid successfully',
          ct: ContentType.success,
        );
      }
    } on ApiError catch (e) {
      if (!mounted) return;
      buildSnackbar(
        context,
        title: e.message,
        msg: e.detail,
        ct: ContentType.failure,
      );
    }

    widget.setNotificationCallback('');
  }

  _newAddress(BuildContext c, LnContainer n) async {
    final bapi = NetworkManager().findComplementaryNode(n);
    if (bapi == null) {
      return buildSnackbar(c, msg: "Unable to find complementary node");
    }

    String addr = await bapi.newAddress();
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
