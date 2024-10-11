import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/plant_model.dart';
import '../../routes/screen_routes.dart';

class DashboardController extends GetxController {
  var selectedCategory = 'All'.obs;
  var greeting = ''.obs;
  var selectedPlant = Rxn<PlantBasicInfo>();

  @override
  void onInit() {
    super.onInit();
    updateGreeting();
  }

  void updateGreeting() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 8));
    final hour = now.hour;

    greeting.value = hour < 12
        ? 'Hi, Explore NatureMedix! 🌱 '
        : hour < 17
            ? 'Hi, Discover Herbal Remedies! 🌼'
            : 'Hi, Relax and Heal! 🌻';
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    update();
  }

  void selectPlant(PlantBasicInfo plant, BuildContext context) {
    Get.toNamed(
      ScreenRouter.getPlantInfoRoute,
      arguments: plant,
    );
  }
}
