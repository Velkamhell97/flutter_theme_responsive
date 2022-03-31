import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/routes_list.dart';
import '../theme/theme_notifier.dart';

class ThemeProviderHome extends StatelessWidget {
  final ThemeNotifier themeNotifier;
  final ValueNotifier<int> routeNotifier;

  const ThemeProviderHome({
    Key? key, 
    required this.themeNotifier,
    required this.routeNotifier
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //-Por alguna razon esto hace que se renderice mas veces como un listen en true
    // final backgroundColor = Theme.of(context).colorScheme.secondary;
    final backgroundColor = themeNotifier.value.data.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Diseños en flutter'),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: AppDrawer(
        themeNotifier: themeNotifier,
        routeNotifier: routeNotifier,
      ),
      body: RoutesList(
        themeNotifier: themeNotifier,
        routeNotifier: routeNotifier,

      )
    );
  }
}

