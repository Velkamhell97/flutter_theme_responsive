import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/pages.dart';

class ThemeRoute {
  final IconData icon;
  final String title;
  final Widget page;

  const ThemeRoute(this.icon, this.title, this.page);

  static const routes = [
    ThemeRoute(
      FontAwesomeIcons.paintbrush, 
      'Backgrounds App', 
      BackgroundsHome()
    ),
    ThemeRoute(
      FontAwesomeIcons.square, 
      'Basic Animations App', 
      BasicAnimationsHome()
    ),
    ThemeRoute(
      FontAwesomeIcons.spinner, 
      'Circular Progress App', 
      CircularProgressHome()
    ),
     ThemeRoute(
      FontAwesomeIcons.slideshare, 
      'SlideShow App', 
      SlideShowHome()
    ),
    ThemeRoute(
      FontAwesomeIcons.pinterest, 
      'Pinterst Layout', 
      PinterestLayoutHome()
    ),
    ThemeRoute(
      FontAwesomeIcons.truckMedical, 
      'Emergency Layout', 
      EmrgencyLayoutHome()
    ),
    ThemeRoute(
      FontAwesomeIcons.list, 
      'Sliver Layout', 
      ColorsSliverListHome()
    ),
    ThemeRoute(
      FontAwesomeIcons.play, 
      'Animate Do App', 
      AnimateDoHome()
    ),
  ];
}