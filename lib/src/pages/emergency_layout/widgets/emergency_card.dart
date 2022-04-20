import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/emergency_tile_model.dart';

class EmergencyCard extends StatelessWidget {
  final EmergencyTileModel tile;
  final VoidCallback? onTap;

  const EmergencyCard({Key? key, required this.tile, this.onTap}) : super(key: key);

  static const _iconSize1 = 90.0;
  static const _iconSize2 = 40.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[4],
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(colors: tile.backgroundColor)
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {},
          child: Stack(
            children: [
              Positioned(
                right: -(_iconSize1 * 0.2),
                child: FaIcon(tile.icon, size: _iconSize1, color: Colors.white30),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      FaIcon(tile.icon, color: Colors.white, size: _iconSize2),
                      const SizedBox(width: 20.0),
                      Expanded(child: Text(tile.title, style: const TextStyle(color: Colors.white, fontSize: 18))),
                      const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white, size: 20)
                    ],
                  ),
                ),
              )
            ]
          )
        )
      )
    );
  }
}