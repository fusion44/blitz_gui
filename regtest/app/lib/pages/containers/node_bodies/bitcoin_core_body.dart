import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regtest_core/core.dart';

import '../utils.dart';

class BitcoinCoreBody extends StatefulWidget {
  final BitcoinCoreContainer container;

  const BitcoinCoreBody(this.container, {super.key});

  @override
  State<BitcoinCoreBody> createState() => _BitcoinCoreBodyState();
}

class _BitcoinCoreBodyState extends State<BitcoinCoreBody> {
  late final BitcoinCoreContainerBloc _bloc;

  @override
  void initState() {
    _bloc = BitcoinCoreContainerBloc(widget.container);
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
          body = const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Container not created, yet.'),
            ),
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
}
