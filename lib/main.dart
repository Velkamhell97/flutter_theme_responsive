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

  //Como no se necesita renderizar nada podemos setear esta variable global para reemplzar el provider
  int routeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeState>(
      valueListenable: _themeNotifier,
      builder: (_, theme, __) {

        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: theme.data,
          home: Builder(
            builder: (context) {
              final Size size = MediaQuery.of(context).size;
              
              if(size.width > 500) {
                return ThemeProviderTabletHome(
                  themeNotifier: _themeNotifier,
                  routeNotifier: _routeNotifier,
                );
              } else {
                return ThemeProviderHome(
                  themeNotifier: _themeNotifier,
                  routeNotifier: _routeNotifier,
                );
              }
            },
          )
        );
      },
    );
  }
}