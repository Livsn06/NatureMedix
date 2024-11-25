import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naturemedix/controllers/PlantInfo_Control/plantInfos_controller.dart';
import 'package:naturemedix/utils/_initApp.dart';
import '../../Data/PlantData/plant_data.dart';
import '../../models/plant_info.dart';
import '../../models/remedy_info.dart';
import '../../routes/screen_routes.dart';

class DashboardController extends GetxController {
  var selectedCategory = 'All'.obs;
  var greeting = ''.obs;
  var selectedPlant = Rxn<PlantData>();

  // New properties for search functionality
  var searchText = ''.obs;
  var filteredPlants = <PlantData>[].obs;
  var filteredRemedies = <RemedyInfo>[].obs;

  @override
  void onInit() {
    super.onInit();
    updateGreeting();
    // Initialize filtered lists
    filteredPlants.value = plantList;
    filteredRemedies.value =
        plantList.expand((plant) => plant.remedyList).toList();
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

  void selectRemedy(RemedyInfo remedy, BuildContext context) {
    Get.toNamed(
      ScreenRouter.getRemedyInfoRoute,
      arguments: remedy,
    );
  }

  void goToSearch() {
    Get.toNamed(ScreenRouter.getSearchRoute);
  }

  final borderCust = OutlineInputBorder(
    borderSide: BorderSide(color: Application().color.white),
    borderRadius: BorderRadius.circular(10),
  );

  void gotoSeeAll(List<PlantData> plantList, String title) {
    Get.toNamed(
      ScreenRouter.getGridListRoute,
      arguments: {
        'title': title,
        'plantList': plantList,
      },
    );
  }
}
