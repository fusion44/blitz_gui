import 'dart:math';

import 'package:flutter/material.dart';

import 'package:regtest_core/core.dart';

import 'widget_utils.dart';

class GenInvoiceDlgContent extends StatefulWidget {
  final ValueNotifier<GenInvoiceDialogData> changeNotifier;
  final LnContainer payeeNode;

  const GenInvoiceDlgContent(this.changeNotifier, this.payeeNode, {Key? key})
      : super(key: key);

  @override
  State<GenInvoiceDlgContent> createState() => _GenInvoiceDlgContentState();
}

class _GenInvoiceDlgContentState extends State<GenInvoiceDlgContent> {
  final TextEditingController _memoCtrl =
      TextEditingController(text: genRandomWords());
  final TextEditingController _mSatCtrl = TextEditingController(text: '0');
  bool _autoPay = false;
  LnContainer? _payerNode;
  final TextEditingController _payDelayCtrl = TextEditingController(text: '0');
  final TextEditingController _payAmt = TextEditingController(text: '0');

  @override
  void initState() {
    _memoCtrl.addListener(_updateNotifier);
    _mSatCtrl.addListener(() => _payAmt.text = _mSatCtrl.text);
    _payerNode = getRandNode(widget.payeeNode);
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
                .where((element) =>
                    element.internalId != widget.payeeNode.internalId)
                .map((e) => DropdownMenuItem(
                    value: e, child: Text('${e.name} (${e.type})')))
                .toList(),
            onChanged: ((value) {
              setState(() {
                if (value is LnContainer) {
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
          if (widget.changeNotifier.value.mSat == 0)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: buildNumberTextField("Pay Amount mSat", _payAmt),
                ),
                IconButton(
                  tooltip:
                      "Random amount between 100.000 msat and 1.000.000 msat",
                  onPressed: () => _payAmt.text =
                      (Random().nextInt(1000000) + 100000).toString(),
                  icon: const Icon(Icons.auto_fix_normal_outlined),
                ),
              ],
            ),
        ],
      ],
    );
  }

  void _updateNotifier() {
    BlitzApiContainer? payer;
    final int oldInvoiceAmt = widget.changeNotifier.value.mSat;
    final int newInvoiceAmt = validIntOrZero(_mSatCtrl.text);
    final int payAmt = validIntOrZero(_payAmt.text);

    if (_autoPay) {
      payer = NetworkManager().findComplementaryNode(_payerNode!);

      if (payer == null) {
        throw StateError('Auto pay is true but no payer node found');
      }
    }

    widget.changeNotifier.value = GenInvoiceDialogData(
      node: widget.payeeNode,
      mSat: newInvoiceAmt,
      msg: _memoCtrl.text,
      payDelay: _autoPay ? validIntOrZero(_payDelayCtrl.text) : 0,
      payer: payer,
      payAmt: payAmt,
    );

    if (oldInvoiceAmt == 0 && newInvoiceAmt > 0) {
      setState(() {});
    } else if (newInvoiceAmt == 0 && oldInvoiceAmt > 0) {
      setState(() {});
    }
  }
}
