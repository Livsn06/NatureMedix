import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/plant_model.dart';
import '../routes/screen_routes.dart';

class DashboardController extends GetxController {
  var selectedCategory = 'All'.obs;
  var selectedPlant = Rxn<PlantBasicInfo>();

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
