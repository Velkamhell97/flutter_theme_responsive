import 'package:flutter/material.dart';

/// Un custom notifier que almacena una union clase como freezed, recibe un valor inicial y si no viene setea uno
class ThemeNotifier extends ValueNotifier<ThemeState> {
  ThemeNotifier([ThemeState? value]) : super(value ?? CustomThemeState());
}

/// Aqui todas las clases que implementen esta clase base tendran las propiedades definidas aqui, lo unico que cambia
/// Esque devuelven una instancia de esta clase con un tema diferente, diferentes argumentos en el constructor
/// Tener en cuenta que hay muchas maneras de conseguir el mismo resultado
abstract class ThemeState {
  final ThemeMode? mode;

  int routeIndex = 0;

  /// Inicialmente el light pero se cambia en el constructor
  ThemeData data = ThemeData.light();

  static const _secondaryColor = Color(0XFF48A0EB);
  static const _primaryColor = Colors.grey;
  static const _scaffoldColor = Color(0xFF16202B);
  static const _drawerColor = Color(0xFF16202B);

  ThemeState({this.mode}){
    if(mode == null){
      data = ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: _scaffoldColor
        ),
        colorScheme: const ColorScheme.dark(
          primary: _primaryColor,
          secondary: _secondaryColor,
        ),
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

/// Clases que extienden del tema principal teniendo sus propiedades inicializadas en el constructor
class CustomThemeState extends ThemeState {
  CustomThemeState() : super();
}

class LightThemeState extends ThemeState {
  LightThemeState() : super(mode: ThemeMode.light);
}

class DarkThemeState extends ThemeState {
  DarkThemeState() : super(mode: ThemeMode.dark);
}