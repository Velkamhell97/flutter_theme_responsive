import 'package:flutter/material.dart';

import '../routes/routes.dart';
import '../theme/theme_notifier.dart';
import '../widgets/app_drawer.dart';
import '../widgets/routes_list.dart';

class ThemeProviderTabletHome extends StatelessWidget {
  final ThemeNotifier themeNotifier;
  final ValueNotifier<int> routeNotifier;

  const ThemeProviderTabletHome({
    Key? key, 
    required this.themeNotifier,
    required this.routeNotifier
  }) : super(key: key);

  static const _routes = ThemeRoute.routes;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Diseños en flutter tablet'),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: AppDrawer(
        themeNotifier: themeNotifier,
        headerHeight: 120,
        navigate: false,
        routeNotifier: routeNotifier,
      ),
      body: Row(
        children: [
          SizedBox(
            width: 300,
            child: RoutesList(
              navigate: false, 
              themeNotifier: themeNotifier,
              routeNotifier: routeNotifier,
            ),
          ),
          Container(
            color: backgroundColor,
            width: 2,
            height: double.infinity,
          ),
          Expanded(
            flex: 5,
            child: ValueListenableBuilder<int>(
              valueListenable: routeNotifier,
              builder: (_, routeIndex, __) {
                return _routes[routeIndex].page;
              },
            )
          )
        ],
      )
    );
  }
}
