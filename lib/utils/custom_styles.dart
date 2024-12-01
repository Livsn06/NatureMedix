import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naturemedix/utils/responsive.dart';

mixin class CustomTextStyle {
  TextStyle displayLarge(BuildContext context,
      {Color color = const Color(0xFF18988B),
      double? fontspace,
      double? fontsize = 26}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w700,
        height: 1.3,
        fontSize: fontsize,
        letterSpacing: fontspace,
      ),
    );
  }

  TextStyle displayMedium(BuildContext context,
      {Color color = const Color(0xFF18988B),
      double? fontspace,
      double? fontsize}) {
    return GoogleFonts.montserratAlternates(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        height: 1.3,
        fontSize: fontsize,
        letterSpacing: fontspace,
      ),
    );
  }

  TextStyle smallText(
    BuildContext context, {
    Color color = const Color(0xFF18988B),
    double? fontspace,
    double? fontsize,
    FontWeight? fontweight,
  }) {
    return GoogleFonts.openSans(
      textStyle: TextStyle(
        color: color,
        fontWeight: fontweight,
        height: 1.3,
        fontSize: fontsize,
        letterSpacing: fontspace,
      ),
    );
  }

  TextStyle mediumText(
    BuildContext context, {
    Color color = const Color(0xFF18988B),
    double? fontspace,
    double? fontsize,
    FontWeight? fontweight,
  }) {
    return GoogleFonts.ubuntu(
      textStyle: TextStyle(
        color: color,
        fontWeight: fontweight,
        height: 1.3,
        fontSize: fontsize,
        letterSpacing: fontspace,
      ),
    );
  }

  TextStyle displaySmall(BuildContext context,
      {Color color = const Color(0xFF18988B),
      double? fontspace,
      double? fontsize,
      FontWeight? fontweight,
      double? height = 1.3,
      FontStyle? fontstyle = FontStyle.normal}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontStyle: fontstyle,
        color: color,
        fontWeight: fontweight,
        height: height,
        fontSize: fontsize,
        letterSpacing: fontspace,
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

  TextStyle TitleMedium(BuildContext context,
      {Color color = Colors.black, double? fontsize = 17}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        height: 1.5,
        fontSize: fontsize,
      ),
    );
  }

  TextStyle buttonText(
    BuildContext context, {
    Color color = Colors.black,
    double? fontsize = 15,
    double? fontspace,
  }) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        letterSpacing: fontspace,
        height: 1.5,
        fontSize: fontsize,
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

mixin class AlertDisplay {
  void alertDisplay(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(setResponsiveSize(context, baseSize: 10))),
          ),
          titlePadding:
              EdgeInsets.all(setResponsiveSize(context, baseSize: 16)),
          contentPadding: EdgeInsets.symmetric(
            horizontal: setResponsiveSize(context, baseSize: 16),
            vertical: setResponsiveSize(context, baseSize: 16),
          ),
          backgroundColor: Colors.white,
          title: const Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.check_circle,
              size: 48,
              color: Colors.green,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(text),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: setResponsiveSize(context, baseSize: 16),
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
