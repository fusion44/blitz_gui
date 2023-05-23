import 'package:flutter/material.dart';

import 'package:regtest_core/core.dart';

import 'widget_utils.dart';

class SendOnchainDlgContent extends StatefulWidget {
  final ValueNotifier<SendOnchainDialogData> changeNotifier;
  final LnNode from;

  const SendOnchainDlgContent(this.changeNotifier, this.from, {Key? key})
      : super(key: key);

  @override
  State<SendOnchainDlgContent> createState() => _SendOnchainDlgContentState();
}

class _SendOnchainDlgContentState extends State<SendOnchainDlgContent> {
  final TextEditingController _amountCtrl =
      TextEditingController(text: "10,000");
  final TextEditingController _broadcastDelayCtrl =
      TextEditingController(text: "5");
  final TextEditingController _mineDelayCtrl = TextEditingController(text: "5");
  final TextEditingController _numBlocksCtrl = TextEditingController(text: "3");
  final TextEditingController _addressCtrl = TextEditingController(text: "");

  bool _autoMine = false;
  bool _delay = false;
  bool _hasAddress = false;
  bool _sendAll = false;
  late List<LnNode> _destinationNodes;
  late LnNode _destinationNode;

  @override
  void initState() {
    super.initState();

    _destinationNodes = NetworkManager().nodeList..remove(widget.from);
    _destinationNode = _destinationNodes.first;
    _amountCtrl.addListener(_updateNotifier);
    _amountCtrl.text = genRandomNumberAsFormattedText(min: 10000, max: 200000);
    _broadcastDelayCtrl.addListener(_updateNotifier);
    _mineDelayCtrl.addListener(_updateNotifier);
    _numBlocksCtrl.addListener(_updateNotifier);
    _addressCtrl.addListener(_updateNotifier);
    _addressCtrl.addListener(() {
      if (_hasAddress != _addressCtrl.text.isNotEmpty) {
        setState(() {
          _hasAddress = _addressCtrl.text.isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _amountCtrl.dispose();
    _broadcastDelayCtrl.dispose();
    _mineDelayCtrl.dispose();
    _numBlocksCtrl.dispose();
    _addressCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!_hasAddress)
          Row(
            children: [
              const Text("Destination: "),
              const Spacer(),
              DropdownButton(
                value: _destinationNode,
                items: _destinationNodes
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.alias),
                        ))
                    .toList(),
                onChanged: ((value) {
                  setState(() {
                    if (value is LnNode) {
                      _destinationNode = value;
                      _updateNotifier();
                    }
                  });
                }),
              ),
            ],
          ),
        buildCancelableTextField(),
        if (!_sendAll) buildNumberTextField("Amount", _amountCtrl),
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
        CheckboxListTile(
          title: const Text("Send All"),
          value: _sendAll,
          onChanged: (value) => setState(() {
            if (value != null) {
              _sendAll = value;
              _updateNotifier();
              return;
            }

            _sendAll = false;
          }),
        ),
      ],
    );
  }

  Widget buildCancelableTextField() {
    return Row(
      children: [
        Flexible(
          child: Tooltip(
            message:
                "Address to send the funds to.\nIf empty, the funds will be sent to the destination node (see dropdown above)",
            child: TextField(
              decoration: const InputDecoration(labelText: "Address"),
              controller: _addressCtrl,
              autofocus: true,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: IconButton(
            icon: const Icon(Icons.clear_outlined),
            onPressed: () {
              _addressCtrl.text = "";
              _updateNotifier();
            },
          ),
        ),
      ],
    );
  }

  void _updateNotifier() {
    widget.changeNotifier.value = SendOnchainDialogData(
      numSats: _sendAll ? 0 : validIntOrZero(_amountCtrl.text),
      delayBroadcast: _delay,
      broadcastDelay: validIntOrZero(_broadcastDelayCtrl.text),
      autoMine: _autoMine,
      mineDelay: validIntOrZero(_mineDelayCtrl.text),
      numBlocks: validIntOrZero(_numBlocksCtrl.text),
      address: _addressCtrl.text,
      destination: _destinationNode,
      sendAll: _sendAll,
    );
  }
}
