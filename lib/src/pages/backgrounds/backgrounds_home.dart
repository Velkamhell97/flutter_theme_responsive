import 'package:flutter/material.dart';

import 'painters/painters.dart';
import 'widgets/background_container.dart';

class BackgroundsHome extends StatelessWidget {
  const BackgroundsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: landscape ? null : AppBar(title: const Text('Backgrounds App')),
      body: Column(
        children: const [
          Expanded(
            child: BakcgroundContainer(
              painter: SquarePainter(color: Colors.red)
            ),
          ),
          Expanded(
            child: BakcgroundContainer(
              painter: RoundedPainter(color: Colors.blue)
            ),
          ),
          Expanded(
            child: BakcgroundContainer(
              painter: DiagonalPainter(color: Colors.green)
            ),
          ),
          Expanded(
            child: BakcgroundContainer(
              painter: TrianglePainter(color: Colors.yellow)
            ),
          ),
          Expanded(
            child: BakcgroundContainer(
              painter: CurvePainter(color: Colors.purpleAccent)
            ),
          ),
          Expanded(
            child: BakcgroundContainer(
              painter: WavePainter(color: Colors.purpleAccent)
            ),
          )
        ],
      ),
    );
  }
}