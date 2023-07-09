import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:regtest_core/core.dart';

import '../../../../gui_constants.dart';
import '../../utils.dart';
import '../widgets/action_buttons.dart';
import '../widgets/open_blitz_terminal_btn.dart';
import '../widgets/show_blitz_logs_btn.dart';
import 'lnd_settings_dlg_content.dart';

class LndShape extends StatefulWidget {
  final String lndContainerId;
  final String bapiContainerId;
  final Function()? onDeleted;

  const LndShape(
    this.lndContainerId,
    this.bapiContainerId, {
    this.onDeleted,
    super.key,
  });

  @override
  State<LndShape> createState() => _LndShapeState();
}

class _LndShapeState extends State<LndShape> {
  late final BlitzApiContainerBloc _bapi;
  late final LndContainerBloc _lnd;

  @override
  void initState() {
    super.initState();
    _bapi = BlitzApiContainerBloc(widget.bapiContainerId);
    _lnd = LndContainerBloc(widget.lndContainerId);
  }

  @override
  void dispose() async {
    super.dispose();
    await _bapi.close();
    await _lnd.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LndContainerBloc, LndContainerState>(
      bloc: _lnd,
      builder: (context, state) {
        Widget? footer;

        if (state is! LndStatusUpdate) {
          return Center(child: Text('UNKNOWN STATE $state'));
        }

        if (state.status.status == ContainerStatus.uninitialized) {
          return _buildShape(
              state,
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Container not created, yet.'),
                  ),
                  ElevatedButton.icon(
                    label: const Text('Edit Settings'),
                    onPressed: () => _editSettings(context),
                    icon: const Icon(Icons.settings),
                  )
                ],
              ),
              _buildFooter(ContainerStatus.uninitialized));
        }

        footer = _buildFooter(state.status.status);

        if (state.status.status == ContainerStatus.starting ||
            state.status.status == ContainerStatus.stopping ||
            state.status.status == ContainerStatus.deleting) {
          return _buildShape(
            state,
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: CircularProgressIndicator(),
            ),
            footer,
          );
        }

        if (state.status.status == ContainerStatus.stopped) {
          return _buildShape(
            state,
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text('Container is stopped.'),
            ),
            footer,
          );
        }

        if (state.status.status == ContainerStatus.started) {
          return _buildShape(
            state,
            const Center(child: Text('Running LND')),
            footer,
          );
        }

        return Center(child: Text('UNKNOWN STATE $state'));
      },
    );
  }

  Widget _buildShape(
    LndContainerState state,
    Widget? body,
    Widget? footer,
  ) {
    return Column(children: [
      Image.asset(
        getContainerLogo(ContainerType.lnd),
        height: containerLogoHeaderHeight,
      ),
      body ?? Center(child: Text('Unknown state $state')),
      const Spacer(),
      footer ?? const Text('NOT IMPLEMENTED')
    ]);
  }

  Widget _buildFooter(ContainerStatus status) => switch (status) {
        ContainerStatus.uninitialized => Row(
            children: [
              ElevatedButton(
                  onPressed: _startContainers, child: const Text('Start'))
            ],
          ),
        ContainerStatus.starting => const Row(
            children: [
              ElevatedButton(onPressed: null, child: Text('Starting...')),
            ],
          ),
        ContainerStatus.started => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _stopContainers,
                child: const Text('Stop'),
              ),
              OpenTerminalBtn(() async =>
                  await openTerminalInDialog(context, widget.lndContainerId)),
              ShowLogsBtn(() async =>
                  await openLogWindowInDialog(context, widget.lndContainerId)),
              PopupMenuButton<String>(
                onSelected: (item) => switch (item) {
                  'delete' => _deleteContainers(),
                  'blitz_terminal' => _openBlitzTerminal(context),
                  'blitz_logs' => _showBlitzLogs(context),
                  _ => throw StateError('not implemented $item'),
                },
                itemBuilder: (context) {
                  return [
                    DeleteContainerBtn.asMenuItem(
                      'delete',
                      'Delete Container',
                      iconColor: Colors.redAccent,
                    ),
                    OpenBlitzTerminalBtn.asMenuItem('blitz_terminal'),
                    ShowBlitzLogsBtn.asMenuItem('blitz_logs')
                  ];
                },
              ),
            ],
          ),
        ContainerStatus.stopping => const Row(
            children: [
              ElevatedButton(onPressed: null, child: Text('Stopping...')),
            ],
          ),
        ContainerStatus.stopped => Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _bapi.add(StartBlitzApiContainerEvent());
                  _lnd.add(StartLndContainerEvent());
                },
                child: const Text('Start'),
              ),
              IconButton(
                onPressed: () {
                  _bapi.add(DeleteBlitzApiContainerEvent());
                  _lnd.add(DeleteLndContainerEvent());
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ContainerStatus.deleting || ContainerStatus.deleted => Container(),
        _ => Text('not implemented $status'),
      };

  _editSettings(BuildContext context) async {
    final c = NetworkManager().nodeMap[widget.lndContainerId] as LndContainer;
    final ValueNotifier<LndOptions> notifier = ValueNotifier<LndOptions>(
      LndOptions(name: c.containerName, image: c.image, workDir: c.dataPath),
    );

    final opts = LndOptions(
      name: c.containerName,
      image: c.image,
      workDir: c.dataPath,
    );

    final ok = await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const Text("Edit LND Settings"),
      content: LndSettingsDlgContent(
        notifier,
        opts,
        c.internalId,
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () => Navigator.pop(context, "OK"),
        ),
      ],
    ).show(context);

    if (ok == null || ok != "OK") return;

    final newOpts = notifier.value;
    if (opts == newOpts) return;

    _lnd.add(LndSettingsUpdatedEvent(newOpts));
  }

  void _startContainers() {
    _bapi.add(StartBlitzApiContainerEvent());
    _lnd.add(StartLndContainerEvent());
  }

  void _stopContainers() {
    _bapi.add(StopBlitzApiContainerEvent());
    _lnd.add(StopLndContainerEvent());
  }

  void _deleteContainers() {
    _bapi.add(DeleteBlitzApiContainerEvent());
    _lnd.add(DeleteLndContainerEvent());
  }

  _openBlitzTerminal(BuildContext context) async =>
      await openTerminalInDialog(context, widget.bapiContainerId);

  _showBlitzLogs(BuildContext context) async =>
      await openLogWindowInDialog(context, widget.bapiContainerId);
}
