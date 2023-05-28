import 'package:flutter/material.dart';

import 'color_pair.dart';

class SocketThemeData {
  final Size size;
  final ColorPair notConnectedColor;
  final ColorPair connectedColor;
  final Duration hoverColorSwitchDuration;

  const SocketThemeData({
    this.size = const Size(10, 10),
    this.notConnectedColor = const ColorPair(
      normal: Colors.blueGrey,
      activated: Colors.red,
    ),
    this.connectedColor = const ColorPair(
      normal: Colors.blue,
      activated: Colors.green,
    ),
    this.hoverColorSwitchDuration = const Duration(milliseconds: 150),
  });
}
