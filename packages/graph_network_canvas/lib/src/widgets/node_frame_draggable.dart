// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../constants.dart';
import '../data.dart';
import '../internal_data.dart';
import 'node_frame.dart';
import 'node_socket.dart';
import 'node_test_contents.dart';

const mouseRegionSizeH = Size(20.0, 40.0);
const mouseRegionSizeV = Size(40.0, 20.0);

class NodeFrameDraggableWidget extends StatefulWidget {
  final int index;
  final GraphCanvasNodeInfo node;
  final Function(DraggableDetails details) onDragEnd;
  final Function(Velocity velocity, Offset offset)? onDraggableCanceled;
  final Function(Socket socket)? onSocketDragStarted;
  final Function(Socket? socket, GraphCanvasNodeInfo? node)? onSocketHovered;
  final Function(GraphCanvasNodeInfo? node)? onNodeHovered;
  final Size size;

  const NodeFrameDraggableWidget(
    this.index,
    this.node, {
    super.key,
    required this.onDragEnd,
    this.onDraggableCanceled,
    this.onSocketDragStarted,
    this.size = defaultNodeSize,
    this.onSocketHovered,
    this.onNodeHovered,
  });

  @override
  State<NodeFrameDraggableWidget> createState() =>
      _NodeFrameDraggableWidgetState();
}

class _NodeFrameDraggableWidgetState extends State<NodeFrameDraggableWidget> {
  bool _dragging = false;
  bool _socketHovered = false;
  Socket? hoveredSocket;

  bool _mouseRegionHovered = false;
  SocketSide _mouseRegionHoveredSide = SocketSide.bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.node.shape.center.dx,
      top: widget.node.shape.center.dy,
      // If a socket is hovered, we don't want the
      // Node Frame to be draggable. Otherwise it'd be dragged
      // and the Socket doesn't get any drag information.
      child: _socketHovered
          ? _buildFrameStack(false)
          : Draggable(
              feedback: _buildFrameStack(true),
              onDragStarted: () {
                if (_socketHovered) return;
                _guardedSetState(() => _dragging = true);
              },
              onDragEnd: (details) {
                _dragging = false;
                widget.onDragEnd(details);
              },
              onDragCompleted: () => _guardedSetState(() => _dragging = false),
              child: _dragging ? Container() : _buildFrameStack(false),
            ),
    );
  }

  Widget _buildFrameStack(bool dragged) => Stack(
        children: [
          NodeFrameWidget(
            widget.node,
            dragged: dragged,
            onHovered: widget.onNodeHovered,
            child: widget.node.body ??
                NodeTestContents(
                  header: 'ID: ${widget.index}',
                  body: "Default Node",
                  footer: 'Default Footer',
                ),
          ),
          ..._buildSocketHoverRegions(),
        ],
      );

  List<Widget> _buildSocketHoverRegions() {
    return [
      _buildMouseRegionPositions(SocketSide.left),
      _buildMouseRegionPositions(SocketSide.right),
      _buildMouseRegionPositions(SocketSide.top),
      _buildMouseRegionPositions(SocketSide.bottom),
    ];
  }

  Widget _buildMouseRegionPositions(SocketSide side) {
    final w = switch (side) {
      SocketSide.left => Positioned(
          left: 0,
          top: (widget.size.height / 2) - mouseRegionSizeH.height / 2,
          child: _buildMouseRegion(side),
        ),
      SocketSide.right => Positioned(
          right: 0,
          top: (widget.size.height / 2) - mouseRegionSizeH.height / 2,
          child: _buildMouseRegion(side),
        ),
      SocketSide.top => Positioned(
          top: 0,
          left: (widget.size.height / 2) - mouseRegionSizeV.width / 2,
          child: _buildMouseRegion(side),
        ),
      SocketSide.bottom => Positioned(
          bottom: 0,
          left: (widget.size.height / 2) - mouseRegionSizeV.width / 2,
          child: _buildMouseRegion(side),
        ),
    };

    return w;
  }

  MouseRegion _buildMouseRegion(SocketSide side) {
    return MouseRegion(
      onEnter: (event) => _guardedSetState(() {
        _mouseRegionHovered = true;
        _mouseRegionHoveredSide = side;
      }),
      onExit: (event) => _guardedSetState(() => _mouseRegionHovered = false),
      child: SizedBox(
        width: side == SocketSide.left || side == SocketSide.right
            ? mouseRegionSizeH.width
            : mouseRegionSizeV.width,
        height: side == SocketSide.top || side == SocketSide.bottom
            ? mouseRegionSizeV.height
            : mouseRegionSizeH.height,
        child: _mouseRegionHovered && _mouseRegionHoveredSide == side
            ? _buildNodeSocketWidgetForHoverRegion(side)
            : null,
      ),
    );
  }

  NodeSocketWidget _buildNodeSocketWidgetForHoverRegion(SocketSide side) {
    return NodeSocketWidget(
      Socket(side: side, parent: widget.node),
      widget.size,
      onStartDrag: (Offset? pos) {
        if (!_socketHovered) {
          throw StateError('Socket not hovered');
        }
        if (pos == null) {
          return;
        }

        widget.onSocketDragStarted?.call(
          Socket(side: side, position: pos, parent: widget.node),
        );
      },
      onHovered: (hovered) {
        widget.onSocketHovered?.call(
          hovered ? Socket(side: side, parent: widget.node) : null,
          widget.node,
        );
        _guardedSetState(() => _socketHovered = hovered);
      },
    );
  }

  void _guardedSetState(Function() f) {
    if (!mounted) return;

    setState(f);
  }
}
