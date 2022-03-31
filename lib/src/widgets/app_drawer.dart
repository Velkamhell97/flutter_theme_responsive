import 'package:flutter/material.dart';

import '../theme/theme_notifier.dart';
import 'routes_list.dart';

class AppDrawer extends StatelessWidget {
  final ThemeNotifier themeNotifier;
  final ValueNotifier<int> routeNotifier;
  final double? headerHeight;
  final bool navigate;

  const AppDrawer({
    Key? key, 
    required this.themeNotifier, 
    required this.routeNotifier,
    this.headerHeight, 
    this.navigate = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secondaryColor = themeNotifier.value.data.colorScheme.secondary;

    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: headerHeight,
            child: DrawerHeader(
              child: FittedBox(
                child: CircleAvatar(
                  backgroundColor: secondaryColor,
                  child: const Text('DV'),
                ),
              ),
            ),
          ),
          Expanded(
            child: RoutesList(
              navigate: navigate,
              themeNotifier: themeNotifier,
              routeNotifier: routeNotifier,
            ),
          ),
          const Divider(
            color: Colors.grey,
            // thickness: 0.5,
          ),
          ValueListenableBuilder<ThemeState>(
            valueListenable: themeNotifier, 
            builder: (_, theme, __) {
              return Column(
                children: [
                  SwitchListTile.adaptive(
                    secondary: Icon(Icons.lightbulb_outline, color: secondaryColor),
                    value: theme is DarkThemeState,
                    activeColor: secondaryColor, 
                    title: const Text('Dark Mode'),
                    onChanged: (value) {
                      themeNotifier.value = value ? DarkThemeState() : LightThemeState();
                    },
                  ),
                  SwitchListTile.adaptive(
                    secondary: Icon(Icons.add_to_home_screen, color: secondaryColor),
                    value: theme is CustomThemeState, 
                    activeColor: secondaryColor,
                    title: const Text('Custom Theme'),
                    onChanged: (value) {
                      themeNotifier.value = value ? CustomThemeState() : LightThemeState();
                    },
                  )
                ],
              );
            }
          )
        ],
      ),
    );
  }
}



