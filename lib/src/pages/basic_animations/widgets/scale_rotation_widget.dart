import 'dart:math';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ScaleRotationWidget extends StatefulWidget {
  final bool reset;

  const ScaleRotationWidget({Key? key, this.reset = false}) : super(key: key);

  @override
  State<ScaleRotationWidget> createState() => _ScaleRotationWidgetState();
}

class _ScaleRotationWidgetState extends State<ScaleRotationWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _rotation;
  late final Animation<double> _scale1;
  late final Animation<double> _scale2;

  static const _duration = Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _duration);

    _scale1 = CurvedAnimation(
      parent: _controller, 
      curve: const Interval(
        0,0.5
      ),
    );

    _scale2 = CurvedAnimation(
      parent: _controller, 
      curve: const Interval(
        0.5,1.0
      ),
    );

    _rotation = CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _animate() async {
    if(_controller.isAnimating) return;
    
    if(widget.reset){
      await _controller.forward();
      _controller.reset();
    } else {
      _controller.isCompleted ? _controller.reverse() : _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: AnimatedBuilder( //-Tambien se peude un animatedRotate
            animation: _controller,
            builder: (_, child) {
              //-La ventaja de usar tweens esque los valores estan precargados pero estas operaciones matematicas
              //-son bastantes rapidas
              final scale = 1 - (0.5 * _scale1.value) + (0.5 * _scale2.value);

              return Transform.rotate(
                angle: 2 * pi * _rotation.value,
                child: Transform.scale(
                  scale: scale,
                  child: child
                ),
              );
            },
            child: const Center(
              child: Rectangle(
                width: 50,
                height: 50,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: PlayButton(
              onPressed: _animate
            ),
          ),
        )
      ],
    );
  }
}
