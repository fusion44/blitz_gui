import 'dart:ui';

import 'package:flutter/material.dart';

class DebugView extends StatefulWidget {
  @override
  _DebugViewState createState() => _DebugViewState();
}

class _DebugViewState extends State<DebugView> {
  Offset _globalPosition = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _globalPosition = details.globalPosition;
        });
      },
      child: Scaffold(
        body: CustomPaint(
          painter: OpenPainter(_globalPosition),
        ),
      ),
    );
    ;
  }
}

class OpenPainter extends CustomPainter {
  final Offset _pos;
  OpenPainter(this._pos);

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff63aa65)
      ..strokeWidth = 10;
    var points = [_pos];
    canvas.drawPoints(PointMode.points, points, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
