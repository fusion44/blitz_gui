import 'package:flutter/material.dart';

import 'node_frame_rectangle.dart';

class GraphCanvasNodeInfo {
  final String id;
  NodeFrameRectangle shape;
  Widget? body;

  final Function(NodeFrameRectangle position)? onPositionUpdated;

  GraphCanvasNodeInfo(
    this.shape, {
    this.body,
    this.onPositionUpdated,
    this.id = '',
  });

  // copyWith
  GraphCanvasNodeInfo copyWith({NodeFrameRectangle? shape, String? id}) {
    return GraphCanvasNodeInfo(
      shape ?? this.shape,
      body: body,
      onPositionUpdated: onPositionUpdated,
      id: id ?? this.id,
    );
  }
}

enum SocketSide { left, right, top, bottom }

extension SocketSideExtensions on SocketSide {
  SocketSide get opposite {
    switch (this) {
      case SocketSide.left:
        return SocketSide.right;
      case SocketSide.right:
        return SocketSide.left;
      case SocketSide.top:
        return SocketSide.bottom;
      case SocketSide.bottom:
        return SocketSide.top;
    }
  }
}

class ConnectionData {
  /// ID where this connection is originating from
  final String from;

  /// Target node ID
  final String to;

  /// If > 0, this is a split connection the connection is drawn in two
  /// segments. See [firstSegmentColor] and [secondSegmentColor]. If == 0
  /// then [firstSegmentColor] will be used to draw the whole path.
  final double splitPercentage;

  /// Color of the connection and the first segment if [splitPercentage] > 0
  final Color firstSegmentColor;

  /// The color of the second segment if [splitPercentage] > 0
  final Color secondSegmentColor;

  /// See [Paint.strokeWidth]
  final double strokeWidth;

  ConnectionData(
    this.from,
    this.to, {
    this.splitPercentage = 0.0,
    this.firstSegmentColor = Colors.blueGrey,
    this.secondSegmentColor = Colors.grey,
    this.strokeWidth = 0.0,
  });
}
