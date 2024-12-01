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
  String get reset => AppDirectory.icon('ICN4.png');
  String get noImage => AppDirectory.icon('ICN5.png');
  String get privacy => AppDirectory.icon('ICN6.png');
  String get FAQs => AppDirectory.icon('ICN7.png');
}

class AppGif {
  String get valid => AppDirectory.gif('Valid.gif');
  String get invalid => AppDirectory.gif('Invalid.gif');
  String get warning => AppDirectory.gif('Warning.gif');
  String get notFound => AppDirectory.gif('NotFounds.gif');
  String get question => AppDirectory.gif('Question.gif');
  String get loading => AppDirectory.gif('loading.gif');
  String get rating => AppDirectory.gif('rating.gif');
  String get removed => AppDirectory.gif('removed.gif');
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
  String get PLNTIMG8 => AppDirectory.plant('PLANT8.png');
  String get PLNTIMG9 => AppDirectory.plant('PLANT9.png');
  String get PLNTIMG10 => AppDirectory.plant('PLANT10.png');
  String get PLNTIMG11 => AppDirectory.plant('PLANT11.png');
  String get PLNTIMG12 => AppDirectory.plant('PLANT12.png');
  String get PLNTIMG13 => AppDirectory.plant('PLANT13.png');
}

class AppRemedy {
  String get PLNTRMDY1 => AppDirectory.remedy('RMDY1.png');
  String get PLNTRMDY2 => AppDirectory.remedy('RMDY2.png');
  String get PLNTRMDY3 => AppDirectory.remedy('RMDY3.png');
  String get PLNTRMDY4 => AppDirectory.remedy('RMDY4.png');
  String get PLNTRMDY5 => AppDirectory.remedy('RMDY5.png');
  String get PLNTRMDY6 => AppDirectory.remedy('RMDY5.png');
  String get PLNTRMDY7 => AppDirectory.remedy('RMDY5.png');
  String get PLNTRMDY8 => AppDirectory.remedy('RMDY8.png');
  String get PLNTRMDY9 => AppDirectory.remedy('RMDY9.png');
  String get PLNTRMDY10 => AppDirectory.remedy('RMDY10.png');
  String get PLNTRMDY11 => AppDirectory.remedy('RMDY11.png');
  String get PLNTRMDY12 => AppDirectory.remedy('RMDY12.png');
  String get niyog_paste => AppDirectory.remedy('RMDY13.png');
  String get niyog_oil => AppDirectory.remedy('RMDY14.png');
  String get sambong_tea => AppDirectory.remedy('RMDY15.png');
  String get ulasimang_juice => AppDirectory.remedy('RMDY16.png');

  String get tsaanGubat_tea => AppDirectory.remedy('RMDY17.png');
  String get yerbaBuena_tea => AppDirectory.remedy('RMDY18.png');
  String get lagundi_bath => AppDirectory.remedy('RMDY19.png');
  String get yerbaBuena_juice => AppDirectory.remedy('RMDY20.png');
  String get paragis_poultice => AppDirectory.remedy('RMDY21.png');
}

class AppColor {
  Color get darkGrey => const Color(0xFF808080);
  Color get dimdark => const Color(0xFF31363F);
  Color get grey => const Color(0xFFEBEBEB);
  Color get light => const Color(0xFFE9EEF0);
  Color get darklight => const Color(0xFFC6D3D8);
  Color get lightGrey => const Color(0xFFBEBEBE);
  Color get background => const Color(0xFFF2F7FA);
  Color get primary => const Color(0xFF008263);
  Color get primaryhigh => const Color(0xFF2F604B);
  Color get primarylow => const Color(0xff50727B);
  Color get secondary => const Color(0xFF9C7300);
  Color get invalid => const Color(0xFFF15A59);
  Color get valid => const Color(0xFF75AE87);
  Color get success => const Color(0xFFC0E863);
  Color get question => const Color(0xFF78B7D0);
  Color get warning => const Color(0xFFFFBF00);
  Color get white => const Color(0xFFF5F5F5);

  Color get whiteOpacity10 => const Color(0xFFFFFFFF).withOpacity(0.1);
  Color get whiteOpacity20 => const Color(0xFFFFFFFF).withOpacity(0.2);
  Color get whiteOpacity30 => const Color(0xFFFFFFFF).withOpacity(0.3);
  Color get whiteOpacity40 => const Color(0xFFFFFFFF).withOpacity(0.4);
  Color get whiteOpacity50 => const Color(0xFFFFFFFF).withOpacity(0.5);
  Color get whiteOpacity60 => const Color(0xFFFFFFFF).withOpacity(0.6);
  Color get whiteOpacity70 => const Color(0xFFFFFFFF).withOpacity(0.7);
  Color get whiteOpacity80 => const Color(0xFFFFFFFF).withOpacity(0.8);

  Color get dark => const Color(0xFF2B2A29);
  Color get darkOpacity10 => const Color(0xFF000000).withOpacity(0.1);
  Color get darkOpacity20 => const Color(0xFF000000).withOpacity(0.2);
  Color get darkOpacity30 => const Color(0xFF000000).withOpacity(0.3);
  Color get darkOpacity40 => const Color(0xFF000000).withOpacity(0.4);
  Color get darkOpacity50 => const Color(0xFF000000).withOpacity(0.5);
  Color get darkOpacity60 => const Color(0xFF000000).withOpacity(0.6);
  Color get darkOpacity70 => const Color(0xFF000000).withOpacity(0.7);
  Color get darkOpacity80 => const Color(0xFF000000).withOpacity(0.8);
}

class AppStyle with CustomTextStyle, CustomButtonStyle {}
