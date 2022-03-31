import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/animated_slideshow.dart';

class SlideShowHome extends StatelessWidget {
  const SlideShowHome({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: SafeArea(
        child: landscape ? const _RowSlideShows() : const _ColumnSlideShows(),
      )
    );
  }
}

class _ColumnSlideShows extends StatelessWidget {
  const _ColumnSlideShows({Key? key}) : super(key: key);

  static const _slides = [
    'assets/svg/slide-1.svg',
    'assets/svg/slide-2.svg',
    'assets/svg/slide-3.svg',
    'assets/svg/slide-4.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class _RowSlideShows extends StatelessWidget {
  const _RowSlideShows({Key? key}) : super(key: key);

  static const _slides = [
    'assets/svg/slide-1.svg',
    'assets/svg/slide-2.svg',
    'assets/svg/slide-3.svg',
    'assets/svg/slide-4.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}