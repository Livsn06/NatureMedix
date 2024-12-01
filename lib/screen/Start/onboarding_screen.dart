import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/components/cust_indicator.dart';
import 'package:naturemedix/controllers/WalkThru_Control/onboarding_controller.dart';
import 'package:naturemedix/models/onboarding_model.dart';
import 'package:naturemedix/utils/NeoBox.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';

class OnboardingScreen extends StatelessWidget with Application {
  @override
  Widget build(BuildContext context) {
    final OnboardingController onboardContoller = Get.find();

    return Scaffold(
      backgroundColor: Colors.transparent,
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
  OnboardingController onboardContoller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 500.milliseconds,
      curve: Curves.linear,
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(color: color.background),
      child: Padding(
        padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: setResponsiveSize(context, baseSize: 50),
                  horizontal: setResponsiveSize(context, baseSize: 5)),
              child: NeoBox(
                child: Image.asset(
                  onboard.imageAsset,
                  fit: BoxFit.fill,
                  scale: setResponsiveSize(context, baseSize: 1),
                ),
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              onboard.title,
              style: style.displayLarge(context, color: color.primary),
            ),
            Gap(setResponsiveSize(context, baseSize: 20)),
            Text(
              onboard.description,
              textAlign: TextAlign.center,
              style: style.TitleMedium(context, color: color.primarylow),
            ),
            Gap(setResponsiveSize(context, baseSize: 120)),
          ],
        ),
      ),
    );
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
          horizontal: setResponsiveSize(context, baseSize: 13),
        ),
        child: Row(
          children: [
            Image.asset(
              logo.first,
              scale: setResponsiveSize(context, baseSize: 8),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: setResponsiveSize(context, baseSize: 8)),
              child: Text("| ${name.first}",
                  style: style.displayMedium(context,
                      color: color.primarylow,
                      fontspace: 2,
                      fontsize: setResponsiveSize(context, baseSize: 13))),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: setResponsiveSize(context, baseSize: 10)),
              child: InkWell(
                onTap: () {
                  onboardContoller.skipPage();
                },
                child: Text(
                  'Skip',
                  style: style.displayMedium(context, color: color.primarylow),
                ),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => CustomAnimatedIndicator(
                initial: onboardContoller.selectedPage.value,
                count: 3,
                curve: Curves.bounceInOut,
                duration: Durations.medium2,
                gap: setResponsiveSize(context, baseSize: 4),
                color: color.primarylow,
                activeColor: color.primary,
                size: Size(
                  setResponsiveSize(context, baseSize: 9),
                  setResponsiveSize(context, baseSize: 9),
                ),
                activeWidth: setResponsiveSize(context, baseSize: 2.5),
              ),
            ),
            IconButton(
              style: style.button1(
                size: Size(
                  setResponsiveSize(context, baseSize: 55),
                  setResponsiveSize(context, baseSize: 50),
                ),
                backgroundColor: color.primary,
                borderWidth: 1.5,
                borderColor: color.primary,
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
