import 'package:flutter/material.dart';

import 'package:graph_network_canvas/src/constants.dart';

import 'data.dart';
import 'node_frame_rectangle.dart';

class Socket {
  final GraphCanvasNodeInfo _parent;
  late Offset position;
  SocketSide side;
  Connection? connection;

  Socket({
    required this.side,
    Offset? position,
    GraphCanvasNodeInfo? parent,
    this.connection,
  }) : _parent = parent ?? GraphCanvasNodeInfo(NodeFrameRectangle.zero()) {
    const s = defaultNodeSize;
    this.position = position ??
        switch (side) {
          SocketSide.left => Offset(0, s.height / 2),
          SocketSide.right => Offset(s.width, s.height / 2),
          SocketSide.top => Offset(s.width / 2, 0),
          SocketSide.bottom => Offset(s.width / 2, s.height),
        };
  }

  // Get this Sockets global position relative to the canvas
  Offset get globalPosition => position + _parent.shape.center;

  // Whether this socket has a connection
  bool get hasConnection => connection != null;

  // Copy this socket with a different parameter
  Socket copyWith({
    Offset? position,
    SocketSide? side,
    Connection? connection,
  }) {
    return Socket(
      position: position ?? this.position,
      side: side ?? this.side,
      parent: _parent,
      connection: connection ?? this.connection,
    );
  }
}

class Connection {
  Socket from;
  Socket to;
  ConnectionData? data;

  Offset get midPoint => Offset(
        from.globalPosition.dx +
            (to.globalPosition.dx - from.globalPosition.dx) / 2,
        from.globalPosition.dy +
            (to.globalPosition.dy - from.globalPosition.dy) / 2,
      );

  Connection({required this.from, required this.to, this.data}) {
    from.connection = this;
    to.connection = this;
  }
}
