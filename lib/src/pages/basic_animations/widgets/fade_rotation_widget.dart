import 'dart:math';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class FadeRotationWidget extends StatefulWidget {
  final bool reset;

  const FadeRotationWidget({Key? key, this.reset = false}) : super(key: key);

  @override
  State<FadeRotationWidget> createState() => _FadeRotationWidgetState();
}

class _FadeRotationWidgetState extends State<FadeRotationWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;

  static const _duration = Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _duration);
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
              return Opacity(
                opacity: 1 - _controller.value,
                child: Transform.rotate(
                  angle: 2 * pi * _rotation.value,
                  child: child,
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
