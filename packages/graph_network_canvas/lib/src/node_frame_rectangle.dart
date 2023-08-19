import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'constants.dart';

enum Quadrant {
  top,
  topLeft,
  left,
  bottomLeft,
  bottom,
  bottomRight,
  right,
  topRight,
  none
}

class NodeFrameRectangle extends MutableRectangle {
  NodeFrameRectangle(double left, double top, double width, double height)
      : super(left, top, width, height);

  static NodeFrameRectangle zero() => NodeFrameRectangle(0, 0, 0, 0);

  static NodeFrameRectangle fromOffset(
    Offset offset, {
    Size size = defaultNodeSize,
  }) =>
      NodeFrameRectangle(
        offset.dx - size.width / 2,
        offset.dy - size.height / 2,
        size.width,
        size.height,
      );

  Offset get center => Offset(left + width / 2, top + height / 2);

  set center(Offset centerOffset) {
    left = centerOffset.dx - width / 2;
    top = centerOffset.dy - height / 2;
  }

  Quadrant determineQuadrantOf(NodeFrameRectangle other,
      {double margin = 300.0}) {
    Offset baseCenter = center;
    Offset otherCenter = other.center;

    bool isWithinHorizontalMargin = otherCenter.dy > (baseCenter.dy - margin) &&
        otherCenter.dy < (baseCenter.dy + margin);
    bool isWithinVerticalMargin = otherCenter.dx > (baseCenter.dx - margin) &&
        otherCenter.dx < (baseCenter.dx + margin);

    if (isWithinVerticalMargin) {
      if (otherCenter.dy > baseCenter.dy) return Quadrant.bottom;
      return Quadrant.top;
    }

    if (isWithinHorizontalMargin) {
      if (otherCenter.dx > baseCenter.dx) return Quadrant.right;
      return Quadrant.left;
    }

    if (otherCenter.dx < baseCenter.dx && otherCenter.dy < baseCenter.dy) {
      return Quadrant.topLeft;
    }

    if (otherCenter.dx > baseCenter.dx && otherCenter.dy < baseCenter.dy) {
      return Quadrant.topRight;
    }

    if (otherCenter.dx < baseCenter.dx && otherCenter.dy > baseCenter.dy) {
      return Quadrant.bottomLeft;
    }

    if (otherCenter.dx > baseCenter.dx && otherCenter.dy > baseCenter.dy) {
      return Quadrant.bottomRight;
    }

    return Quadrant.none;
  }

  static NodeFrameRectangle fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);

    return NodeFrameRectangle(
      data['left'],
      data['top'],
      data['width'],
      data['height'],
    );
  }

  String toJson() =>
      jsonEncode({'left': left, 'top': top, 'width': width, 'height': height});
}
