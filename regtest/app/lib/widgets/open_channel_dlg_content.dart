import 'package:flutter/material.dart';

import 'package:regtest_core/core.dart';

import 'widget_utils.dart';

class OpenChannelDlgContent extends StatefulWidget {
  final ValueNotifier<OpenChannelDialogData> changeNotifier;
  final LnContainer from;
  final LnContainer? to;
  const OpenChannelDlgContent(
    this.changeNotifier,
    this.from, {
    Key? key,
    this.to,
  }) : super(key: key);

  @override
  State<OpenChannelDlgContent> createState() => _OpenChannelDlgContentState();
}

class _OpenChannelDlgContentState extends State<OpenChannelDlgContent> {
  final TextEditingController _chanSizeCtrl =
      TextEditingController(text: "5,000,000");
  final TextEditingController _pushSatsCtrl = TextEditingController(text: "0");
  final TextEditingController _broadcastDelayCtrl =
      TextEditingController(text: "5");
  final TextEditingController _mineDelayCtrl = TextEditingController(text: "5");
  final TextEditingController _numBlocksCtrl = TextEditingController(text: "3");

  bool _autoMine = false;
  bool _delay = false;
  late List<LnContainer> _destinationNodes;
  late LnContainer _destinationNode;

  @override
  void initState() {
    super.initState();

    _destinationNodes = NetworkManager().lnNodes..remove(widget.from);
    _destinationNode = widget.to ?? _destinationNodes.first;
    _chanSizeCtrl.addListener(_updateNotifier);
    _pushSatsCtrl.addListener(_updateNotifier);
    _broadcastDelayCtrl.addListener(_updateNotifier);
    _mineDelayCtrl.addListener(_updateNotifier);
    _numBlocksCtrl.addListener(_updateNotifier);

    _updateNotifier();
  }

  @override
  void dispose() {
    super.dispose();

    _chanSizeCtrl.dispose();
    _broadcastDelayCtrl.dispose();
    _mineDelayCtrl.dispose();
    _numBlocksCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Text("Destination: "),
            const Spacer(),
            DropdownButton<LnContainer>(
              value: _destinationNode,
              items: _destinationNodes
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList(),
              onChanged: ((value) {
                setState(() {
                  if (value is LnContainer) {
                    _destinationNode = value;
                    _updateNotifier();
                  }
                });
              }),
            ),
          ],
        ),
        buildNumberTextField("Chan Size (sats)", _chanSizeCtrl),
        buildNumberTextField("Push Amt (sats)", _pushSatsCtrl),
        CheckboxListTile(
          title: const Text("Delay Broadcast"),
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
          Tooltip(
            message:
                "Number of seconds until the transaction is submitted to the mempool",
            child: buildNumberTextField("Broadcast Delay", _broadcastDelayCtrl),
          ),
        CheckboxListTile(
          title: const Text("Auto Mine"),
          value: _autoMine,
          onChanged: (value) => setState(() {
            if (value != null) {
              _autoMine = value;
              _updateNotifier();
              return;
            }

            _autoMine = false;
          }),
        ),
        if (_autoMine)
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Tooltip(
                  message: "Number of seconds between each mined block",
                  child: buildNumberTextField("Mine Delay (s)", _mineDelayCtrl),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(child: buildNumberTextField("Blocks", _numBlocksCtrl)),
            ],
          ),
      ],
    );
  }

  void _updateNotifier() {
    widget.changeNotifier.value = OpenChannelDialogData(
      numSats: validIntOrZero(_chanSizeCtrl.text),
      numPushSats: validIntOrZero(_pushSatsCtrl.text),
      delayBroadcast: _delay,
      broadcastDelay: validIntOrZero(_broadcastDelayCtrl.text),
      autoMine: _autoMine,
      mineDelay: validIntOrZero(_mineDelayCtrl.text),
      numBlocks: validIntOrZero(_numBlocksCtrl.text),
      destination: _destinationNode,
    );
  }
}
