// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'connection_line_painter.dart';
import 'data.dart';
import 'internal_data.dart';
import 'node_frame_rectangle.dart';
import 'theme/theme.dart';
import 'utils.dart';
import 'widgets/node_frame_draggable.dart';

class NetworkCanvas extends StatefulWidget {
  final List<GraphCanvasNodeInfo> nodes;
  final List<ConnectionData> connections;
  final NodeFrameThemeData themeData;

  final Function(Connection c)? onConnectionEstablished;
  final Function(GraphCanvasNodeInfo? hoveredNode)? onNodeHovered;

  const NetworkCanvas({
    super.key,
    this.nodes = const [],
    this.connections = const [],
    this.themeData = const NodeFrameThemeData(),
    this.onConnectionEstablished,
    this.onNodeHovered,
  });

  @override
  _NetworkCanvasState createState() => _NetworkCanvasState();
}

class _NetworkCanvasState extends State<NetworkCanvas> {
  late final List<GraphCanvasNodeInfo> _nodes;
  final List<Connection> _connections = [];

  // When a node position changes, we need to update the canvas
  // using a ValueListenableBuilder<Offset>
  final ValueNotifier<NodeFrameRectangle> _positionNotifier =
      ValueNotifier<NodeFrameRectangle>(NodeFrameRectangle.zero());
  bool _addingConnection = false;
  Connection? _newConnection;
  Socket? _mouseSocket;
  Socket? _hoveredSocket;
  Socket? _sourceSocket;

  @override
  void initState() {
    super.initState();
    _nodes = widget.nodes;
    _updateConnections();
  }

  _updateConnections() {
    _connections.clear();

    for (final c in widget.connections) {
      try {
        final from = _nodes.firstWhere((e) => c.from == e.id);
        final to = _nodes.firstWhere((e) => c.to == e.id);
        final (fromSide, toSide) = _determineSocketSide(from.shape, to.shape);

        _connections.add(
          Connection(
            from: Socket(side: fromSide, parent: from),
            to: Socket(side: toSide, parent: to),
            data: c,
          ),
        );
      } on StateError {
        continue;
      }
    }
  }

  (SocketSide, SocketSide) _determineSocketSide(
    NodeFrameRectangle from,
    NodeFrameRectangle to,
  ) {
    final q = from.determineQuadrantOf(to);
    return switch (q) {
      Quadrant.bottom => (SocketSide.bottom, SocketSide.top),
      Quadrant.top => (SocketSide.top, SocketSide.bottom),
      Quadrant.left => (SocketSide.left, SocketSide.right),
      Quadrant.right => (SocketSide.right, SocketSide.left),
      Quadrant.topLeft => (SocketSide.top, SocketSide.right),
      Quadrant.topRight => (SocketSide.top, SocketSide.left),
      Quadrant.bottomLeft => (SocketSide.bottom, SocketSide.right),
      Quadrant.bottomRight => (SocketSide.bottom, SocketSide.left),
      _ => (SocketSide.bottom, SocketSide.top)
    };
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (event) {
        if (!_addingConnection) return;

        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset localPosition = renderBox.globalToLocal(event.position);

        if (_newConnection != null) {
          _mouseSocket!.position = localPosition;
          _positionNotifier.value =
              NodeFrameRectangle.fromOffset(event.position);
        }
      },
      onPointerUp: (event) {
        if (!_addingConnection) return;
        if (_hoveredSocket != null &&
            _sourceSocket != null &&
            !_hoveredSocket!.hasConnection) {
          widget.onConnectionEstablished?.call(Connection(
            from: _sourceSocket!,
            to: _hoveredSocket!,
          ));
        }

        setState(() {
          _connections.remove(_newConnection);

          _addingConnection = false;
          _newConnection = _sourceSocket = _mouseSocket = null;
        });
      },
      child: _buildCanvas(),
    );
  }

  GraphCanvasTheme _buildCanvas() {
    return GraphCanvasTheme(
      frame: widget.themeData,
      child: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTapUp: (TapUpDetails details) => debugPrint('onTapUp'),
          child: ValueListenableBuilder<NodeFrameRectangle>(
            valueListenable: _positionNotifier,
            builder: (context, pos, child) {
              return CustomPaint(
                painter: ConnectionLinePainter(_connections),
                child: _buildStack(context, constraints),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    return Stack(
      children: _nodes.asMap().entries.map((entry) {
        int index = entry.key;
        GraphCanvasNodeInfo node = entry.value;

        return NodeFrameDraggableWidget(
          index,
          node,
          onDragEnd: (DraggableDetails details) {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            Offset localPosition = renderBox.globalToLocal(details.offset);
            final pos = constrainNodeToCanvas(
              localPosition,
              constraints.biggest,
            );
            _nodes[index]
                .onPositionUpdated
                ?.call(NodeFrameRectangle.fromOffset(pos));

            setState(() {
              _nodes[index].shape.center = pos;
              _updateConnections();
            });
          },
          onSocketDragStarted: (Socket socket) {
            _sourceSocket = socket;
            _mouseSocket = Socket(
              side: SocketSide.bottom,
              position: socket.globalPosition,
            );
            _newConnection = Connection(
              from: socket.copyWith(),
              to: _mouseSocket!,
            );
            setState(() {
              _addingConnection = true;
              _connections.add(_newConnection!);
            });
          },
          onSocketHovered: (Socket? socket) => _hoveredSocket = socket,
          onNodeHovered: (GraphCanvasNodeInfo? node) =>
              widget.onNodeHovered?.call(node),
        );
      }).toList(),
    );
  }
}
