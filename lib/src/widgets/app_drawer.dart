import 'package:flutter/material.dart';

import '../theme/theme_notifier.dart';
import 'routes_list.dart';

class AppDrawer extends StatelessWidget {
  final ThemeNotifier themeNotifier;
  final ValueNotifier<int> routeNotifier;
  final double headerHeight;
  final bool navigate;

  const AppDrawer({
    Key? key, 
    required this.themeNotifier, 
    required this.routeNotifier,
    required this.headerHeight, 
    this.navigate = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Por alguna razon esto hace que se renderice mas veces como un listen en true
    //final backgroundColor = Theme.of(context).colorScheme.secondary;

    /// Con esto no sucede lo de arriba, se lee el valor directamente del notifier
    final secondaryColor = themeNotifier.value.data.colorScheme.secondary;

    /// Si se tiene el drawer abierto y se cambia de orientacion este se cierra, (no es un problema)
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: SizedBox(
              width: double.infinity,
              height:  headerHeight,
                child: FittedBox(
                  alignment: navigate ? Alignment.center : Alignment.centerLeft,
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
            /// No necesitamos otro ValueListenableBuilder ya que al cambiar tema se renderiza el mateApp
            /// por lo que podemos usar su value, ya que el rebuild se hara desde arriba
            Column(
              children: [
                SwitchListTile.adaptive(
                  secondary: Icon(Icons.lightbulb_outline, color: secondaryColor),
                  value: themeNotifier.value is DarkThemeState,
                  activeColor: secondaryColor, 
                  title: const Text('Dark Mode'),
                  /// Al cambiar le value creamos una nueva instancia del ThemeState con el data correspondiente
                  /// y como cambia el state se redispara el ValueNotifier redibujando con el nuevo tema
                  onChanged: (value) {
                    themeNotifier.value = value ? DarkThemeState() : LightThemeState();
                  },
                ),
                SwitchListTile.adaptive(
                  secondary: Icon(Icons.add_to_home_screen, color: secondaryColor),
                  value: themeNotifier.value is CustomThemeState, 
                  activeColor: secondaryColor,
                  title: const Text('Custom Theme'),
                  onChanged: (value) {
                    themeNotifier.value = value ? CustomThemeState() : LightThemeState();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}



