import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:math' as math;

class CircleProgress extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final double percent;

  CircleProgress({
    this.size = 200.0,
    this.strokeWidth = 10.0,
    this.percent = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: RepaintBoundary(
        child: CustomPaint(
          painter: CirclePainter(
            strokeWidth: strokeWidth,
            percent: percent,
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double strokeWidth;
  final double percent;

  CirclePainter({
    this.strokeWidth = 10.0,
    this.percent = 0.8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = (size.width - strokeWidth) / 2;
    final double startAngle = -math.pi / 2;
    final double sweepAngle = 2 * math.pi * percent;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = Colors.blue;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
