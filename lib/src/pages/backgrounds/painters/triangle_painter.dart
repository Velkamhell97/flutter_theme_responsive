import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color color;

  const TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = color;

    final point = Size(size.width * 0.5, size.height * 0.6);

    final path = Path()
    ..lineTo(size.width, 0)

    ..relativeLineTo(0, point.height)
    ..relativeLineTo(-point.width, size.height - point.height)
    ..relativeLineTo(-point.width, -(size.height - point.height))

    ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TrianglePainter oldDelegate) => false;
}