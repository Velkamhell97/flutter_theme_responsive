import 'package:flutter/material.dart';

class BakcgroundContainer extends StatelessWidget {
  final CustomPainter painter;

  const BakcgroundContainer({Key? key, required this.painter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, double.infinity),
      painter: painter,
    );
  }
}