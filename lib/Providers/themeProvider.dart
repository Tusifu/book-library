import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void setIsDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
