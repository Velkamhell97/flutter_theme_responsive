import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmergencyTileModel {
  final IconData icon;
  final String title;
  final List<Color> backgroundColor;

  const EmergencyTileModel({
    required this.icon,
    required this.title,
    required this.backgroundColor
  });

  static const List<EmergencyTileModel> tiles = [
    EmergencyTileModel(
      icon: FontAwesomeIcons.carBurst,
      title: 'Motor Accident',
      backgroundColor: [Color(0xff6989F5), Color(0xff906EF5)]
    ),
    EmergencyTileModel(
      icon: FontAwesomeIcons.stethoscope,
      title: 'Medical Emergency',
      backgroundColor: [Color(0xff66A9F2), Color(0xff536CF6)]
    ),
    EmergencyTileModel(
      icon: FontAwesomeIcons.masksTheater,
      title: 'Theft / Harrasement',
      backgroundColor: [Color(0xffF2D572), Color(0xffE06AA3)]
    ),
    EmergencyTileModel(
      icon: FontAwesomeIcons.personBiking,
      title: 'Awards',
      backgroundColor: [Color(0xff317183), Color(0xff46997D)]
    ),
  ];
}