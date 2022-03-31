import 'package:flutter/material.dart';

import 'pages.dart';

class AnimateDoHome extends StatelessWidget {
  const AnimateDoHome({Key? key}) : super(key: key);

  static const Map<String, Widget> _pages = {
    'Multi Animation'   : MultiAnimationPage(),
    'Twitter Animation' : TwitterIntroPage(),
    'Animated Badge'    : AnimatedBadgePage(),
  };

  void _navigate(BuildContext context, Widget child) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: landscape ? null : AppBar(
        title: const Text('Animate Do Home'),
      ),
      body: ListView.builder(
        itemCount: _pages.length,
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        itemBuilder: (context, index) {
          final entry = _pages.entries.elementAt(index);

          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ListTile(
              onTap: () => _navigate(context, entry.value),
              title: Text(entry.key, style: const TextStyle(color: Colors.white)),
              tileColor: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}