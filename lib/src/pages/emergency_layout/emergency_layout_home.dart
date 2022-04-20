import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'models/emergency_tile_model.dart';
import 'widgets/emergency_card.dart';

class EmrgencyLayoutHome extends StatelessWidget {
  const EmrgencyLayoutHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final headerHeight = size.height * 0.25;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _EmergencyList(
              headerHeight: headerHeight,
            ) 
          ),
          Positioned.fill(
            bottom: null,
            child: _EmergencyAppBar(
              title: 'Haz Solicitado',
              subtitle: 'Asistencia medica',
              height: headerHeight,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmergencyAppBar extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final double height;
  final List<Color> backgroundColor;
  final Color foregroundColor;

  const _EmergencyAppBar({
    Key? key,
    this.height = kToolbarHeight,
    required this.title,
    required this.subtitle,
    this.icon = FontAwesomeIcons.plus,
    this.iconColor = Colors.white,
    this.backgroundColor = const [Color(0xFF526BF6), Color(0xFF67ACF2)],
    this.foregroundColor = Colors.white
  }) : super(key: key);

  static const _iconSize = 24.0;

  @override
  Widget build(BuildContext context) {
    /// utilizamos para quitar el icono del AppBar
    final lanscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final MediaQueryData mq = MediaQuery.of(context);

    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80.0)),
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: backgroundColor
                  )
                ),
              ),
            ),
            Positioned(
              top: -_iconSize,
              left: -_iconSize,
              child: FaIcon(icon, size: _iconSize * 6, color: iconColor.withOpacity(0.2)),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: mq.padding.top),
                  Text(title, style: TextStyle(color: foregroundColor, fontSize: 18)),
                  const SizedBox(height:5),
                  Text(subtitle, style: TextStyle(color: foregroundColor, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  if(!lanscape)
                    FaIcon(icon, size: _iconSize * 2.5, color: iconColor),
                  ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _EmergencyList extends StatelessWidget {
  final double headerHeight;

  const _EmergencyList({Key? key, this.headerHeight = kToolbarHeight}) : super(key: key);

  static const _tiles = EmergencyTileModel.tiles;
  static const _tileGap= 20.0;

  /// Aqui no hay cambios con el cambio de orientacion
  @override
  Widget build(BuildContext context) {
    /// Se debe usar un builder para el efecto de las animaciones
    return ListView.builder(
      itemExtent: 120,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.0, headerHeight + 20.0, 20.0, 0.0),
      itemCount: _tiles.length * 4,
      itemBuilder: (context, index) {
        final tile = _tiles[index % _tiles.length];
    
        return Padding(
          padding: const EdgeInsets.only(bottom: _tileGap),
          /// A medida que van entrando se van renderizando y animando, recordar usar el child para optimizar
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: -1, end: 0),
            duration: kThemeAnimationDuration,
            builder: (_, value, child) {
              return Opacity(
                opacity: 1 - value.abs(),
                child: FractionalTranslation(
                  translation: Offset(value, 0.0),
                  child: child,
                ),
              );
            },
            /// Las clases no deben contener los metodos onTap o funciones, esto debe tenerlo el widget
            /// aqui tenemos disponible el index de cada card por si se necesita
            child: EmergencyCard(
              tile: tile,
              onTap: () {},
            ),
          ),
        );
      },
    );
  }
}

