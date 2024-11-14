import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/controllers/WalkThru_Control/splash_controller.dart';
import 'package:naturemedix/utils/NeoBox.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';

class SplashScreen extends StatelessWidget with Application {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) => Scaffold(
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
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeoBox(
                      child: Padding(
                        padding: EdgeInsets.all(
                            setResponsiveSize(context, baseSize: 14)),
                        child: Image.asset(
                          logo.first,
                          scale: setResponsiveSize(context, baseSize: 3.8),
                        ),
                      ),
                    ),
                    Gap(setResponsiveSize(context, baseSize: 35)),
                    Text(name.first,
                        style: style.displayMedium(context,
                            color: color.white,
                            fontspace: 3,
                            fontsize:
                                setResponsiveSize(context, baseSize: 20))),
                    Gap(setResponsiveSize(context, baseSize: 15)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
