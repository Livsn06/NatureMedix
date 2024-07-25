import 'package:flutter/material.dart';

import '../themes/color_styles.dart';



class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightmode;

  void toggleTheme() {
    if (_themeData == lightmode) {
      _themeData = darkmode;
    }
  }

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
