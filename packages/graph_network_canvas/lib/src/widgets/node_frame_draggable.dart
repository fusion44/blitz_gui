// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../constants.dart';
import '../data.dart';
import 'node_frame.dart';
import 'node_socket.dart';
import 'node_test_contents.dart';

class NodeFrameDraggableWidget extends StatefulWidget {
  final int index;
  final GraphCanvasNodeInfo node;
  final Function(DraggableDetails details) onDragEnd;
  final Function(Velocity velocity, Offset offset)? onDraggableCanceled;
  final Function(Socket socket)? onSocketDragStarted;
  final Function(Socket? socket)? onSocketHovered;
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

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.node.position.dx,
      top: widget.node.position.dy,
      // If a socket is hovered, we don't want the
      // Node Frame to be draggable. Otherwise it'd be dragged
      // and the Socket doesn't get any drag information.
      child: _socketHovered
          ? _buildFrameStack(false)
          : Draggable(
              feedback: _buildFrameStack(true),
              onDragStarted: () {
                if (_socketHovered) return;

                setState(() => _dragging = true);
              },
              onDragEnd: (details) {
                _dragging = false;
                widget.onDragEnd(details);
              },
              onDragCompleted: () => setState(() => _dragging = false),
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
          for (final s in widget.node.sockets)
            NodeSocketWidget(
              s,
              widget.size,
              onStartDrag: (TapDownDetails? details) {
                if (!_socketHovered) throw StateError('Socket not hovered');
                if (s.hasConnection) return;

                widget.onSocketDragStarted?.call(s);
              },
              onHovered: (hovered) {
                widget.onSocketHovered?.call(hovered ? s : null);
                setState(() => _socketHovered = hovered);
              },
            )
        ],
      );
}
