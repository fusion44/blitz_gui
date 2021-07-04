import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../../common/widgets/translated_text.dart';

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class NewNodeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int _currentStep;

  const NewNodeAppBar(this._currentStep, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Timeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0.15,
          direction: Axis.horizontal,
          connectorTheme: ConnectorThemeData(space: 30.0, thickness: 5.0),
        ),
        builder: TimelineTileBuilder.connected(
          itemCount: _steps,
          connectionDirection: ConnectionDirection.before,
          itemExtentBuilder: (_, __) =>
              MediaQuery.of(context).size.width / _steps,
          contentsBuilder: _contentsBuilder,
          indicatorBuilder: _indicatorBuilder,
          connectorBuilder: _connectorBuilder,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);

  Color _getColor(int index) {
    if (index == _currentStep) {
      return inProgressColor;
    } else if (index < _currentStep) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  Widget? _connectorBuilder(_, index, type) {
    if (index > 0) {
      if (index == _currentStep) {
        final prevColor = _getColor(index - 1);
        final color = _getColor(index);
        List<Color> gradientColors;
        if (type == ConnectorType.start) {
          gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
        } else {
          gradientColors = [prevColor, Color.lerp(prevColor, color, 0.5)!];
        }
        return DecoratedLineConnector(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColors),
          ),
        );
      } else {
        return SolidLineConnector(color: _getColor(index));
      }
    } else {
      return null;
    }
  }

  Widget? _indicatorBuilder(_, index) {
    var color;
    var child;
    if (index == _currentStep) {
      color = inProgressColor;
      child = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(_getIcon(index), size: 15),
      );
    } else if (index < _currentStep) {
      color = completeColor;
      child = Icon(Icons.check, color: Colors.white, size: 15.0);
    } else {
      color = todoColor;
    }

    if (index <= _currentStep) {
      return Stack(
        children: [
          CustomPaint(
            size: Size(30.0, 30.0),
            painter: _BezierPainter(
              color: color,
              drawStart: index > 0,
              drawEnd: index < _currentStep,
            ),
          ),
          DotIndicator(
            size: 30.0,
            color: color,
            child: child,
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          CustomPaint(
            size: Size(15.0, 15.0),
            painter: _BezierPainter(
              color: color,
              drawEnd: index < _steps - 1,
            ),
          ),
          OutlinedDotIndicator(
            borderWidth: 4.0,
            color: color,
          ),
        ],
      );
    }
  }

  Widget _contentsBuilder(context, index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: TrText(
        _getName(index),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _getColor(index),
        ),
      ),
    );
  }

  static const _steps = 5;
  String _getName(int index) {
    switch (index) {
      case 0:
        return 'setup.timeline.prepare_sd_card';
      case 1:
        return 'setup.timeline.initial_connect_to_node';
      case 2:
        return 'setup.timeline.set_node_name';
      case 3:
        return 'setup.timeline.set_passwords_a_b';
      case 4:
        return 'setup.timeline.final_steps';
      default:
        throw RangeError.index(index, []);
    }
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.sd_card;
      case 1:
        return Icons.add_link;
      case 2:
        return Icons.signal_wifi_4_bar_lock_outlined;
      case 3:
        return Icons.signal_wifi_4_bar_lock_outlined;
      case 4:
        return Icons.signal_wifi_4_bar_lock_outlined;
      default:
        throw RangeError.index(index, []);
    }
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius)
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();
      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(
          size.width,
          size.height / 2,
          size.width + radius,
          radius,
        )
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
