import 'package:flutter/material.dart';

import '../constants.dart';
import '../data.dart';
import '../theme/node_frame_theme.dart';
import '../theme/node_frame_theme_data.dart';

class NodeFrameWidget extends StatefulWidget {
  final bool connected;
  final bool dragged;
  final Size size;
  final Widget child;
  final GraphCanvasNodeInfo node;
  final Function(GraphCanvasNodeInfo? node)? onHovered;

  const NodeFrameWidget(
    this.node, {
    Key? key,
    required this.child,
    this.connected = false,
    this.dragged = false,
    this.size = defaultNodeSize,
    this.onHovered,
  }) : super(key: key);

  @override
  _NodeFrameWidgetState createState() => _NodeFrameWidgetState();
}

class _NodeFrameWidgetState extends State<NodeFrameWidget> {
  @override
  Widget build(BuildContext context) {
    final nfTheme =
        GraphCanvasTheme.of(context)?.frame ?? const NodeFrameThemeData();

    return MouseRegion(
      onEnter: (_) => widget.onHovered?.call(widget.node),
      onExit: (_) => widget.onHovered?.call(null),
      child: SizedBox(
        width: widget.size.width,
        height: widget.size.height,
        child: Card(
          elevation:
              widget.dragged ? nfTheme.elevationDragged : nfTheme.elevation,
          margin: nfTheme.margin,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
