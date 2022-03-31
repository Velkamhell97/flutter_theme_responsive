import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedCircularProgress extends StatelessWidget {
  final double percentage;
  final double innerStrokeWidth;
  final Color innerStrokeColor;
  final double outerStrokeWidth;
  final Color outerStrokeColor;

  const AnimatedCircularProgress({
    Key? key, 
    this.percentage = 0,
    this.innerStrokeWidth = 5,
    this.innerStrokeColor = Colors.black,
    this.outerStrokeWidth = 8,
    this.outerStrokeColor = Colors.blue, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = percentage / 100;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: progress, end: progress),
      builder: (context, value, child) {
        return CustomPaint(
          painter: _CircularProgressPainter(
            progress: value,
            innerStrokeColor: innerStrokeColor,
            innerStrokeWidth: innerStrokeWidth,
            outerStrokeColor: outerStrokeColor,
            outerStrokeWidth: outerStrokeWidth
          ),
        );
      },
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final double innerStrokeWidth;
  final Color innerStrokeColor;
  final double outerStrokeWidth;
  final Color outerStrokeColor;

  const _CircularProgressPainter({
    this.progress = 0,
    this.innerStrokeWidth = 5,
    this.innerStrokeColor = Colors.black,
    this.outerStrokeWidth = 8,
    this.outerStrokeColor = Colors.blue, 
  });

  static const _startAngle = - pi / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final innerPaint = Paint()
    ..color = innerStrokeColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = innerStrokeWidth;

    final outerPaint = Paint()
    ..color = outerStrokeColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = outerStrokeWidth
    ..strokeCap = StrokeCap.round;

    final radius = size.width / 2;
    final center = Offset(radius, radius);

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, _startAngle, 2 * pi, false, innerPaint);

    final sweepAngle = lerpDouble(0, 2 * pi, progress)!;
    canvas.drawArc(rect, _startAngle, sweepAngle, false, outerPaint);
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_CircularProgressPainter oldDelegate) => false;
}