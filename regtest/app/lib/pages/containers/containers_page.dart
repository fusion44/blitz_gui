import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:graph_network_canvas/graph_network_canvas.dart' as gnc;
import 'package:regtest_core/core.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_file/stash_file.dart';

import '../../gui_constants.dart';
import 'container_chip.dart';
import 'node_shapes/bitcoin_core/btcc_shape.dart';
import 'node_shapes/lnd/lnd_shape.dart';
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

  StreamSubscription<DockerContainer>? _containerDelSub;
  late final Vault _posVault;
  bool _loading = true;

  @override
  void initState() {
    _containerDelSub = NetworkManager().containerDeletedStream.listen(
      (container) async {
        await _posVault.remove(container.internalId);

        setState(() {
          _canvasKey = GlobalKey();
          final l = nodes.length;
          nodes.removeWhere(
              (element) => element.mainContainerId == container.internalId);
          if (nodes.length == l) throw StateError("No container deleted");
        });
      },
    );

    _loadPositions();

    super.initState();
  }

  @override
  void dispose() async {
    _containerDelSub?.cancel();
    super.dispose();
  }

  Future<void> _loadPositions() async {
    final store = await newFileLocalVaultStore(path: 'vaults');
    _posVault = await store.vault(name: 'positions');
    final keys = await _posVault.keys;
    final values = await _posVault.getAll(keys.toSet());

    for (var node in NetworkManager().nodeMap.values) {
      Offset? o;
      if (values.keys.contains(node.internalId)) {
        o = OffsetExtension.fromJson(values[node.internalId]);
      }

      nodes.add(
        ContainerNode(
          o ?? Offset.zero,
          node.type,
          node.internalId,
          '',
        ),
      );
    }

    setState(() {
      _loading = false;
    });
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
                      if (_loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return gnc.NetworkCanvas(
                        key: _canvasKey,
                        nodes: nodes.map((e) {
                          return gnc.GraphCanvasNodeInfo(
                            e.initialPos,
                            body: switch (e.type) {
                              ContainerType.bitcoinCore => BitcoinCoreShape(
                                  e.mainContainerId,
                                  e.complementaryContainerId,
                                ),
                              ContainerType.lnd => LndShape(e.mainContainerId),
                              _ => throw UnimplementedError()
                            },
                            onPositionUpdated: (position) async {
                              await _posVault.put(
                                e.mainContainerId,
                                position.toJson(),
                              );
                            },
                          );
                        }).toList(),
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

    final initialPos = gnc.constrainNodeToCanvas(
      target.globalToLocal(globalPos),
      target.size,
    );

    final container = NetworkManager().createContainer(type);
    final bapi = switch (type) {
      ContainerType.bitcoinCore ||
      ContainerType.cln ||
      ContainerType.lnd =>
        NetworkManager().createContainer(
          ContainerType.blitzApi,
          opts: _buildBlitzApiOptions(container),
        ),
      _ => null
    };

    _posVault.put(container.internalId, initialPos.toJson());

    setState(() {
      _canvasKey = GlobalKey();
      nodes.add(ContainerNode(
        initialPos,
        type,
        container.internalId,
        bapi != null ? bapi.internalId : '',
      ));
    });
  }

  BlitzApiOptions? _buildBlitzApiOptions(DockerContainer container) {
    if (container.type == ContainerType.bitcoinCore) {
      return BlitzApiOptions(
        name: '${container.name}_bapi',
        btccContainerId: container.internalId,
      );
    }

    return null;
  }
}

class ContainerNode {
  final Offset initialPos;
  final ContainerType type;

  /// The container ID of the main container as requested by the user
  final String mainContainerId;

  /// The container ID of the complementary container as required by
  /// the app itself to make it easier to connect to the main container
  final String complementaryContainerId;

  ContainerNode(
    this.initialPos,
    this.type,
    this.mainContainerId,
    this.complementaryContainerId,
  );
}
