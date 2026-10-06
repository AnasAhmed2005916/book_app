import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this.preferences) : super(_getInitialTheme(preferences));

  final SharedPreferences preferences;

  static const String themeKey = 'theme';

  static ThemeMode _getInitialTheme(SharedPreferences preferences) {
    final savedTheme = preferences.getString(themeKey);

    if (savedTheme == 'dark') {
      return ThemeMode.dark;
    }

    if (savedTheme == 'light') {
      return ThemeMode.light;
    }

    return ThemeMode.system;
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    emit(themeMode);

    await preferences.setString(themeKey, themeMode.name);
  }
}
