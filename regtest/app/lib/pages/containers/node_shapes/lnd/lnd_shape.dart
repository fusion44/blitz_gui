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

class LndShape extends StatelessWidget {
  final String lndContainerId;
  final Function()? onDeleted;

  final LnContainerBloc lnBloc;
  final BlitzApiContainerBloc bapi;

  const LndShape(
    this.lndContainerId,
    this.lnBloc,
    this.bapi, {
    this.onDeleted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LnContainerBloc, LnContainerState>(
      bloc: lnBloc,
      builder: (context, state) {
        Widget? footer;

        if (state is! LnStatusUpdate) {
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
              _buildFooter(ContainerStatus.uninitialized, context));
        }

        footer = _buildFooter(state.status.status, context);

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
            Center(child: Text('Running LND $lndContainerId')),
            footer,
          );
        }

        return Center(child: Text('UNKNOWN STATE $state'));
      },
    );
  }

  Widget _buildShape(
    LnContainerState state,
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

  Widget _buildFooter(ContainerStatus status, BuildContext context) =>
      switch (status) {
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
                  await openTerminalInDialog(context, lndContainerId)),
              ShowLogsBtn(() async =>
                  await openLogWindowInDialog(context, lndContainerId)),
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
                  bapi.add(StartBlitzApiContainerEvent());
                  lnBloc.add(StartLnContainerEvent());
                },
                child: const Text('Start'),
              ),
              IconButton(
                onPressed: () {
                  bapi.add(DeleteBlitzApiContainerEvent());
                  lnBloc.add(DeleteLnContainerEvent());
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ContainerStatus.deleting || ContainerStatus.deleted => Container(),
        _ => Text('not implemented $status'),
      };

  _editSettings(BuildContext context) async {
    final c = NetworkManager().nodeMap[lndContainerId] as LndContainer;
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

    lnBloc.add(LnSettingsUpdatedEvent(newOpts));
  }

  void _startContainers() {
    bapi.add(StartBlitzApiContainerEvent());
    lnBloc.add(StartLnContainerEvent());
  }

  void _stopContainers() {
    bapi.add(StopBlitzApiContainerEvent());
    lnBloc.add(StopLnContainerEvent());
  }

  void _deleteContainers() {
    bapi.add(DeleteBlitzApiContainerEvent());
    lnBloc.add(DeleteLnContainerEvent());
  }

  _openBlitzTerminal(BuildContext context) async =>
      await openTerminalInDialog(context, bapi.blitzApiContainerId);

  _showBlitzLogs(BuildContext context) async =>
      await openLogWindowInDialog(context, bapi.blitzApiContainerId);
}
