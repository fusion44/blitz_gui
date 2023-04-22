import 'package:flutter/material.dart';
import 'package:regtest_core/core.dart';

import 'widget_utils.dart';

class MineBlocksDlgContent extends StatefulWidget {
  final ValueNotifier<MineBlockData> changeNotifier;

  const MineBlocksDlgContent(this.changeNotifier, {Key? key}) : super(key: key);

  @override
  State<MineBlocksDlgContent> createState() => _MineBlocksDlgContentState();
}

class _MineBlocksDlgContentState extends State<MineBlocksDlgContent> {
  static const double _topPadding = 12.0;

  final _numBlocksCtrl = TextEditingController(text: "5");
  final _fromSeconds = TextEditingController(text: "2");
  final _toSeconds = TextEditingController(text: "2");
  bool _delay = false;

  @override
  void initState() {
    _numBlocksCtrl.addListener(_updateNotifier);
    _fromSeconds.addListener(_updateNotifier);
    _toSeconds.addListener(_updateNotifier);

    super.initState();
  }

  @override
  void dispose() {
    _numBlocksCtrl.dispose();
    _fromSeconds.dispose();
    _toSeconds.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CheckboxListTile(
            title: const Text("Delay"),
            value: _delay,
            onChanged: (value) => setState(() {
              if (value != null) {
                _delay = value;
                _updateNotifier();
                return;
              }

              _delay = false;
            }),
          ),
          if (_delay)
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: _topPadding),
                  child: Text('from'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: 50,
                    child: buildNumberTextField("", _fromSeconds),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: _topPadding),
                  child: Text('to'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: 50,
                    child: buildNumberTextField("", _toSeconds),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: _topPadding),
                  child: Text('seconds'),
                ),
              ],
            ),
          buildNumberTextField("Number of blocks to mine", _numBlocksCtrl)
        ],
      ),
    );
  }

  void _updateNotifier() {
    widget.changeNotifier.value = MineBlockData(
      validIntOrZero(_numBlocksCtrl.text),
      _delay,
      validIntOrZero(_fromSeconds.text),
      validIntOrZero(_toSeconds.text),
    );
  }
}
