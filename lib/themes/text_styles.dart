import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/responsive.dart';

class ApplicationTextStyle {
  static TextStyle displayLarge(
      {BuildContext? context, Color color = Colors.black}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
        height: 1.3,
        fontSize: getResponsiveFontSize(context: context, baseSize: 57),
      ),
    );
  }

  static TextStyle headlineLarge(
      {BuildContext? context, Color color = Colors.black}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.6,
        height: 1.3,
        fontSize: getResponsiveFontSize(context: context, baseSize: 32),
      ),
    );
  }

  static TextStyle TitleMedium(
      {BuildContext? context, Color color = Colors.black}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        height: 1.5,
        fontSize: getResponsiveFontSize(context: context, baseSize: 16),
      ),
    );
  }
}
