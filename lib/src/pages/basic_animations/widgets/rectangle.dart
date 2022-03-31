import 'package:flutter/material.dart';

class Rectangle extends StatelessWidget {
  final double? width;
  final double? height;
  final Color color;

  const Rectangle({Key? key, required this.width, required this.height, this.color = Colors.blue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color),
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}