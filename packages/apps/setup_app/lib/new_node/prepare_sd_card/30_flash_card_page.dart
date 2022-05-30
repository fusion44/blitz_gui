// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:common/common.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:setup_app/new_node/prepare_sd_card/models/setup_info_box.dart';

import 'models/file_data.dart';

class FlashCardPage extends StatefulWidget {
  final List<FileData> files;

  const FlashCardPage({Key? key, required this.files}) : super(key: key);

  @override
  State<FlashCardPage> createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  bool _etcherWorking = false;
  bool _etcherError = false;
  String _etcherPath = '';
  String _imagePath = '';
  String _errorMessage = '';

  @override
  void initState() {
    _etcherPath = widget.files.firstWhere((f) => f.id == DlFile.etcher).path;
    _imagePath = widget.files.firstWhere((f) => f.id == DlFile.image).path;
    _launchEtcher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const TrText('setup.appbar_title')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600.0),
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                ..._buildTop(theme, 'Flash SD card'),
                if (_etcherWorking) ...[
                  const SizedBox(height: 20.0),
                  const TrText('setup.sd_cart_waiting_for_etcher'),
                  const SizedBox(height: 36.0),
                  const RepaintBoundary(
                    child: SpinKitFadingCube(color: Colors.greenAccent),
                  ),
                ] else if (_etcherError)
                  ..._buildErrorUi()
                else
                  ..._buildSuccessUi(context, theme)
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTop(ThemeData theme, String step) {
    return [
      BreadCrumb(
        items: <BreadCrumbItem>[
          BreadCrumbItem(content: const Text('Blitz')),
          BreadCrumbItem(content: const Text('Setup')),
          BreadCrumbItem(content: const Text('New Node')),
          BreadCrumbItem(content: const Text('Prepare SD Card')),
          BreadCrumbItem(content: Text(step)),
        ],
        divider: const Icon(Icons.chevron_right),
      ),
    ];
  }

  void _launchEtcher() async {
    setState(() {
      _etcherWorking = true;
    });

    // Make Etcher executable
    await Process.run('chmod', ['+x', _etcherPath]);

    // Execute Etcher
    final res = await Process.run(_etcherPath, [_imagePath]);
    if (res.exitCode != 0) {
      setState(() {
        _errorMessage = res.stderr.toString();
        _etcherWorking = false;
        _etcherError = true;
      });
      return;
    }
    // TODO: Check return code

    _showSDCardFlashAlert();
  }

  void _showSDCardFlashAlert() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext c) {
          return AlertDialog(
            title: const TrText('setup.dialog.sd_card_flash_success_title'),
            content: const TrText('setup.dialog.sd_card_flash_success_content'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const TrText('alert_dialog.retry', isButton: true),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const TrText('alert_dialog.ok', isButton: true),
              ),
            ],
          );
        },
      );
      if (result != null && result) {
        setState(() => _etcherWorking = false);
      }
    });
  }

  List<Widget> _buildErrorUi() {
    return [
      const SizedBox(height: 16),
      const TrText(
        'setup.errors.error_message_header',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      Text(
        _errorMessage,
        style: const TextStyle(fontSize: 16),
      ),
      const SizedBox(height: 16),
      TextButton(
        onPressed: () => _launchEtcher(),
        child: const TrText('alert_dialog.retry', isButton: true),
      ),
    ];
  }

  List<Widget> _buildSuccessUi(BuildContext context, ThemeData theme) {
    return [
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(MdiIcons.rocket, size: 30, color: Colors.orange),
          const SizedBox(width: 8),
          TrText(
            'setup.success_message_header',
            style: theme.textTheme.headline4,
          ),
          const SizedBox(width: 8),
          const Icon(MdiIcons.rocket, size: 30, color: Colors.orange),
        ],
      ),
      const TrText('setup.sd_card_is_ready_header'),
      const SizedBox(height: 16),
      const SetupInfoBox(text: 'setup.sd_card_ready_next_steps_message'),
      const SizedBox(height: 16),
      const SetupInfoBox(
        text: 'setup.sd_card_ready_delete_downloaded_files',
        icon: Icons.delete_forever,
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () => context.go('/find-device'),
        child: const TrText('alert_dialog.ok', isButton: true),
      ),
    ];
  }
}
