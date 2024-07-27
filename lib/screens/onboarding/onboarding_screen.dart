import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/components/custom_indicator.dart';
import 'package:naturemedix/controllers/onboarding_controller.dart';
import 'package:naturemedix/models/onboarding_model.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';

class OnboardingScreen extends StatelessWidget with Application {
  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController onboardContoller = Get.find();

    return Scaffold(
      backgroundColor: color.dark,
      body: Stack(
        fit: StackFit.loose,
        alignment: Alignment.topCenter,
        children: [
          PageView.builder(
            controller: onboardContoller.pageController,
            onPageChanged: (value) {
              onboardContoller.selectedPage.value = value;
            },
            itemCount: onboardContoller.onboardCount,
            itemBuilder: (context, index) {
              return FeatureDetail(
                onboard: onboardContoller.onboardInfo[index],
              );
            },
          ),
          TopNavigation(),
          BottomNavigation(),
        ],
      ),
    );
  }
}

class FeatureDetail extends StatelessWidget with Application {
  FeatureDetail({super.key, required this.onboard});

  final OnboardingModel onboard;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 500.milliseconds,
      curve: Curves.linear,
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.center,
          image: AssetImage(onboard.imageAsset),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(color.darkOpacity70, BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              splitTitle(onboard.title, 0),
              style: style.displayLarge(context, color: color.white),
            ),
            Text(
              splitTitle(onboard.title, 1),
              style: style.displayLarge(context, color: color.white),
            ),
            Divider(
              color: color.white,
              thickness: setResponsiveSize(context, baseSize: 2),
              height: 0,
            ),
            Gap(setResponsiveSize(context, baseSize: 17)),
            Text(
              onboard.description,
              style: style.TitleMedium(context, color: color.white),
            ),
          ],
        ),
      ),
    );
  }

  String splitTitle(title, index) {
    return title.split(' ')[index];
  }
}

class TopNavigation extends StatelessWidget with Application {
  TopNavigation({super.key});
  OnboardingController onboardContoller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: setResponsiveSize(context, baseSize: 36),
          horizontal: setResponsiveSize(context, baseSize: 18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name.first,
              style: style.TitleMedium(context, color: color.white),
            ),
            InkWell(
              onTap: () {
                onboardContoller.skipPage();
              },
              child: Text(
                'SKIP',
                textAlign: TextAlign.right,
                style: style.TitleMedium(context, color: color.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BottomNavigation extends StatelessWidget with Application {
  BottomNavigation({super.key});
  OnboardingController onboardContoller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: setResponsiveSize(context, baseSize: 24),
          horizontal: setResponsiveSize(context, baseSize: 18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Obx(
              () => CustomAnimatedIndicator(
                initial: onboardContoller.selectedPage.value,
                count: 3,
                curve: Curves.bounceInOut,
                duration: Durations.medium2,
                gap: setResponsiveSize(context, baseSize: 4),
                activeColor: color.primary,
                size: Size(
                  setResponsiveSize(context, baseSize: 12),
                  setResponsiveSize(context, baseSize: 12),
                ),
                activeWidth: setResponsiveSize(context, baseSize: 2.2),
              ),
            ),
            IconButton(
              style: style.button1(
                size: Size(
                  setResponsiveSize(context, baseSize: 50),
                  setResponsiveSize(context, baseSize: 50),
                ),
                overlayColor: color.whiteOpacity40,
                backgroundColor: color.whiteOpacity20,
                borderWidth: 1.5,
                borderColor: color.white,
                radius: setResponsiveSize(context, baseSize: 10),
              ),
              onPressed: () {
                onboardContoller.nextPage();
              },
              icon: const Icon(Icons.arrow_forward_ios),
              color: color.white,
            )
          ],
        ),
      ),
    );
  }
}

