import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:naturemedix/utils/custom_styles.dart';
import 'package:naturemedix/utils/directories.dart';

mixin class Application {
  AppName get name => AppName();
  AppLogo get logo => AppLogo();
  AppImage get image => AppImage();
  AppColor get color => AppColor();
  AppStyle get style => AppStyle();
  AppIcon get icon => AppIcon();
  AppGif get gif => AppGif();
  AppPlant get plant => AppPlant();
  AppRemedy get remedy => AppRemedy();
}

class AppName {
  String get first => 'NATUREMEDIX';
}

class AppLogo {
  String get first => AppDirectory.img('Logo.png');
  String get second => AppDirectory.img('Logo1.png');
}

class AppIcon {
  String get GOOGLE => AppDirectory.icon('ICN1.png');
  String get FACEBOOK => AppDirectory.icon('ICN2.png');
  String get TWITTER => AppDirectory.icon('ICN3.png');
}

class AppGif {
  String get valid => AppDirectory.gif('Valid.gif');
  String get invalid => AppDirectory.gif('Invalid.gif');
  String get warning => AppDirectory.gif('Warning.gif');
  String get notFound => AppDirectory.gif('NotFounds.gif');
  String get question => AppDirectory.gif('Question.gif');
}

class AppImage {
  String get BG1 => AppDirectory.img('BG1.png');
  String get BG2 => AppDirectory.img('BG2.png');
  String get BG3 => AppDirectory.img('BG3.png');
  String get BG4 => AppDirectory.img('BG4.png');
  String get BG5 => AppDirectory.img('BG5.png');
  String get BG6 => AppDirectory.img('BG6.png');
  String get BG7 => AppDirectory.img('BG7.png');
}

class AppPlant {
  String get PLNTIMG1 => AppDirectory.plant('PLANT1.png');
  String get PLNTIMG2 => AppDirectory.plant('PLANT2.png');
  String get PLNTIMG3 => AppDirectory.plant('PLANT3.png');
  String get PLNTIMG4 => AppDirectory.plant('PLANT4.png');
  String get PLNTIMG5 => AppDirectory.plant('PLANT5.png');
  String get PLNTIMG6 => AppDirectory.plant('PLANT6.png');
  String get PLNTIMG7 => AppDirectory.plant('PLANT7.png');
}

class AppRemedy {
  String get PLNTRMDY1 => AppDirectory.remedy('RMDY1.png');
  String get PLNTRMDY2 => AppDirectory.remedy('RMDY2.png');
  String get PLNTRMDY3 => AppDirectory.remedy('RMDY3.png');
  String get PLNTRMDY4 => AppDirectory.remedy('RMDY4.png');
  String get PLNTRMDY5 => AppDirectory.remedy('RMDY5.png');
  String get PLNTRMDY6 => AppDirectory.remedy('RMDY6.png');
}

class AppColor {
  Color get darkGrey => const Color(0xFF808080);
  Color get grey => const Color(0xFFEBEBEB);
  Color get lightGrey => const Color(0xFFD9D9D9);
  Color get background => const Color(0xFFF2F7FA);
  Color get primary => const Color(0xFF008263);
  Color get primaryhigh => const Color(0xFF2F604B);
  Color get primarylow => const Color(0xff50727B);
  Color get secondary => const Color(0xFF9C7300);
  Color get invalid => const Color(0xFFFF8F91);
  Color get valid => const Color(0xFF99E661);
  Color get question => const Color(0xFF78B7D0);
  Color get warning => const Color(0xFFFFBF00);
  Color get white => const Color(0xFFF5F5F5);
  Color get whiteOpacity20 => const Color(0xFFFFFFFF).withOpacity(0.2);
  Color get whiteOpacity40 => const Color(0xFFFFFFFF).withOpacity(0.4);
  Color get dark => const Color(0xFF2B2A29);
  Color get darkOpacity70 => const Color(0xFF000000).withOpacity(0.6);
  Color get darkOpacity50 => const Color(0xFF000000).withOpacity(0.5);
}

class AppStyle with CustomTextStyle, CustomButtonStyle {}
