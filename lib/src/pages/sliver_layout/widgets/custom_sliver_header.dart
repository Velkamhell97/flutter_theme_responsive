import 'package:flutter/material.dart';
import 'dart:ui';

class CustomSliverHeader extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;

  const CustomSliverHeader({
    required this.minHeight,
    required this.maxHeight
  });

  static const _zeldaBackground = 'https://as01.epimg.net/meristation/imagenes/2021/02/21/reportajes/1613888485_682494_1613888565_noticia_normal.jpg';
  static const _zeldaTitle = 'https://res.cloudinary.com/dwzr9lray/image/upload/v1641759406/zaskk9w4d8k3xes2enkq.png';

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    /// Formula para porcentaje
    final double value = (1 - (shrinkOffset / (maxHeight - minHeight))).clamp(0.0, 1.0);

    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_zeldaBackground),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)
        ),
      ), 
      child: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            /// El positioned se mantiene la posicion con los cambios del appbar, con el algin se mueve con este
            Align(
            alignment: const Alignment(0.0, 0.5),
              child: SizedBox(
                /// Al parecer el width es el que mantiene la relacion de aspecto, modificando este se modifica
                /// el height tambien
                width: lerpDouble(200, 50, 1 - value),
                child: Image.network(_zeldaTitle),  
              ),
            )
          ],
        ),
      )
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(CustomSliverHeader oldDelegate) {
    return minHeight != oldDelegate.minHeight || maxHeight != oldDelegate.maxHeight;
  }

}