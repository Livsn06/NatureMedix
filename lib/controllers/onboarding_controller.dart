// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naturemedix/models/onboarding_model.dart';
import 'package:naturemedix/screens/onboarding/getstatrted_screen.dart';
import '../data/list.dart';
import '../routes/screen_routes.dart';

class OnboardingController extends GetxController {
  // ignore: non_constant_identifier_names

  final _pageController = PageController();
  final _onboard_info = ONBOARD_INFO;
  var selectedPage = 0.obs;

  get isMaxPage => selectedPage.value == onboardCount - 1;
  get onboardInfo => _onboard_info;
  get onboardCount => _onboard_info.length;
  PageController get pageController => _pageController;

  void nextPage() {
    if (isMaxPage) {
      Get.toNamed(ScreenRouter.getGetstartedRoute);
      return;
    }

    selectedPage++;
    pageController.nextPage(duration: 300.milliseconds, curve: Curves.linear);
  }

  void skipPage() {
    if (isMaxPage) {
      Get.toNamed(ScreenRouter.getGetstartedRoute);
      return;
    }

    selectedPage.value = onboardCount;
    pageController.animateToPage(
      onboardCount,
      duration: 300.milliseconds,
      curve: Curves.linear,
    );
  }
}
