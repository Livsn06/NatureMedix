import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class ApplicationButtonStyle {
  static ButtonStyle button1(
      {Size size = const Size(30, 30),
      double borderWidth = 1.0,
      Color backgroundColor = const Color(0x6A683AB7),
      Color borderColor = Colors.deepPurple,
      double radius = 1}) {
    return ButtonStyle(
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
