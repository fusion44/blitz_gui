import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:regtest_core/core.dart';

import '../add_junk_tx_dlg_content.dart';
import '../tool_button.dart';

class AddJunkTxButton extends StatefulWidget {
  final LnNode node;

  const AddJunkTxButton(this.node, {super.key});

  @override
  State<AddJunkTxButton> createState() => _AddJunkTxButtonState();
}

class _AddJunkTxButtonState extends State<AddJunkTxButton> {
  String _status = '';

  @override
  Widget build(BuildContext context) {
    return ToolButton(
      onPressed: () => _addJunkTx(widget.node),
      status: _status,
      tooltip:
          "Adds a specified amount of invoices and transactions to the node",
      label: "Add Junk Tx",
      icon: Icons.data_exploration_outlined,
      disabled: _status.isNotEmpty,
    );
  }

  _addJunkTx(LnNode node) async {
    final notifier = ValueNotifier<AddJunkTxDlgData>(
      AddJunkTxDlgData.empty(node),
    );

    var res = await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text("Add Tx Junk to ${node.id}"),
      content: AddJunkTxDlgContent(notifier, node),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () => Navigator.pop(context, "OK"),
        ),
      ],
    ).show(context);

    if (res == null && res != "OK") return;

    _status = "Junking: 0 %";
    addJunkTx(notifier.value).listen(
        (event) => setState(() {
              var status = "Junking: ${event.percent} %";
              if (event.msg != "") {
                status = "$status\n(${event.msg})";
              }
              _status = status;
            }),
        onError: (error) => setState(() => _status = ""),
        onDone: () => setState(() => _status = ""));
  }
}
