import 'dart:ui';

import 'package:flutter/material.dart';

import 'data.dart';

class ConnectionLinePainter extends CustomPainter {
  final List<Connection> connections;
  final double splitPercentage;
  final double elevation;

  ConnectionLinePainter(this.connections, this.splitPercentage,
      {this.elevation = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    for (final connection in connections) {
      final startPoint = connection.socket1.globalPosition;
      final endPoint = connection.socket2.globalPosition;

      final midPoint = connection.midPoint;

      final controlPoint1 = Offset(midPoint.dx, startPoint.dy);
      final controlPoint2 = Offset(midPoint.dx, endPoint.dy);

      final path = Path()
        ..moveTo(startPoint.dx, startPoint.dy)
        ..cubicTo(
          controlPoint1.dx,
          controlPoint1.dy,
          controlPoint2.dx,
          controlPoint2.dy,
          endPoint.dx,
          endPoint.dy,
        );

      if (elevation > 0) {
        drawShadow(canvas, path, 10);
      }

      final pathMetrics = path.computeMetrics();
      late final PathMetric pathMetric;

      try {
        pathMetric = pathMetrics.first;
      } on StateError {
        continue;
      }

      final totalLength = pathMetric.length;
      final firstLength = totalLength * splitPercentage;

      final firstPath = pathMetric.extractPath(0.0, firstLength);
      final secondPath = pathMetric.extractPath(firstLength, totalLength);

      paint.color = Colors.yellow;
      canvas.drawPath(firstPath, paint);

      paint.color = Colors.blue;
      canvas.drawPath(secondPath, paint);

      // Draw a rectangle at the start point
      final rectPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromCenter(center: startPoint, width: 10, height: 10),
        rectPaint,
      );

      // Draw a circle at the end point
      final circlePaint = Paint()
        ..color = Colors.green
        ..style = PaintingStyle.fill;
      canvas.drawCircle(endPoint, 5, circlePaint);
    }
  }

  void drawShadow(Canvas canvas, Path path, double elevation) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final shadowPath = path.shift(Offset(0, elevation));

    canvas.drawPath(shadowPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
