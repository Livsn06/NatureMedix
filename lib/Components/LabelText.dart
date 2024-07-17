import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelText extends StatelessWidget {
  LabelText(
      {super.key,
      required this.label,
      this.fontSize,
      this.fontColor,
      this.letterSpace,
      this.lineHeight,
      this.fontWeight,
      this.textAlign});

  TextAlign? textAlign;
  double? fontSize, letterSpace, lineHeight;
  FontWeight? fontWeight;
  String? label;
  Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      label!,
      textAlign: textAlign,
      style: GoogleFonts.roboto(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
        height: lineHeight,
        letterSpacing: letterSpace,
      ),
    );
  }
}
