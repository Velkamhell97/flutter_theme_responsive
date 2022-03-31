// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class RoundedPainter extends CustomPainter {
  final Color color;

  const RoundedPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = color;

    const radius = 0.15;
    final round  = Size(size.width * radius, size.height * radius);

    final corner1 = Size(size.width, size.height  - round.height);
    final corner2 = Size(round.width, size.height);

    final path = Path()
    ..lineTo(size.width, 0)

    ..lineTo(corner1.width, corner1.height)
    //El punto de control se encuentra en las esquinas
    ..relativeQuadraticBezierTo(0, round.height, -round.width, round.height)

    ..lineTo(corner2.width, corner2.height)
    ..relativeQuadraticBezierTo(-round.width, 0, -round.width, -round.height)

    ..close();

    // canvas.drawPath(path, paint);

    const borderRadius = 60.0;
    final rect = const Offset(0,0) & size;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        bottomLeft: const Radius.circular(borderRadius),
        bottomRight: const Radius.circular(borderRadius)
      ), 
      paint
    );
  }

  @override
  bool shouldRepaint(RoundedPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(RoundedPainter oldDelegate) => false;
}