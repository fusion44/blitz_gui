import 'package:flutter/material.dart';

import 'constants.dart';

Offset constrainNodeToCanvas(
  Offset p,
  Size constraints, {
  Size nodeSize = defaultNodeSize,
}) {
  return Offset(
    p.dx.clamp(0, constraints.width - nodeSize.width),
    p.dy.clamp(0, constraints.height - nodeSize.height),
  );
}
