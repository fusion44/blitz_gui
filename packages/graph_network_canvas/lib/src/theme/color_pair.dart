import 'dart:math';

import 'package:flutter/material.dart';

class ColorPair {
  final Color normal;
  final Color activated;

  const ColorPair({required this.normal, required this.activated});

  factory ColorPair.random() {
    return ColorPair(
      normal: Color.fromRGBO(
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
        1,
      ),
      activated: Color.fromRGBO(
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
        1,
      ),
    );
  }

  ColorPair copyWith({Color? normal, Color? activated}) => ColorPair(
        normal: normal ?? this.normal,
        activated: activated ?? this.activated,
      );
}
