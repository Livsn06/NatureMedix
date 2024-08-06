import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naturemedix/utils/responsive.dart';

mixin class CustomTextStyle {
  TextStyle displayLarge(BuildContext context,
      {Color color = const Color(0xFF18988B)}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w800,
        height: 1.3,
        fontSize: setResponsiveSize(context, baseSize: 30),
      ),
    );
  }

  TextStyle headlineLarge(BuildContext context,
      {Color color = const Color(0xFF18988B)}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        fontSize: setResponsiveSize(context, baseSize: 16),
      ),
    );
  }

  TextStyle TitleMedium(BuildContext context, {Color color = Colors.black}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.5,
        fontSize: setResponsiveSize(context, baseSize: 16),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  TextStyle TitleLarge(BuildContext context, {Color color = Colors.black}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
        fontSize: setResponsiveSize(context, baseSize: 18),
      ),
    );
  }
}

mixin class CustomButtonStyle {
  ButtonStyle button1({
    Size size = const Size(30, 30),
    double borderWidth = 1.0,
    Color backgroundColor = const Color(0x6A683AB7),
    Color borderColor = Colors.deepPurple,
    double radius = 1,
    Color overlayColor = Colors.white38,
  }) {
    return ButtonStyle(
      overlayColor: MaterialStatePropertyAll(overlayColor),
      fixedSize: MaterialStatePropertyAll(size),
      backgroundColor: MaterialStatePropertyAll(backgroundColor),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
      ),
    );
  }
}
