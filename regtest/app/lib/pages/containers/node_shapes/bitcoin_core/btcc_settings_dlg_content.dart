import 'package:flutter/material.dart';

import 'package:regtest_core/core.dart';

class BtccSettingsDlgContent extends StatefulWidget {
  final ValueNotifier<BitcoinCoreOptions> changeNotifier;
  final String internalId;

  const BtccSettingsDlgContent(
    this.changeNotifier,
    this.internalId, {
    Key? key,
  }) : super(key: key);

  @override
  State<BtccSettingsDlgContent> createState() => _BtccSettingsDlgContentState();
}

class _BtccSettingsDlgContentState extends State<BtccSettingsDlgContent> {
  final String _fixedPrefix = '${projectName}_';
  late final TextEditingController _nameCtrl;
  late final TextEditingController _imageCtrl;
  late final TextEditingController _workDirCtrl;
  late final TextEditingController _walletNameCtrl;
  bool _makePublic = false;
  bool _fundWallet = false;

  @override
  void initState() {
    super.initState();

    final opts = widget.changeNotifier.value;

    _nameCtrl = TextEditingController(
      text: opts.name
          .replaceFirst(_fixedPrefix, '')
          .replaceAll('$dockerContainerNameDelimiter${widget.internalId}', ''),
    );
    _nameCtrl.addListener(_updateNotifier);

    _imageCtrl = TextEditingController(text: opts.image);
    _imageCtrl.addListener(_updateNotifier);

    _workDirCtrl = TextEditingController(text: opts.workDir);
    _workDirCtrl.addListener(_updateNotifier);

    _walletNameCtrl = TextEditingController(text: opts.walletName);
    _walletNameCtrl.addListener(_updateNotifier);

    _makePublic = opts.makeDataDirPublic;
    _fundWallet = opts.fundWallet;

    _updateNotifier();
  }

  @override
  void dispose() {
    super.dispose();

    _nameCtrl.dispose();
    _imageCtrl.dispose();
    _workDirCtrl.dispose();
    _walletNameCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Tooltip(message: 'Project name', child: Text(_fixedPrefix)),
            Flexible(child: TextField(controller: _nameCtrl)),
            const Text(dockerContainerNameDelimiter),
            Tooltip(message: 'Internal ID', child: Text(widget.internalId)),
          ],
        ),
        TextField(controller: _imageCtrl),
        Row(
          children: [
            Expanded(child: TextField(controller: _workDirCtrl)),
            const SizedBox(width: 8.0),
            SizedBox(
              width: 120,
              child: Tooltip(
                message:
                    "⚠️ Checking this will ask for the sudo password after container startup!",
                child: CheckboxListTile(
                  title: const Text("public"),
                  value: _makePublic,
                  onChanged: (value) => setState(() {
                    _makePublic = value ?? false;
                    _updateNotifier();
                  }),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(child: TextField(controller: _walletNameCtrl)),
            const SizedBox(width: 8.0),
            SizedBox(
              width: 120,
              child: Tooltip(
                message:
                    "⚠️ Checking this will auto mine about 100 blocks until the block reward is unlocked!",
                child: CheckboxListTile(
                  title: const Text("auto fund"),
                  value: _fundWallet,
                  onChanged: (value) => setState(() {
                    _fundWallet = value ?? false;
                    _updateNotifier();
                  }),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  void _updateNotifier() {
    widget.changeNotifier.value = BitcoinCoreOptions(
      name: _fixedPrefix + _nameCtrl.text,
      image: _imageCtrl.text,
      workDir: _workDirCtrl.text,
      makeDataDirPublic: _makePublic,
      fundWallet: _fundWallet,
      walletName: _walletNameCtrl.text,
    );
  }
}
