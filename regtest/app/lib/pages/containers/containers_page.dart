import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:graph_network_canvas/graph_network_canvas.dart' as gnc;
import 'package:ndialog/ndialog.dart';
import 'package:regtest_app/connection_manager.dart';
import 'package:regtest_core/core.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_file/stash_file.dart';

import '../../gui_constants.dart';
import '../../widgets/open_channel_dlg_content.dart';
import '../../widgets/widget_utils.dart';
import 'container_chip.dart';
import 'node_shapes/bitcoin_core/btcc_shape.dart';
import 'node_shapes/lnd/lnd_shape.dart';
import 'redis_manager.dart';
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

  Map<String, ContainerNode> nodes = {};

  StreamSubscription<DockerContainer>? _containerDelSub;
  late final Vault _posVault;
  bool _loading = true;
  final portMgr = PortManager();
  final connectionMgr = ConnectionManager();

  final _nodeData = <String, Map<String, dynamic>>{};

  @override
  void initState() {
    _containerDelSub = NetworkManager().containerDeletedStream.listen(
      (container) async {
        await _posVault.remove(container.internalId);

        setState(() {
          _canvasKey = GlobalKey();
          portMgr.clearPorts(container.usedPorts);
          nodes.remove(container.internalId);
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

  String _findComplementaryNode(DockerContainer main) {
    for (final node in NetworkManager().nodeMap.values) {
      if (node.type != ContainerType.blitzApi) continue;
      if (node.containerName.contains(main.internalId)) {
        return node.internalId;
      }
    }

    return '';
  }

  Future<void> _loadPositions() async {
    final store = await newFileLocalVaultStore(path: 'vaults');
    _posVault = await store.vault(name: 'positions');
    final keys = await _posVault.keys;
    final values = await _posVault.getAll(keys.toSet());

    for (var node in NetworkManager().userNodes) {
      gnc.NodeFrameRectangle? o;
      if (values.keys.contains(node.internalId)) {
        o = gnc.NodeFrameRectangle.fromJson(values[node.internalId]);
      }

      final n = ContainerNode(
        o ?? gnc.NodeFrameRectangle.zero(),
        node.type,
        node.internalId,
        _findComplementaryNode(node),
      );

      nodes[node.internalId] = n;

      _nodeData[n.mainContainerId] = _buildBlocs(
        node.type,
        node.internalId,
        n.complementaryContainerId,
      );
    }

    await connectionMgr.update();

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
                        connections: connectionMgr.connections,
                        onConnectionEstablished: (from, to) =>
                            _onEstablishConnection(context, from, to),
                        nodes: nodes.values.map((e) {
                          return gnc.GraphCanvasNodeInfo(
                            e.initialPos,
                            body: _buildNodeInfoBody(e),
                            onPositionUpdated: (position) async {
                              await _posVault.put(
                                e.mainContainerId,
                                position.toJson(),
                              );
                            },
                            id: e.mainContainerId,
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
      tooltip: getContainerTooltip(containerType),
    );

    return Draggable(
        feedback: i,
        data: containerType,
        child: i,
        onDragEnd: (data) async {
          await _addContainer(containerType, data.offset);
        });
  }

  Future<void> _addContainer(ContainerType type, Offset globalPos) async {
    final targetCtx = _canvasKey.currentContext;
    if (targetCtx == null) throw StateError('No context when adding container');

    final RenderBox target = targetCtx.findRenderObject() as RenderBox;

    final initialPos = gnc.NodeFrameRectangle.fromOffset(
      gnc.constrainNodeToCanvas(
        target.globalToLocal(globalPos),
        target.size,
      ),
    );

    final container = await NetworkManager().createContainer(type);

    try {
      final bapi = switch (type) {
        ContainerType.bitcoinCore ||
        ContainerType.cln ||
        ContainerType.lnd =>
          await NetworkManager().createContainer(
            ContainerType.blitzApi,
            opts: await _buildBlitzApiOptions(container),
          ),
        _ => null
      };

      _posVault.put(container.internalId, initialPos.toJson());
      _nodeData[container.internalId] = _buildBlocs(
        type,
        container.internalId,
        bapi?.internalId,
      );

      setState(() {
        _canvasKey = GlobalKey();
        nodes[container.internalId] = ContainerNode(
          initialPos,
          type,
          container.internalId,
          bapi != null ? bapi.internalId : '',
        );
        connectionMgr.update();
      });
    } on RequirementsNotMetError catch (e) {
      buildSnackbar(
        context,
        title: 'Missing requirement',
        msg: e.message,
        ct: ContentType.failure,
      );
    }
  }

  Future<BlitzApiOptions?> _buildBlitzApiOptions(
    DockerContainer parent, [
    BitcoinCoreContainer? btcc,
  ]) async {
    final name =
        '${parent.containerName}$dockerContainerNameDelimiter${projectName}_bapi';

    final btccContainer =
        btcc ?? NetworkManager().findFirstOf<BitcoinCoreContainer>();

    if (parent.type == ContainerType.bitcoinCore) {
      return BlitzApiOptions(
        name: name,
        btccContainerId: parent.internalId,
        redisHost: RedisManager().mainRedis.containerName,
        redisDB: RedisManager().generateDbId(parent.internalId),
        apiRestPort: await portMgr.nextUnusedPort(BlitzApiContainer.portRange),
      );
    }

    if (btccContainer == null) {
      throw StateError('No btcc container found');
    }

    if (parent.type == ContainerType.lnd) {
      return BlitzApiOptions(
        name: name,
        btccContainerId: btccContainer.internalId,
        lnContainerId: parent.internalId,
        redisHost: RedisManager().mainRedis.containerName,
        redisDB: RedisManager().generateDbId(parent.internalId),
        apiRestPort: await portMgr.nextUnusedPort(BlitzApiContainer.portRange),
      );
    }

    return null;
  }

  Widget _buildNodeInfoBody(ContainerNode e) {
    if (e.type == ContainerType.bitcoinCore) {
      return BitcoinCoreShape(
        e.mainContainerId,
        e.complementaryContainerId,
      );
    }

    if (e.type == ContainerType.lnd) {
      final lnd = _nodeData[e.mainContainerId]!['main'];
      final bapi = _nodeData[e.mainContainerId]!['bapi'];
      return LndShape(e.mainContainerId, lnd, bapi);
    }

    throw UnimplementedError('${e.type.name} not implemented yet');
  }

  _onEstablishConnection(BuildContext c, String from, String to) {
    DockerContainer? fromNode = NetworkManager().findContainerById(from);
    DockerContainer? toNode = NetworkManager().findContainerById(to);

    if (fromNode is LnNode && toNode is LnNode) {
      _openChannel(c, fromNode, toNode);
    }
  }

  _openChannel(BuildContext context, LnNode from, LnNode to) async {
    final ValueNotifier<OpenChannelDialogData> notifier =
        ValueNotifier<OpenChannelDialogData>(OpenChannelDialogData.empty());

    final ok = await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text("Open Channel [${from.name}]"),
      content: OpenChannelDlgContent(notifier, from),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () => Navigator.pop(context, "OK"),
        ),
      ],
    ).show(context);

    if (ok == null || ok != "OK") return;

    final bapiBloc = _nodeData[from.internalId]!['bapi'];
    if (bapiBloc == null || bapiBloc is! BlitzApiContainerBloc) {
      print('Blitz API for from node not found');
      return;
    }

    final data = notifier.value;

    bapiBloc.add(
      BlitzApiOpenChannelEvent(to.internalId, data.numSats, data.numPushSats),
    );

    // TODO: handle auto mine etc
  }

  Map<String, dynamic> _buildBlocs(
    ContainerType type,
    String mainId,
    String? complementaryId,
  ) {
    final mainBloc = switch (type) {
      ContainerType.bitcoinCore => BitcoinCoreContainerBloc(mainId),
      ContainerType.lnd => LndContainerBloc(mainId),
      _ => throw UnimplementedError('${type.name} not implemented yet')
    };

    BlitzApiContainerBloc? bapiBloc;
    if (complementaryId != null) {
      bapiBloc = BlitzApiContainerBloc(
        mainId,
        complementaryId,
        bitcoinOnly: type == ContainerType.bitcoinCore,
      );
    }

    return {
      'main': mainBloc,
      if (complementaryId != null) 'bapi': bapiBloc,
    };
  }
}

class ContainerNode {
  final gnc.NodeFrameRectangle initialPos;
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
