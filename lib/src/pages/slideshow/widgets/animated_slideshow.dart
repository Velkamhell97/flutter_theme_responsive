import 'package:flutter/material.dart';
import 'dart:math';

class SlideShowWidget extends StatefulWidget {
  final List<Widget> slides;
  final Color dotsColor;
  final bool dotsDown;
  final double dotSize;
  final double dotsPadding;

  const SlideShowWidget({
    Key? key,
    required this.slides,
    this.dotsColor = Colors.pinkAccent,
    this.dotsDown = true,
    this.dotSize = 15.0,
    this.dotsPadding = 30.0
  }) : super(key: key);

  @override
  State<SlideShowWidget> createState() => _SlideShowWidgetState();
}

class _SlideShowWidgetState extends State<SlideShowWidget> {
  final ValueNotifier<int> _slideNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _slideNotifier, 
      builder: (_, slide, __) {
        return Column(
          children: [
            if(!widget.dotsDown)
              _Dots(
                activeSlide: slide,
                slideShowPages: widget.slides.length,
                dotsColor: widget.dotsColor,
                dotSize: widget.dotSize,
                dotsPadding: widget.dotsPadding,
              ),

            /// Aunque no es necesario que se redibuje con el ValueListenableBuilder (solo los dots) no supone un problema
            Expanded(
              child: _Slides(
                slides: widget.slides,
                onSlideChange: (slide) {
                  _slideNotifier.value = slide;
                },
              ),
            ),

            if(widget.dotsDown)
              _Dots(
                activeSlide: slide,
                slideShowPages: widget.slides.length,
                dotsColor: widget.dotsColor,
                dotSize: widget.dotSize,
                dotsPadding: widget.dotsPadding,
              ),
          ],
        );
      }
    );
  }
}

/// Recordar que la ventaja de un StafullWidget esque almacena el estado solo se dispara el build con un cambio
class _Slides extends StatefulWidget {
  final List<Widget> slides;
  final ValueChanged<int> onSlideChange;

  const _Slides({Key? key, required this.slides, required this.onSlideChange}) : super(key: key);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (value) {
        widget.onSlideChange(value);
      },
      itemCount: widget.slides.length,
      itemBuilder: (context, index) {
        /// El padding de los page siempre sobre el elemento, si se coloca sobre el pageview, puede dar errores
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: widget.slides[index]
        );
      },
    );
  }
}

class _Dots extends StatelessWidget {
  final int slideShowPages;
  final int activeSlide;
  final Color dotsColor;
  final double dotSize;
  final double dotsPadding;

  const _Dots({
    Key? key,
    required this.slideShowPages,
    required this.activeSlide,
    required this.dotsColor,
    required this.dotSize,
    required this.dotsPadding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: dotSize + (dotsPadding * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(slideShowPages, (index) {
          final Color color = index == activeSlide ? dotsColor : Colors.grey;
          
          /// Obtenemos la mitad de cada dimension del dot
          final offset = Point(dotSize / 2, dotSize / 2);
          final double scale = index == activeSlide ? 1.25 : 1.0;
          
          /// Con esto aumentamos o reducimos el tamaño del row con lo que quizas no se obtenga el efecto deseado
          // final double size = index == activeSlide ? dotSize : 10.0;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              // height: size,
              // width: size,
              height: dotSize,
              width: dotSize,
              /// Las traslaciones para centrar una transformacion de un animatedContainer los valores
              /// de tralsacion son iguales a la mitad del tamaño del container (en cada eje)
              transform: Matrix4.identity()
              ..translate(offset.x, offset.y)
              ..scale(scale)
              ..translate(-offset.x, -offset.y),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle
              ),
            ),
          );
        }),
      ),
    );
  }
}