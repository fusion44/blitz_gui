import 'package:flutter/material.dart';

import 'connection_line_painter.dart';
import 'data.dart';
import 'theme/theme.dart';
import 'widgets/node_frame_draggable.dart';

class NetworkCanvas extends StatefulWidget {
  final NodeFrameThemeData themeData;

  const NetworkCanvas({
    super.key,
    this.themeData = const NodeFrameThemeData(),
  });

  @override
  _NetworkCanvasState createState() => _NetworkCanvasState();
}

class _NetworkCanvasState extends State<NetworkCanvas> {
  final List<Node> _nodes = [];
  final List<Connection> _connections = [];

  final ValueNotifier<Offset> _positionNotifier =
      ValueNotifier<Offset>(Offset.zero);
  bool _addingConnection = false;
  Connection? _newConnection;
  Socket? _mouseSocket;
  Socket? _hoveredSocket;
  Socket? _sourceSocket;

  Node? _hoveredNode;

  bool get _canAddNode => _hoveredNode == null;

  void addNode(Node node) {
    if (!_canAddNode) return;

    setState(() {
      _nodes.add(node);
    });
  }

  void removeNode(int index) {
    setState(() => _nodes.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (event) {
        if (!_addingConnection) return;

        if (_newConnection != null) {
          _mouseSocket!.position = event.position + const Offset(0, -55);
          _positionNotifier.value = event.position;
        }
      },
      onPointerUp: (event) {
        if (!_addingConnection) return;
        if (_hoveredSocket != null &&
            _sourceSocket != null &&
            !_hoveredSocket!.hasConnection) {
          _connections.add(Connection(
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
      child: GestureDetector(
        onTapUp: (TapUpDetails details) {
          addNode(
            Node(details.localPosition)
              ..addSocket(SocketSide.left)
              ..addSocket(SocketSide.right)
              ..addSocket(SocketSide.top)
              ..addSocket(SocketSide.bottom),
          );
        },
        child: ValueListenableBuilder<Offset>(
          valueListenable: _positionNotifier,
          builder: (context, pos, child) {
            return CustomPaint(
              painter: ConnectionLinePainter(_connections, 0.7),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return _buildStack(context);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Stack _buildStack(BuildContext context) {
    return Stack(
      children: _nodes.asMap().entries.map((entry) {
        int index = entry.key;
        Node node = entry.value;

        return NodeFrameDraggableWidget(
          index,
          node,
          onDragEnd: (DraggableDetails details) {
            setState(() =>
                _nodes[index].position = details.offset + const Offset(0, -55));
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
          onNodeHovered: (Node? node) => _hoveredNode = node,
        );
      }).toList(),
    );
  }
}
