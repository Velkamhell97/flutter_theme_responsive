// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final Color color;

  const WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xff6D05E8),
        Color(0xffC012FF),
        Color(0xff6D05FA),
      ]
    );

    final paint = Paint()
    ..color = color
    ..shader = gradient.createShader(const Offset(0,0) & size)
    ;

    final height = size.height * 0.8;
    final middle = Size(size.width * 0.5, height);

    final path = Path()
    ..lineTo(size.width, 0)

    ..lineTo(size.width, height)
    ..quadraticBezierTo(size.width * 0.75, height * 0.5, middle.width, middle.height)
    ..quadraticBezierTo(size.width * 0.25, height * 1.5, 0, middle.height)

    ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(WavePainter oldDelegate) => false;
}