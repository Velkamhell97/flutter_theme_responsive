import 'package:flutter/material.dart';

import 'src/theme/theme_notifier.dart';
import 'src/pages/theme_provider_home.dart';
import 'src/pages/theme_provider_tablet_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final ThemeNotifier _themeNotifier = ThemeNotifier();
  final ValueNotifier<int> _routeNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    /// Los ValueListenableBuilder pueden escuchar el mismo ValueNotifier
    return ValueListenableBuilder<ThemeState>(
      valueListenable: _themeNotifier,
      builder: (_, theme, __) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: theme.data,
          home: Builder( 
            builder: (context) {
              final landscape = MediaQuery.of(context).orientation == Orientation.landscape;
              
              return landscape ? ThemeProviderTabletHome(
                themeNotifier: _themeNotifier,
                routeNotifier: _routeNotifier,
              ) : ThemeProviderHome(
                themeNotifier: _themeNotifier,
                routeNotifier: _routeNotifier,
              );
            },
          )
        );
      },
    );
  }
}