import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:regtest_core/core.dart';

import '../../../../gui_constants.dart';
import '../../utils.dart';
import '../widgets/action_buttons.dart';
import '../widgets/open_blitz_terminal_btn.dart';
import '../widgets/show_blitz_logs_btn.dart';
import 'btcc_settings_dlg_content.dart';

class BitcoinCoreShape extends StatefulWidget {
  final String btccContainerId;
  final String bapiContainerId;
  final Function()? onDeleted;

  const BitcoinCoreShape(
    this.btccContainerId,
    this.bapiContainerId, {
    this.onDeleted,
    super.key,
  });

  @override
  State<BitcoinCoreShape> createState() => _BitcoinCoreShapeState();
}

class _BitcoinCoreShapeState extends State<BitcoinCoreShape> {
  late final BlitzApiContainerBloc _bapi;
  late final BitcoinCoreContainerBloc _btcc;

  @override
  void initState() {
    super.initState();
    _bapi = BlitzApiContainerBloc(
      widget.btccContainerId,
      widget.bapiContainerId,
    );
    _btcc = BitcoinCoreContainerBloc(widget.btccContainerId);
  }

  @override
  void dispose() async {
    super.dispose();
    await _bapi.close();
    await _btcc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BitcoinCoreContainerBloc, BitcoinCoreContainerState>(
      bloc: _btcc,
      builder: (context, state) {
        Widget? footer;

        if (state is! BitcoinCoreStatusUpdate) {
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
            Center(child: Text('Running Bitcoin ${widget.btccContainerId}')),
            footer,
          );
        }

        return Center(child: Text('UNKNOWN STATE $state'));
      },
    );
  }

  Widget _buildShape(
    BitcoinCoreContainerState state,
    Widget? body,
    Widget? footer,
  ) {
    return Column(children: [
      Image.asset(
        getContainerLogo(ContainerType.bitcoinCore),
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
                  onPressed: () {
                    _bapi.add(StartBlitzApiContainerEvent());
                    _btcc.add(StartBitcoinCoreContainerEvent());
                  },
                  child: const Text('Start'))
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
                onPressed: () {
                  _bapi.add(StopBlitzApiContainerEvent());
                  _btcc.add(StopBitcoinCoreContainerEvent());
                },
                child: const Text('Stop'),
              ),
              OpenTerminalBtn(() async =>
                  await openTerminalInDialog(context, widget.btccContainerId)),
              ShowLogsBtn(() async =>
                  await openLogWindowInDialog(context, widget.btccContainerId)),
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
                  _btcc.add(StartBitcoinCoreContainerEvent());
                },
                child: const Text('Start'),
              ),
              IconButton(
                onPressed: () {
                  _bapi.add(DeleteBlitzApiContainerEvent());
                  _btcc.add(DeleteBitcoinCoreContainerEvent());
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ContainerStatus.deleting || ContainerStatus.deleted => Container(),
        _ => Text('not implemented $status'),
      };

  _editSettings(BuildContext context) async {
    final c = NetworkManager().nodeMap[widget.btccContainerId]
        as BitcoinCoreContainer;
    final opts = BitcoinCoreOptions(
      name: c.containerName,
      image: c.image,
      workDir: c.dataPath,
      fundWallet: c.opts.fundWallet,
      walletName: c.opts.walletName,
      makeDataDirPublic: c.opts.makeDataDirPublic,
    );
    final ValueNotifier<BitcoinCoreOptions> notifier =
        ValueNotifier<BitcoinCoreOptions>(opts);

    final ok = await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const Text("Edit Bitcoin Core Settings"),
      content: BtccSettingsDlgContent(notifier, c.internalId),
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

    _btcc.add(SettingsUpdatedEvent(newOpts));
  }

  void _deleteContainers() {
    _bapi.add(DeleteBlitzApiContainerEvent());
    _btcc.add(DeleteBitcoinCoreContainerEvent());
  }

  _openBlitzTerminal(BuildContext context) async =>
      await openTerminalInDialog(context, widget.bapiContainerId);

  _showBlitzLogs(BuildContext context) async =>
      await openLogWindowInDialog(context, widget.bapiContainerId);
}
