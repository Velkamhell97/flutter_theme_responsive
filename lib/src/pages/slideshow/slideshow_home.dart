import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/animated_slideshow.dart';

class SlideShowHome extends StatelessWidget {
  const SlideShowHome({Key? key}) : super(key: key);

  static const _slides = [
    'assets/svg/slide-1.svg',
    'assets/svg/slide-2.svg',
    'assets/svg/slide-3.svg',
    'assets/svg/slide-4.svg',
  ];

  @override
  Widget build(BuildContext context) {
    /// Aqui cambia si se muestran los Slideshows en fila o columna
    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    /// Hay un problema aqui y esque al ser diferentes widgets cada uno maneja su estado por lo que si
    /// se cambia de orientacion se pierde el SlideShow actual, por esta razon lo que se hace es utilizar un
    /// Flex que es un widget que permite cambiar la organizacion de los children, este widget es diferente al Wrap
    /// que busca adaptar los elementos al espacio disponible, El flex es un widget muy util para el responsive
    return Scaffold(
      body: Flex(
        direction: landscape ? Axis.horizontal : Axis.vertical,
        children: [
           Expanded(
            child: SlideShowWidget(
              slides: List.generate(_slides.length, (index) {
                return SvgPicture.asset(_slides[index]);
              }),
              dotsColor: Colors.indigo,
              dotSize: 15,
              // dotsDown: false,
            ),
           ),
          Expanded(
            child: SlideShowWidget(
              slides: List.generate(_slides.length, (index) {
                return SvgPicture.asset(_slides[index]);
              }),
              dotsColor: Colors.indigo,
              dotSize: 15,
              // dotsDown: false,
            ),
          )
        ],
      )
    );
  }
}