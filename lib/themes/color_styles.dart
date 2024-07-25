import 'package:flutter/material.dart';

class AppColor {
  static AppColor style = AppColor();
  Color white = const Color(0xFFF5F5F5);
  Color primary = const Color(0xFF008263);
  Color secondary = const Color(0xFF9C7300);
  Color error = const Color(0xFFE62300);
  Color correct = const Color(0xFF17E900);
  Color warning = const Color(0xFFFFBF00);
  Color dark = const Color(0xFF101720);
  Color whiteOpacity20 = const Color(0xFFFFFFFF).withOpacity(0.2);
  Color darkOpacity70 = Color(0xFF000000).withOpacity(0.7);
}

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: AppColor.style.white,
    primary: AppColor.style.white,
    secondary: AppColor.style.secondary,
    surface: AppColor.style.white,
  ),
);

ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: AppColor.style.dark,
    primary: AppColor.style.primary,
    secondary: AppColor.style.secondary,
    surface: AppColor.style.dark,
  ),
);
