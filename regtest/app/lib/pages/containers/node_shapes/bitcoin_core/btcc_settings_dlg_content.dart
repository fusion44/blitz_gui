import 'package:flutter/material.dart';

import 'package:regtest_core/core.dart';

class BtccSettingsDlgContent extends StatefulWidget {
  final ValueNotifier<BitcoinCoreOptions> changeNotifier;
  final ContainerOptions opts;
  final String internalId;

  const BtccSettingsDlgContent(
    this.changeNotifier,
    this.opts,
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

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController(
      text: widget.opts.name
          .replaceFirst(_fixedPrefix, '')
          .replaceAll('$dockerContainerNameDelimiter${widget.internalId}', ''),
    );
    _nameCtrl.addListener(_updateNotifier);

    _imageCtrl = TextEditingController(text: widget.opts.image);
    _imageCtrl.addListener(_updateNotifier);

    _workDirCtrl = TextEditingController(text: widget.opts.workDir);
    _workDirCtrl.addListener(_updateNotifier);

    _updateNotifier();
  }

  @override
  void dispose() {
    super.dispose();

    _nameCtrl.dispose();
    _imageCtrl.dispose();
    _workDirCtrl.dispose();
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
        TextField(controller: _workDirCtrl),
      ],
    );
  }

  void _updateNotifier() {
    widget.changeNotifier.value = BitcoinCoreOptions(
      name: _fixedPrefix + _nameCtrl.text,
      image: _imageCtrl.text,
      workDir: _workDirCtrl.text,
    );
  }
}
