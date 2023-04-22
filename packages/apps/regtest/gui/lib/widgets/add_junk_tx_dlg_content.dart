import 'package:flutter/material.dart';
import 'package:regtest_core/core.dart';

import 'widget_utils.dart';

class AddJunkTxDlgContent extends StatefulWidget {
  final ValueNotifier<AddJunkTxDlgData> changeNotifier;
  final LnNode node;

  const AddJunkTxDlgContent(this.changeNotifier, this.node, {Key? key})
      : super(key: key);

  @override
  State<AddJunkTxDlgContent> createState() => _AddJunkTxDlgContentState();
}

class _AddJunkTxDlgContentState extends State<AddJunkTxDlgContent> {
  final TextEditingController _numInvoicesCtrl =
      TextEditingController(text: "100");
  final TextEditingController _mSatLowerCtrl =
      TextEditingController(text: "10,000");
  final TextEditingController _mSatUpperCtrl =
      TextEditingController(text: "1,000,000");

  final TextEditingController _numPaysCtrl = TextEditingController(text: "100");
  final TextEditingController _numOnchainCtrl =
      TextEditingController(text: "0");
  final TextEditingController _delayLowerCtrl =
      TextEditingController(text: "0");
  final TextEditingController _delayUpperCtrl =
      TextEditingController(text: "2");

  @override
  void initState() {
    _numInvoicesCtrl.addListener(_updateNotifier);
    _mSatLowerCtrl.addListener(_updateNotifier);
    _mSatUpperCtrl.addListener(_updateNotifier);
    _numPaysCtrl.addListener(_updateNotifier);
    _numOnchainCtrl.addListener(_updateNotifier);
    _delayLowerCtrl.addListener(_updateNotifier);
    _delayUpperCtrl.addListener(_updateNotifier);

    _updateNotifier();

    super.initState();
  }

  @override
  void dispose() {
    _numInvoicesCtrl.dispose();
    _mSatLowerCtrl.dispose();
    _mSatUpperCtrl.dispose();
    _numPaysCtrl.dispose();
    _numOnchainCtrl.dispose();
    _delayLowerCtrl.dispose();
    _delayUpperCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildNumberTextField("Num Invoices", _numInvoicesCtrl),
        buildNumberTextField("Num Payments", _numPaysCtrl),
        buildNumberTextField("Num Onchain (50% in / 50% out)", _numOnchainCtrl),
        _buildSatsRangeRow(),
        Row(
          children: [
            Expanded(
              child:
                  buildNumberTextField("Delay - lower bound", _delayLowerCtrl),
            ),
            Expanded(
              child:
                  buildNumberTextField("Delay - upper bound", _delayUpperCtrl),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildSatsRangeRow() {
    return Row(
      children: [
        Flexible(
          child: buildNumberTextField("mSats - lower bound", _mSatLowerCtrl),
        ),
        const SizedBox(width: 8.0),
        Flexible(
          child: buildNumberTextField("mSats - upper bound", _mSatUpperCtrl),
        ),
      ],
    );
  }

  void _updateNotifier() {
    widget.changeNotifier.value = AddJunkTxDlgData(
      node: widget.node,
      numInvoices: validIntOrZero(_numInvoicesCtrl.text),
      numPayments: validIntOrZero(_numPaysCtrl.text),
      numOnchainTx: validIntOrZero(_numOnchainCtrl.text),
      satsRangeLower: validIntOrZero(_mSatLowerCtrl.text),
      satsRangeUpper: validIntOrZero(_mSatUpperCtrl.text),
      delay: _delayLowerCtrl.text != _delayUpperCtrl.text,
      delayLower: validIntOrZero(_delayLowerCtrl.text),
      delayUpper: validIntOrZero(_delayUpperCtrl.text),
    );
  }
}
