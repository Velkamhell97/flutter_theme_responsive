import 'package:flutter/material.dart';

class ThemeNotifier extends ValueNotifier<ThemeState> {
  ThemeNotifier([ThemeState? value]) : super(value ?? CustomThemeState());
}

abstract class ThemeState {
  final ThemeMode? mode;

  int routeIndex = 0;
  ThemeData data = ThemeData.light();

  static const _secondaryColor = Color(0XFF48A0EB);
  static const _primaryColor = Colors.grey;
  static const _scaffoldColor = Color(0xFF16202B);
  static const _drawerColor = Color(0xFF16202B);

  ThemeState({this.mode}){
    if(mode == null){
      data = ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: _primaryColor,
            secondary: _secondaryColor,
          ),
          // primaryColor: Colors.grey,
          scaffoldBackgroundColor: _scaffoldColor,
          drawerTheme: const DrawerThemeData(
            backgroundColor: _drawerColor,
          ),
        );
    } else if(mode == ThemeMode.light){
      data = ThemeData.light();
    } else if(mode == ThemeMode.dark){
      data = ThemeData.dark();
    }
  }
    
}

class CustomThemeState extends ThemeState {
  CustomThemeState() : super();
}

class LightThemeState extends ThemeState {
  LightThemeState() : super(mode: ThemeMode.light);
}

class DarkThemeState extends ThemeState {
  DarkThemeState() : super(mode: ThemeMode.dark);
}