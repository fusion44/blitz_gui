import 'package:flutter/material.dart';

import '../constants.dart';

class NodeFrameThemeData {
  final EdgeInsets margin;
  final double elevation;
  final double elevationDragged;

  const NodeFrameThemeData({
    EdgeInsets? margin,
    this.elevation = defaultNodeElevation,
    this.elevationDragged = defaultNodeElevationDragged,
  }) : margin = margin ?? const EdgeInsets.all(defaultNodeMarginAll);
}
