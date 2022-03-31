import 'package:flutter/material.dart';

// import 'widgets/animated_circular_progress.dart';
import 'widgets/controlled_circular_progress.dart';

class CircularProgressHome extends StatefulWidget {
  const CircularProgressHome({Key? key}) : super(key: key);

  @override
  State<CircularProgressHome> createState() => _CircularProgressHomeState();
}

class _CircularProgressHomeState extends State<CircularProgressHome> {
  double _percentage = 0;

  static const _finalValue = 98.7;
  
  void _play() {
    if(_percentage == _finalValue) {
      _percentage = 0.0;
    } else {
      _percentage = _finalValue;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: landscape ? null : AppBar(title: const Text('Circular Progress App')),
      body: Center(
        // child: SizedBox(
        //   width: 100,
        //   height: 100,
        //   child: AnimatedCircularProgress( //-> Con TweenAnimationBuilder
        //     percentage: 50,
        //   ),
        // ),
        child: SizedBox(
          width: 100,
          height: 100,
          child: ControllerCircularProgress(  //-> Con AnimatedBuilder
            percentage: _percentage,
            innerStrokeColor: Colors.grey,
            innerStrokeWidth: 2,
            outerStrokeColor: Colors.green,
            outerStrokeWidth: 5,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _play,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}