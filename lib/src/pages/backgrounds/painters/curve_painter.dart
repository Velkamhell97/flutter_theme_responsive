// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  final Color color;

  const CurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = color;

    final pControl  = Size(size.width * 0.5, size.height * 0.55);
    final pHeight = size.height * 0.8;

    final path = Path()
    ..lineTo(size.width, 0)

    ..lineTo(size.width, pHeight)
    ..quadraticBezierTo(pControl.width, pControl.height, 0, pHeight)

    ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CurvePainter oldDelegate) => false;
}