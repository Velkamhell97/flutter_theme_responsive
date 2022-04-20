import 'package:flutter/material.dart';

import 'widgets/custom_sliver_header.dart';

class ColorsSliverListHome extends StatelessWidget {
  const ColorsSliverListHome({Key? key}) : super(key: key);

  static const Map<String, String> _titles = {
    'The Legend Of Zelda'          : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/d/db/TLoZ_Tile.png',
    'The Adventure Of Link'        : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/0/09/TAoL_Tile.png',
    'A Link To The Past'           : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/6/69/ALttP_Tile.png',
    'Link\'s Awaeking'             : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/3/38/LA_Tile.png',
    'Ocarina Of Time'              : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/2/2b/OoT_Tile.png',
    'Majora Maks'                  : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/7/7b/MM_Tile.png',
    'Oracle Of Seasons'            : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/c/c1/OoS_Tile.png',
    'Oracle Of Ages'               : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/5/56/OoA_Tile.png',
    'Four Swords'                  : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/9/90/FS_Tile.png',
    'The Wind Waker'               : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/7/7f/TWW_Tile.png',
    'Four Swords Adventures'       : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/0/0d/FSA_Tile.png',
    'The Minish Cap'               : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/d/d4/TMC_Tile.png',
    'Twilight Princess'            : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/3/3e/TP_Tile.png',
    'Phantom Hourglass'            : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/a/a5/PH_Tile.png',
    'Spirit Tracks'                : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/5/5e/ST_Tile.png',
    'Skyward Sword'                : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/4/45/SS_Tile.png',
    'A Link Between Worlds'        : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/2/29/ALBW_Tile.png',
    'Tri Force Heroes'             : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/e/ec/TFH_Tile.png',
    'Breath Of The Wild'           : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/7/7c/BotW_Tile.png',
    'Sequel To Breath Of The Wild' : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/3/37/StBotW_Tile.png',
  };

  static const _tileGap = 20.0;
  static const _buttonHeight = 55.0;
  static const _itemHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// El problema del appbar esque el al terminar de comprimirse siempre termina en un appbar normal
              // SliverAppBar(
              //   backgroundColor: Colors.transparent,
              //   expandedHeight: 200,
              //   flexibleSpace: FlexibleSpaceBar(
              //     background: Image.network(
              //       'https://as01.epimg.net/meristation/imagenes/2021/02/21/reportajes/1613888485_682494_1613888565_noticia_normal.jpg',
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              const SliverPersistentHeader(
                /// Con esta opcion el appbar aparece cuando se hace scroll hacia arriba
                floating: true,
                /// Con esta se mantiene en todo momento en su minHeight
                pinned: true,
                delegate: CustomSliverHeader(
                  maxHeight: 200,
                  minHeight: kToolbarHeight
                )
              ),
              SliverPadding(
                /// El height del bottom es para que el boton de la esquina no quede por encima de el ultimo item
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, _buttonHeight),
                sliver: SliverFixedExtentList(
                  itemExtent: _itemHeight + _tileGap,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final entry = _titles.entries.elementAt(index);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: _tileGap),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              image: NetworkImage(entry.value),
                              fit: BoxFit.fill,
                              colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken)
                            )
                          ),
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              color: Colors.white, 
                              fontSize: 17, 
                              fontWeight: FontWeight.bold,
                              shadows: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ]
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: _titles.length
                  ), 
                ),
              )
            ],
          ),
          Positioned.fill(
            top: null,
            child: FractionallySizedBox(
              alignment: Alignment.centerRight,
              widthFactor: 0.9,
              child: Material(
                color: Colors.redAccent,
                clipBehavior: Clip.antiAlias,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(50.0)),
                child: InkWell(
                  onTap: () {},
                  child: const SizedBox(
                    height: _buttonHeight,
                    child: Center(
                      child: Text(
                        'CREATE NEW LIST',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
