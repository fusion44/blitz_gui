import 'package:flutter/material.dart';

class Node {
  Offset position;
  final List<Socket> _sockets;

  Node(this.position, {List<Socket>? sockets}) : _sockets = sockets ?? [];

  List<Socket> get sockets => _sockets;

  bool get hasSockets => _sockets.isEmpty;

  Socket addSocket(SocketSide side) {
    final socket = Socket(side: side, parent: this);
    _sockets.add(socket);

    return socket;
  }

  void removeSocket(Socket socket) {
    if (!_sockets.contains(socket)) throw StateError('Socket not found');

    _sockets.remove(socket);
  }

  bool containsSocket(Socket socket) => _sockets.contains(socket);

  // copyWith
  Node copyWith({Offset? position, List<Socket>? sockets}) {
    return Node(position ?? this.position, sockets: sockets ?? _sockets);
  }
}

enum SocketSide { left, right, top, bottom }

class Socket {
  final Node _parent;
  Offset position;
  SocketSide side;
  Connection? connection;

  Socket({
    required this.side,
    this.position = Offset.zero,
    Node? parent,
    this.connection,
  }) : _parent = parent ?? Node(Offset.zero);

  /// Get this Sockets global position relative to the canvas
  Offset get globalPosition => position + _parent.position;

  /// Get whether this Socket has a connection or not
  bool get hasConnection => connection != null;

  /// Copy this socket with a different parameter
  Socket copyWith({
    Offset? position,
    SocketSide? side,
    Connection? connection,
  }) {
    return Socket(
      position: position ?? this.position,
      side: side ?? this.side,
      parent: _parent,
      connection: connection,
    );
  }
}

class Connection {
  Socket socket1;
  Socket socket2;

  Offset get midPoint => Offset(
        socket1.globalPosition.dx +
            (socket2.globalPosition.dx - socket1.globalPosition.dx) / 2,
        socket1.globalPosition.dy +
            (socket2.globalPosition.dy - socket1.globalPosition.dy) / 2,
      );

  Connection({required this.socket1, required this.socket2}) {
    socket1.connection = this;
    socket2.connection = this;
  }
}
