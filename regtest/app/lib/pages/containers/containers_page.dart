import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:graph_network_canvas/graph_network_canvas.dart' as gnc;
import 'package:regtest_core/core.dart';

import '../../gui_constants.dart';
import 'container_chip.dart';
import 'node_shapes/bitcoin_core_shape.dart';
import 'utils.dart';

class ContainersPage extends StatefulWidget {
  const ContainersPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ContainersPage> createState() => _ContainersPageState();
}

class _ContainersPageState extends State<ContainersPage> {
  // Using a GlobalKey with a unique value can be a way to generate a
  // unique key every time the app builds and force initState on a child widget.
  GlobalKey _canvasKey = GlobalKey();

  final notificationPlugin = FlutterLocalNotificationsPlugin();

  List<ContainerNode> nodes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Containers")),
      body: Row(
        children: [
          NavigationRail(
            elevation: 5,
            selectedIndex: 1,
            onDestinationSelected: (int index) =>
                context.goNamed(RouteNames.values[index].name),
            labelType: NavigationRailLabelType.all,
            destinations: getNavRailDestinations(),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _getContainerButtons(theme),
                      ),
                    ),
                  ),
                ),
                const Divider(height: 0),
                Expanded(
                  child: DragTarget(
                    onWillAccept: (data) {
                      if (data is ContainerType) return true;

                      return false;
                    },
                    builder: (
                      BuildContext context,
                      List<ContainerType?> candidateData,
                      List<dynamic> rejectedData,
                    ) {
                      return gnc.NetworkCanvas(
                        key: _canvasKey,
                        nodes: nodes.map((e) => e.node).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _getContainerButtons(ThemeData theme) {
    return [
      _buildContainerChip(
        ContainerType.bitcoinCore,
        theme,
        scale: 3,
        chipWidth: 140,
      ),
      const SizedBox(width: 8),
      _buildContainerChip(ContainerType.lnd, theme, scale: 10),
      const SizedBox(width: 8),
      _buildContainerChip(ContainerType.cln, theme, scale: 1),
      const SizedBox(width: 8),
      _buildContainerChip(
        ContainerType.lnbits,
        theme,
        scale: 9,
        chipWidth: 80,
      ),
      const SizedBox(width: 8),
      _buildContainerChip(ContainerType.cashuMint, theme, scale: 9),
    ];
  }

  Widget _buildContainerChip(
    ContainerType containerType,
    ThemeData theme, {
    double? scale,
    double? chipWidth,
  }) {
    final i = ContainerChipWidget(
      getContainerLogo(containerType),
      imageScale: scale,
      chipWidth: chipWidth,
    );

    return Draggable(
        feedback: i,
        data: containerType,
        child: i,
        onDragEnd: (data) {
          _addContainer(containerType, data.offset);
        });
  }

  void _addContainer(ContainerType type, Offset globalPos) {
    final targetCtx = _canvasKey.currentContext;
    if (targetCtx == null) throw StateError('No context when adding container');

    final RenderBox target = targetCtx.findRenderObject() as RenderBox;
    final localPos = target.globalToLocal(globalPos);

    final container = NetworkManager().createContainer(type);
    final n = gnc.Node(
      gnc.constrainNodeToCanvas(localPos, target.size),
      body: BitcoinCoreShape(container.internalId),
    );
    setState(() {
      _canvasKey = GlobalKey();
      nodes.add(ContainerNode(type, container, n));
    });
  }
}

class ContainerNode {
  final ContainerType type;
  final DockerContainer container;
  final gnc.Node node;

  ContainerNode(this.type, this.container, this.node);
}
