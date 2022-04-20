import 'package:flutter/material.dart';

import 'painters/painters.dart';
import 'widgets/background_container.dart';

class BackgroundsHome extends StatelessWidget {
  const BackgroundsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    /// Para manejar los cambios de orientacion
    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      /// Como en la vista portrait solo queremos un appbar la eliminamos en ese  modo, el unico problema
      /// es si navega a esta pantalla en lasnscape y voltea el telefono se tendria que crear una varaible
      /// global que identifique en que modo esta en todo momento o una bandera que indique si ha navegado
      /// o no
      appBar: landscape ? null : AppBar(title: const Text('Backgrounds App')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          /// Cambiamos de lista segun la orintacion y pasamos el height disponible para utilizarlo por completo
          final height = constraints.maxHeight;
          return landscape ? _BackgroundsGrid(height: height) : _BackgroundsList(height: height);
        },
      )
    );
  }
}

class _BackgroundsList extends StatelessWidget {
  final double height;

  const _BackgroundsList({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      itemExtent: height / 6,
      children:  const [
        BakcgroundContainer(
          painter: SquarePainter(color: Colors.red)
        ),
        BakcgroundContainer(
          painter: RoundedPainter(color: Colors.blue)
        ),
        BakcgroundContainer(
          painter: DiagonalPainter(color: Colors.green)
        ),
        BakcgroundContainer(
          painter: TrianglePainter(color: Colors.yellow)
        ),
        BakcgroundContainer(
          painter: CurvePainter(color: Colors.purpleAccent)
        ),
        BakcgroundContainer(
          painter: WavePainter(color: Colors.purpleAccent)
        )
      ],
    );
  }
}

class _BackgroundsGrid extends StatelessWidget {
  final double height;

  const _BackgroundsGrid({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: height / 3
      ),
      children: const [
        BakcgroundContainer(
          painter: SquarePainter(color: Colors.red)
        ),
        BakcgroundContainer(
          painter: RoundedPainter(color: Colors.blue)
        ),
        BakcgroundContainer(
          painter: DiagonalPainter(color: Colors.green)
        ),
        BakcgroundContainer(
          painter: TrianglePainter(color: Colors.yellow)
        ),
        BakcgroundContainer(
          painter: CurvePainter(color: Colors.purpleAccent)
        ),
        BakcgroundContainer(
          painter: WavePainter(color: Colors.purpleAccent)
        )
      ],
    );
  }
}