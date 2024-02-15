// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:habit_tracker/utils/theme/dark_mode.dart';
import 'package:habit_tracker/utils/theme/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  //Get current theme
  ThemeData get themeData => _themeData;

  //Start with lightMode
  ThemeData _themeData = darkMode;

  // Change theme
  changeTheme(ThemeData theme) async {
    _themeData = theme;

    if (theme == darkMode) {
      final prefs = await SharedPreferences.getInstance();
      bool isDarkMode = await prefs.setBool('isDarkMode', true);
    } else {
      final prefs = await SharedPreferences.getInstance();
      bool isDarkMode = await prefs.setBool('isDarkMode', false);
    }

    notifyListeners();
  }

  loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? true;

    if (isDarkMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
  }
}
