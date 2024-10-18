import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naturemedix/utils/_initApp.dart';
import '../../models/plant_model.dart';
import '../../routes/screen_routes.dart';
import '../../utils/responsive.dart';

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
        ? 'Discover Your Green Allies'
        : hour < 17
            ? 'Reveal Your Herbal Plants'
            : 'Discover Your Herbal Plant';
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    update();
  }

  void selectPlant(PlantData plant, BuildContext context) {
    Get.toNamed(
      ScreenRouter.getPlantInfoRoute,
      arguments: plant,
    );
  }

  final borderCust = OutlineInputBorder(
    borderSide: BorderSide(color: Application().color.white),
    borderRadius: BorderRadius.circular(15),
  );
}
