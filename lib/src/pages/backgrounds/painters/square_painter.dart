import 'package:flutter/material.dart';

class SquarePainter extends CustomPainter {
  final Color color;

  const SquarePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = color;

    final path = Path()
    ..lineTo(size.width, 0)
    ..lineTo(size.width, size.height)
    ..lineTo(0, size.height)
    ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SquarePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(SquarePainter oldDelegate) => false;
}