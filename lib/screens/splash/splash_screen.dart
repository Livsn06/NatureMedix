import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naturemedix/controllers/splash_controller.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';


class SplashScreen extends StatelessWidget with Application {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) => Scaffold(
        backgroundColor: color.dark,
        body: Stack(
          fit: StackFit.loose,
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage(image.BG1),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(color.darkOpacity50, BlendMode.darken),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    logo.first,
                    scale: setResponsiveSize(context, baseSize: 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
