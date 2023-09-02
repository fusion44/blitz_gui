import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'package:regtest_core/core.dart';

import 'mine_blocks_dlg_content.dart';
import 'widget_utils.dart';

class FundNodesDlgContent extends StatefulWidget {
  final ValueNotifier<FundNodesData> changeNotifier;

  const FundNodesDlgContent(this.changeNotifier, {Key? key}) : super(key: key);

  @override
  State<FundNodesDlgContent> createState() => _FundNodesDlgContentState();
}

class _DataHolder {
  final LnNode node;
  final TextEditingController controller;

  _DataHolder(this.node, this.controller);
}

const _defaultFundingValue = '1,500,000,000';

class _FundNodesDlgContentState extends State<FundNodesDlgContent> {
  final ValueNotifier<MineBlockData> _mineBlocksNotifier =
      ValueNotifier(MineBlockData.empty());
  final _allController = TextEditingController(text: _defaultFundingValue);
  final _individualNodeControllers = <String, _DataHolder>{};
  bool _individual = false;
  bool _autoMine = false;

  @override
  void initState() {
    for (final node in NetworkManager().lnNodes) {
      _individualNodeControllers[node.internalId] = _DataHolder(
        node,
        TextEditingController(text: _defaultFundingValue)
          ..addListener(_updateNotifier),
      );
    }

    _mineBlocksNotifier.addListener(() {
      _updateNotifier();
    });

    _updateNotifier();
    super.initState();
  }

  @override
  void dispose() {
    _allController.dispose();
    _mineBlocksNotifier.dispose();
    for (final data in _individualNodeControllers.values) {
      data.controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rows = [];
    for (final n in NetworkManager().lnNodes) {
      rows.add(
        Row(
          children: [
            Text(n.opts.name),
            const SizedBox(width: 8.0),
            Expanded(
              child: buildNumberTextField(
                'Num Sats',
                _individualNodeControllers[n.internalId]!.controller,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        CheckboxListTile.adaptive(
          value: _individual,
          onChanged: _onIndividualChanged,
          title: const Text('Individualize'),
          contentPadding: const EdgeInsets.all(8),
        ),
        const SizedBox(height: 8),
        if (_individual) ...rows,
        if (!_individual)
          Row(
            children: [
              const SizedBox(width: 8.0),
              const Text('All Equally'),
              const SizedBox(width: 8.0),
              Expanded(child: buildNumberTextField('Num Sats', _allController))
            ],
          ),
        const SizedBox(height: 8),
        CheckboxListTile.adaptive(
          value: _autoMine,
          onChanged: _onAutoMineChanged,
          title: const Text('Auto Mine'),
          contentPadding: const EdgeInsets.all(8),
        ),
        if (_autoMine) MineBlocksDlgContent(_mineBlocksNotifier)
      ],
    );
  }

  void _updateNotifier() {
    final funding = <String, Amount>{};
    if (_individual) {
      for (final data in _individualNodeControllers.values) {
        final amt = Amount.fromSats(validIntOrZero(data.controller.text));
        funding[data.node.internalId] = amt;
      }
    } else {
      final amount = Amount.fromSats(validIntOrZero(_allController.text));
      for (final node in NetworkManager().lnNodes) {
        funding[node.internalId] = amount;
      }
    }

    MineBlockData? mineBlockData;

    if (_autoMine) {
      mineBlockData = MineBlockData(
        _mineBlocksNotifier.value.numBlocks,
        _mineBlocksNotifier.value.delay,
        _mineBlocksNotifier.value.from,
        _mineBlocksNotifier.value.to,
      );
    }

    widget.changeNotifier.value = FundNodesData(
      funding,
      mineBlockData: mineBlockData,
    );
  }

  void _onIndividualChanged(bool? value) =>
      setState(() => _individual = value ?? false);

  void _onAutoMineChanged(bool? value) =>
      setState(() => _autoMine = value ?? false);
}
