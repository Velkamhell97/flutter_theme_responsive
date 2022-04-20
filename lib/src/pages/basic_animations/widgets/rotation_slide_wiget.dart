import 'dart:math';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class RotationSlideWidget extends StatefulWidget {
  final bool reset;

  const RotationSlideWidget({Key? key, this.reset = false}) : super(key: key);

  @override
  State<RotationSlideWidget> createState() => _RotationSlideWidgetState();
}

class _RotationSlideWidgetState extends State<RotationSlideWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _rotation;
  late final Animation<double> _traslation1;
  late final Animation<double> _traslation2;
  late final Animation<double> _traslation3;

  static const _duration1 = 700;
  static const _stop1 = 500;
  static const _duration2 = 700;
  static const _stop2 = 500;
  static const _duration3 = 700;
  // static const _stop3 = 0; /// Para agregar un delay al final

  static const _duration = _duration1 + _stop1 + _duration2 + _stop2 + _duration3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: _duration));

    const end1 = _duration1;

    _rotation = CurvedAnimation(
      parent: _controller, 
      curve: Curves.linear
    );

    _traslation1 = CurvedAnimation(
      parent: _controller, 
      curve: const Interval(
        0, end1 / _duration,
        curve: Curves.elasticOut
      ),
      reverseCurve: const Interval(
        0, end1 / _duration,
        curve: Curves.elasticIn
      )
    );

    const begin2 = end1 + _stop1;
    const end2 = begin2 + _duration2;

    _traslation2 = CurvedAnimation(
      parent: _controller, 
      curve: const Interval(
        begin2 / _duration, end2 / _duration,
        curve: Curves.elasticOut
      ),
      reverseCurve: const Interval(
        begin2 / _duration, end2 / _duration,
        curve: Curves.elasticIn
      )
    );

    const begin3 = end2 + _stop2;
    const end3 = begin3 + _duration3;

    _traslation3 = CurvedAnimation(
      parent: _controller, 
      curve: const Interval(
        begin3 / _duration, end3 / _duration,
        curve: Curves.elasticOut
      ),
      reverseCurve: const Interval(
        begin3 / _duration, end3 / _duration,
        curve: Curves.elasticIn
      ),
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
        Expanded(
          flex: 3,
          child: LayoutBuilder( //Para cambios de portrait
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              
              return AnimatedBuilder( //-Tambien se peude un animatedRotate
                animation: _controller,
                builder: (_, child) {
                  final t1 = (width * 0.4) * _traslation1.value;
                  final t2 = (width * 0.7) * _traslation2.value;
                  final t3 = (width * 0.3) * _traslation3.value;
              
                  return Transform.translate(
                    offset: Offset(t1 - t2 + t3, 0.0),
                    child: Transform.rotate(
                      angle: 4 * pi * _rotation.value,
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
              );
            },
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
