import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:regtest_app/pages/containers/node_shapes/edit_container_base_settings_dlg_content.dart';
import 'package:regtest_core/core.dart';

import '../utils.dart';

class BitcoinCoreShape extends StatefulWidget {
  final String containerId;

  const BitcoinCoreShape(this.containerId, {super.key});

  @override
  State<BitcoinCoreShape> createState() => _BitcoinCoreShapeState();
}

class _BitcoinCoreShapeState extends State<BitcoinCoreShape> {
  late final BitcoinCoreContainerBloc _bloc;

  @override
  void initState() {
    _bloc = BitcoinCoreContainerBloc(widget.containerId);
    super.initState();
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
        Widget? body;
        if (state is BitcoinCoreContainerInitial) {
          body = Column(
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
          );
        }

        if (state is BitcoinCoreStatusUpdate) {
          body = Text(state.status.message);
        }

        return Column(children: [
          Image.asset(getContainerLogo(ContainerType.bitcoinCore)),
          body ?? Center(child: Text('Unknown state $state')),
          const Spacer(),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () => _bloc.add(StartBitcoinCoreContainerEvent()),
                  child: const Text('Start')),
              const Spacer(),
              PopupMenuButton<String>(itemBuilder: (context) {
                return [
                  _buildMenuItem('terminal', 'Terminal', Icons.terminal),
                ];
              }),
            ],
          ),
        ]);
      },
    );
  }

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
      content: EditContainerBaseSettingsDlgContent(
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
