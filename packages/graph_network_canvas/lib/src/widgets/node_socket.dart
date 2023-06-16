// ignore_for_file: library_private_types_in_public_api

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../constants.dart';
import '../data.dart';
import '../theme/theme.dart';

const offset = 10.0;

class NodeSocketWidget extends StatefulWidget {
  final Socket socket;
  final Size size;
  final Size parentSize;
  final Function(TapDownDetails?)? onStartDrag;
  final Function(bool)? onHovered;

  const NodeSocketWidget(
    this.socket,
    this.parentSize, {
    super.key,
    this.size = defaultSocketSize,
    this.onStartDrag,
    this.onHovered,
  });

  @override
  _NodeSocketWidgetState createState() => _NodeSocketWidgetState();
}

class _NodeSocketWidgetState extends State<NodeSocketWidget> {
  final bool _isConnected = false;
  bool _isHovered = false;
  late final Socket socket = widget.socket;

  @override
  void initState() {
    socket.position = _calcSocketPosition(widget.socket.side);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final socketTheme =
        GraphCanvasTheme.of(context)?.socket ?? const SocketThemeData();

    return Positioned(
      left: socket.position.dx,
      top: socket.position.dy,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            widget.onHovered?.call(true);
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            widget.onHovered?.call(false);
            _isHovered = false;
          });
        },
        child: GestureDetector(
          onTapDown: widget.onStartDrag,
          child: AnimatedSwitcher(
            duration: socketTheme.hoverColorSwitchDuration,
            child: Container(
              key: _isHovered
                  ? Key('socket_${math.Random().nextInt(99999999)}_1')
                  : Key('socket_${math.Random().nextInt(99999999)}_2'),
              width: socketTheme.size.width,
              height: socketTheme.size.height,
              decoration: _buildDeco(socketTheme),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDeco(SocketThemeData socketTheme) {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: _getColor(socketTheme),
      boxShadow: _isHovered
          ? [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 0),
                blurStyle: BlurStyle.inner,
              ),
            ]
          : [],
    );
  }

  Offset _calcSocketPosition(SocketSide side) => switch (side) {
        SocketSide.left => Offset(
            0,
            widget.parentSize.height / 2,
          ),
        SocketSide.right => Offset(
            widget.parentSize.width - offset,
            widget.parentSize.height / 2,
          ),
        SocketSide.top => Offset(
            widget.parentSize.width / 2,
            0,
          ),
        SocketSide.bottom => Offset(
            widget.parentSize.width / 2,
            widget.parentSize.height - 20,
          )
      };

  _getColor(SocketThemeData socketTheme) {
    if (!_isConnected && !_isHovered) {
      return socketTheme.notConnectedColor.normal;
    }

    if (_isConnected && _isHovered) {
      return socketTheme.connectedColor.activated;
    }

    if (_isConnected && !_isHovered) {
      return socketTheme.connectedColor.normal;
    }

    if (!_isConnected && _isHovered) {
      return socketTheme.notConnectedColor.activated;
    }
  }
}
