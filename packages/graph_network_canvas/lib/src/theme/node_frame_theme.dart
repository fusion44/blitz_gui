import 'package:flutter/material.dart';

import 'node_frame_theme_data.dart';
import 'socket_theme_data.dart';

class GraphCanvasTheme extends InheritedWidget {
  final NodeFrameThemeData frame;
  final SocketThemeData socket;

  const GraphCanvasTheme({
    Key? key,
    this.frame = const NodeFrameThemeData(),
    this.socket = const SocketThemeData(),
    required Widget child,
  }) : super(key: key, child: child);

  static GraphCanvasTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GraphCanvasTheme>();
  }

  @override
  bool updateShouldNotify(GraphCanvasTheme oldWidget) =>
      identical(this, oldWidget) ||
      runtimeType == oldWidget.runtimeType &&
          frame.margin == oldWidget.frame.margin &&
          frame.elevation == oldWidget.frame.elevation &&
          frame.elevationDragged == oldWidget.frame.elevationDragged &&
          socket.connectedColor == oldWidget.socket.connectedColor &&
          socket.notConnectedColor == oldWidget.socket.notConnectedColor;
}
