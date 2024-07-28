import 'package:flutter/material.dart';
import 'package:naturemedix/utils/custom_styles.dart';
import 'package:naturemedix/utils/directories.dart';

mixin class Application {
  AppName get name => AppName();
  AppLogo get logo => AppLogo();
  AppImage get image => AppImage();
  AppColor get color => AppColor();
  AppStyle get style => AppStyle();
}

class AppName {
  String get first => 'NATUREMEDIX';
}

class AppLogo {
  String get first => AppDirectory.dir('LOGO.png');
}

class AppImage {
  String get BG1 => AppDirectory.dir('BG1.png');
  String get BG2 => AppDirectory.dir('BG2.png');
  String get BG3 => AppDirectory.dir('BG3.png');
  String get BG4 => AppDirectory.dir('BG4.png');
}

class AppColor {
  Color get primary => const Color(0xFF008263);
  Color get secondary => const Color(0xFF9C7300);
  Color get error => const Color(0xFFE62300);
  Color get correct => const Color(0xFF17E900);
  Color get warning => const Color(0xFFFFBF00);
  Color get white => const Color(0xFFF5F5F5);
  Color get whiteOpacity20 => const Color(0xFFFFFFFF).withOpacity(0.2);
  Color get whiteOpacity40 => const Color(0xFFFFFFFF).withOpacity(0.4);
  Color get dark => const Color(0xFF101720);
  Color get darkOpacity70 => const Color(0xFF000000).withOpacity(0.6);
  Color get darkOpacity50 => const Color(0xFF000000).withOpacity(0.5);
}

class AppStyle with CustomTextStyle, CustomButtonStyle {}
