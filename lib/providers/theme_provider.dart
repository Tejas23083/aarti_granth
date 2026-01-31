import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  // ☀️ LIGHT
  void setLightMode() {
    _themeMode = ThemeMode.light;
    notifyListeners();
  }

  // 🌙 DARK
  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  // 📱 SYSTEM
  void setSystemMode() {
    _themeMode = ThemeMode.system;
    notifyListeners();
  }

  // 🔁 USED BY SWITCH (THIS FIXES YOUR ERROR)
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
