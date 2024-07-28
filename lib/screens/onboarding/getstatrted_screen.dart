import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../routes/screen_routes.dart';
import '../../utils/_initApp.dart';
import '../../utils/responsive.dart';

class GetstartedScreen extends StatelessWidget with Application {
  GetstartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.center,
                image: AssetImage(image.BG1),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  color.darkOpacity70,
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, setResponsiveSize(context, baseSize: 0.15)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: setResponsiveSize(context, baseSize: 18)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: setResponsiveSize(context, baseSize: 70),
                    backgroundColor: color.darkOpacity50,
                    backgroundImage: AssetImage(logo.first),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 20)),
                  Text(
                    name.first,
                    style: style.headlineLarge(context, color: color.white),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 36)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: setResponsiveSize(context, baseSize: 18)),
                    child: Text(
                      'Explore herbal plants and discover natural remedies for better health',
                      textAlign: TextAlign.center,
                      style: style.TitleMedium(context, color: color.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, setResponsiveSize(context, baseSize: 0.80)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: setResponsiveSize(context, baseSize: 18)),
              child: TextButton(
                style: style.button1(
                  size: Size(
                    double.maxFinite,
                    setResponsiveSize(context, baseSize: 48),
                  ),
                  backgroundColor: color.whiteOpacity20,
                  borderColor: color.white,
                  borderWidth: 1.5,
                  overlayColor: color.whiteOpacity40,
                  radius: 10,
                ),
                onPressed: () {
                  Get.toNamed(ScreenRouter.getChooseactionRoute);
                },
                child: Text(
                  'Get Started',
                  style: style.TitleMedium(context, color: color.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}