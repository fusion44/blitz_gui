import 'dart:math';

import 'package:flutter/material.dart';

import 'package:regtest_core/core.dart';

import 'widget_utils.dart';

class GenInvoiceDlgContent extends StatefulWidget {
  final ValueNotifier<GenInvoiceDialogData> changeNotifier;
  final LnNode payeeNode;

  const GenInvoiceDlgContent(this.changeNotifier, this.payeeNode, {Key? key})
      : super(key: key);

  @override
  State<GenInvoiceDlgContent> createState() => _GenInvoiceDlgContentState();
}

class _GenInvoiceDlgContentState extends State<GenInvoiceDlgContent> {
  final TextEditingController _memoCtrl = TextEditingController();
  final TextEditingController _mSatCtrl = TextEditingController();
  bool _autoPay = false;
  late LnNode _payerNode;
  final TextEditingController _payDelayCtrl = TextEditingController(text: "0");
  final TextEditingController _payAmt = TextEditingController(text: "0");

  @override
  void initState() {
    _memoCtrl.addListener(_updateNotifier);
    _mSatCtrl.addListener(_updateNotifier);
    _payerNode = NetworkManager().lnNodes.last;
    _payDelayCtrl.addListener(_updateNotifier);
    _payAmt.addListener(_updateNotifier);

    super.initState();
  }

  @override
  void dispose() {
    _memoCtrl.dispose();
    _mSatCtrl.dispose();
    _payDelayCtrl.dispose();
    _payAmt.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _memoCtrl,
          decoration: const InputDecoration(labelText: "Memo"),
        ),
        Row(
          children: [
            Flexible(child: buildNumberTextField("Num mSats", _mSatCtrl)),
            IconButton(
              tooltip: "Random amount between 100.000 msat and 1.000.000 msat",
              onPressed: () => _mSatCtrl.text =
                  (Random().nextInt(1000000) + 100000).toString(),
              icon: const Icon(Icons.auto_fix_normal_outlined),
            )
          ],
        ),
        CheckboxListTile(
          title: const Text("Auto Pay"),
          value: _autoPay,
          onChanged: (value) => setState(() {
            if (value != null) {
              _autoPay = value;
              _updateNotifier();
              return;
            }

            _autoPay = false;
          }),
        ),
        if (_autoPay) ...[
          DropdownButton(
            value: _payerNode,
            items: NetworkManager()
                .lnNodes
                .where((element) => element.id != widget.payeeNode.id)
                .map((e) => DropdownMenuItem(value: e, child: Text(e.alias)))
                .toList(),
            onChanged: ((value) {
              setState(() {
                if (value is LnNode) {
                  _payerNode = value;
                  _updateNotifier();
                }
              });
            }),
          ),
          Tooltip(
            message:
                "The auto pay will be executed after this specified amount of seconds",
            child: buildNumberTextField("Pay Delay", _payDelayCtrl),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(child: buildNumberTextField("Pay Amount mSat", _payAmt)),
              IconButton(
                tooltip:
                    "Random amount between 100.000 msat and 1.000.000 msat",
                onPressed: () => _payAmt.text =
                    (Random().nextInt(1000000) + 100000).toString(),
                icon: const Icon(Icons.auto_fix_normal_outlined),
              ),
              IconButton(
                tooltip: "Sets the amount equal to invoice amount",
                onPressed: () => _payAmt.text = _mSatCtrl.text,
                icon: const Icon(Icons.sync_alt),
              )
            ],
          ),
        ],
      ],
    );
  }

  void _updateNotifier() {
    widget.changeNotifier.value = GenInvoiceDialogData(
      node: widget.payeeNode,
      mSat: validIntOrZero(_mSatCtrl.text),
      msg: _memoCtrl.text,
      payDelay: _autoPay ? validIntOrZero(_payDelayCtrl.text) : 0,
      payer: _autoPay ? _payerNode : null,
    );
  }
}
