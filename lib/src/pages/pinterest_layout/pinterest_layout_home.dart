import 'package:flutter/material.dart';

import 'widgets/pinterest_menu.dart';

class PinterestLayoutHome extends StatefulWidget {
  const PinterestLayoutHome({Key? key}) : super(key: key);

  @override
  _PinterestLayoutHomeState createState() => _PinterestLayoutHomeState();
}

class _PinterestLayoutHomeState extends State<PinterestLayoutHome> {

  static const _icons = [
    Icons.pie_chart,
    Icons.search,
    Icons.notifications,
    Icons.supervised_user_circle
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PinterestMenu(
        buttons: [
          PinterestButton(icon: _icons[0], onPressed: (index) => print('Button $index')),
          PinterestButton(icon: _icons[1],),
          PinterestButton(icon: _icons[2], onPressed: (index) => print('Button $index')),
          PinterestButton(icon: _icons[3],),
        ],
        activeColor: Colors.indigo,
        // inactiveColor: Colors.grey,
      ),
    );
  }
}

