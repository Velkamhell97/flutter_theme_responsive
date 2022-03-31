import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class ControllerCircularProgress extends StatefulWidget {
  /// Value between 0 and 100
  final double percentage;
  final double innerStrokeWidth;
  final Color innerStrokeColor;
  final double outerStrokeWidth;
  final Color outerStrokeColor;

  const ControllerCircularProgress({
    Key? key,
    this.percentage = 0,
    this.innerStrokeWidth = 5,
    this.innerStrokeColor = Colors.black,
    this.outerStrokeWidth = 8,
    this.outerStrokeColor = Colors.blue,
  }) : 
    assert(percentage <= 100.0),
    super(key: key);

  @override
  State<ControllerCircularProgress> createState() => _ControllerCircularProgressState();
}

class _ControllerCircularProgressState extends State<ControllerCircularProgress> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _duration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      // duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const _style = TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
  
  @override
  Widget build(BuildContext context) {
    _controller.animateTo(widget.percentage / 100, duration: _duration);

    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _CircularProgressPainter(
              animation: _controller,
              innerStrokeColor: widget.innerStrokeColor,
              innerStrokeWidth: widget.innerStrokeWidth,
              outerStrokeColor: widget.outerStrokeColor,
              outerStrokeWidth: widget.outerStrokeWidth
            ),
            child: Container(),
          ),
        ),
        Align(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              final percentage = _controller.value * 100;
              return Text(percentage.toStringAsFixed(1) + '%', style: _style);
            },
          ),
        )
      ],
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final Animation<double> animation;
  final double innerStrokeWidth;
  final Color innerStrokeColor;
  final double outerStrokeWidth;
  final Color outerStrokeColor;

  _CircularProgressPainter({
    required this.animation,
    this.innerStrokeWidth = 5,
    this.innerStrokeColor = Colors.black,
    this.outerStrokeWidth = 8,
    this.outerStrokeColor = Colors.blue, 
  }) : super(repaint: animation);

  static const _sweepGradient = SweepGradient(
    colors: [
      Color(0xffC012FF),
      Color(0xff6D05E8),
      Colors.red,
    ],
    tileMode: TileMode.repeated,
    startAngle: 3 * pi / 2,
    endAngle: 7 * pi / 2,
  );

  static const _linearGradient = LinearGradient(
    colors: [
      Color(0xffC012FF),
      Color(0xff6D05E8),
      Colors.red,
    ],
  );

  @override
  void paint(Canvas canvas, Size size) {
    final circle = const Offset(0,0) & size;
    //-Se obtiene un mejor efecto con este tipo de rectangulos
    final gradientCircle = Rect.fromCircle(center: const Offset(0,0), radius: size.width);

    final innerPaint = Paint()
    ..color = innerStrokeColor
    ..strokeWidth = innerStrokeWidth
    ..style = PaintingStyle.stroke;

    final outerPaint = Paint()
    ..color = outerStrokeColor
    ..strokeWidth = outerStrokeWidth
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..shader = _linearGradient.createShader(gradientCircle)
    // ..shader = _sweepGradient.createShader(circle)
    ;

    //-Se le suma un poco por el cap round
    final angle = lerpDouble(0, (2 * pi) + 0.1, animation.value)!;

    canvas.drawArc(circle, 0, 2 * pi, false, innerPaint);
    canvas.drawArc(circle, -pi / 2, angle, false, outerPaint);
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_CircularProgressPainter oldDelegate) => false;
}