import 'package:flutter/material.dart';

import '../routes/routes.dart';
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

  static const _routes = ThemeRoute.routes;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = themeNotifier.value.data.colorScheme.secondary;

    final Size size = MediaQuery.of(context).size;

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    /// Como solo es un Drawer este no se cerrara al cambiar de orientacion
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseños en flutter'),
        centerTitle: true,
        elevation: 3.0,
      ),
      drawer: AppDrawer(
        headerHeight: size.height * 0.15,
        navigate: !landscape,
        themeNotifier: themeNotifier,
        routeNotifier: routeNotifier,
      ),
      body: Row(
        children: [
          SizedBox(
            width: landscape ? 300 : size.width,
            child: RoutesList(
              navigate: !landscape,
              themeNotifier: themeNotifier,
              routeNotifier: routeNotifier,
            ),
          ),
          if(landscape)
            VerticalDivider(
              // thickness: 1,
              color: backgroundColor,
              width: 2,
            ),
          if(landscape)
            Expanded(
              /// Este es el unico lugar que utiliza este notifier
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

