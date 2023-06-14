import 'package:flutter/material.dart';

import 'connection_line_painter.dart';
import 'data.dart';
import 'theme/theme.dart';
import 'utils.dart';
import 'widgets/node_frame_draggable.dart';

class NetworkCanvas extends StatefulWidget {
  final List<GraphCanvasNodeInfo>? nodes;
  final List<Connection>? connections;
  final NodeFrameThemeData themeData;

  final Function(Connection c)? onConnectionEstablished;
  final Function(GraphCanvasNodeInfo? hoveredNode)? onNodeHovered;

  const NetworkCanvas({
    super.key,
    this.nodes,
    this.connections,
    this.themeData = const NodeFrameThemeData(),
    this.onConnectionEstablished,
    this.onNodeHovered,
  });

  @override
  _NetworkCanvasState createState() => _NetworkCanvasState();
}

class _NetworkCanvasState extends State<NetworkCanvas> {
  late final List<GraphCanvasNodeInfo> _nodes;
  late final List<Connection> _connections;

  final ValueNotifier<Offset> _positionNotifier =
      ValueNotifier<Offset>(Offset.zero);
  bool _addingConnection = false;
  Connection? _newConnection;
  Socket? _mouseSocket;
  Socket? _hoveredSocket;
  Socket? _sourceSocket;

  @override
  void initState() {
    super.initState();
    _nodes = widget.nodes ?? [];
    _connections = widget.connections ?? [];
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
          _positionNotifier.value = event.position;
        }
      },
      onPointerUp: (event) {
        if (!_addingConnection) return;
        if (_hoveredSocket != null &&
            _sourceSocket != null &&
            !_hoveredSocket!.hasConnection) {
          widget.onConnectionEstablished?.call(Connection(
            socket1: _sourceSocket!,
            socket2: _hoveredSocket!,
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
          child: ValueListenableBuilder<Offset>(
            valueListenable: _positionNotifier,
            builder: (context, pos, child) {
              return CustomPaint(
                painter: ConnectionLinePainter(_connections, 0.7),
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
            setState(() {
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              Offset localPosition = renderBox.globalToLocal(details.offset);
              _nodes[index].position = constrainNodeToCanvas(
                localPosition,
                constraints.biggest,
              );
            });
          },
          onSocketDragStarted: (Socket socket) {
            _sourceSocket = socket;
            _mouseSocket = Socket(
              side: SocketSide.bottom,
              position: socket.globalPosition,
            );
            _newConnection = Connection(
              socket1: socket.copyWith(),
              socket2: _mouseSocket!,
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
