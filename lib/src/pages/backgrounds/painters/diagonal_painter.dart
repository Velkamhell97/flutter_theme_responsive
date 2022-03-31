import 'package:flutter/material.dart';

class DiagonalPainter extends CustomPainter {
  final Color color;

  const DiagonalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = color;

    final path = Path()
    ..lineTo(size.width, 0)
    ..lineTo(size.width, size.height * 0.75)
    ..lineTo(0, size.height)
    ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(DiagonalPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(DiagonalPainter oldDelegate) => false;
}