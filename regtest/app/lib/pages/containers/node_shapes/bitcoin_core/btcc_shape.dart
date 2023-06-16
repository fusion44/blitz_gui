import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:regtest_core/core.dart';

import '../../../../gui_constants.dart';
import '../../utils.dart';
import 'btcc_settings_dlg_content.dart';

class BitcoinCoreShape extends StatefulWidget {
  final String containerId;
  final Function()? onDeleted;

  const BitcoinCoreShape(this.containerId, {this.onDeleted, super.key});

  @override
  State<BitcoinCoreShape> createState() => _BitcoinCoreShapeState();
}

class _BitcoinCoreShapeState extends State<BitcoinCoreShape> {
  late final BitcoinCoreContainerBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BitcoinCoreContainerBloc(widget.containerId);
  }

  @override
  void dispose() async {
    super.dispose();
    await _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BitcoinCoreContainerBloc, BitcoinCoreContainerState>(
      bloc: _bloc,
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
            const Center(child: Text('Running Bitcoin')),
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

  Widget _buildFooter(ContainerStatus status) => switch (status) {
        ContainerStatus.uninitialized => Row(
            children: [
              ElevatedButton(
                  onPressed: () => _bloc.add(StartBitcoinCoreContainerEvent()),
                  child: const Text('Start'))
            ],
          ),
        ContainerStatus.starting => const Row(
            children: [
              ElevatedButton(onPressed: null, child: Text('Starting...')),
            ],
          ),
        ContainerStatus.started => Row(
            children: [
              ElevatedButton(
                onPressed: () => _bloc.add(StopBitcoinCoreContainerEvent()),
                child: const Text('Stop'),
              ),
              IconButton(
                onPressed: () => _bloc.add(DeleteBitcoinCoreContainerEvent()),
                icon: const Icon(Icons.delete),
              ),
              const Spacer(),
              PopupMenuButton<String>(itemBuilder: (context) {
                return [
                  _buildMenuItem('terminal', 'Terminal', Icons.terminal),
                ];
              }),
            ],
          ),
        ContainerStatus.stopping => const Row(
            children: [
              ElevatedButton(onPressed: null, child: Text('Stopping...')),
              IconButton(onPressed: null, icon: Icon(Icons.delete)),
            ],
          ),
        ContainerStatus.stopped => Row(
            children: [
              ElevatedButton(
                onPressed: () => _bloc.add(StartBitcoinCoreContainerEvent()),
                child: const Text('Start'),
              ),
              IconButton(
                onPressed: () => _bloc.add(DeleteBitcoinCoreContainerEvent()),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ContainerStatus.deleting || ContainerStatus.deleted => Container(),
        _ => Text('not implemented $status'),
      };

  PopupMenuItem<String> _buildMenuItem(String v, String s, IconData i) {
    return PopupMenuItem<String>(
      value: v,
      child: Row(children: [Icon(i), const SizedBox(width: 8), Text(s)]),
    );
  }

  _editSettings(BuildContext context) async {
    final c =
        NetworkManager().nodeMap[widget.containerId] as BitcoinCoreContainer;
    final ValueNotifier<BitcoinCoreOptions> notifier =
        ValueNotifier<BitcoinCoreOptions>(
      BitcoinCoreOptions(name: c.name, image: c.image, workDir: c.dataPath),
    );

    final opts = BitcoinCoreOptions(
      name: c.name,
      image: c.image,
      workDir: c.dataPath,
    );

    final ok = await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const Text("Edit Bitcoin Core Settings"),
      content: BtccSettingsDlgContent(
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

    _bloc.add(SettingsUpdatedEvent(newOpts));
  }
}
