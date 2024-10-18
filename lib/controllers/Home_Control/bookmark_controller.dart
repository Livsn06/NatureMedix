import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../components/cust_confirmation.dart';
import '../../models/plant_model.dart';

class BookmarkController extends GetxController {
  var ascendingSort = true.obs;
  var bookmarkedPlants = <PlantData>[].obs;
  var searchQuery = ''.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      searchQuery.value = searchController.text.toLowerCase();
    });
  }

  void toggleSort() {
    ascendingSort.value = !ascendingSort.value;
    update();
  }

  void addBookmark(PlantData plant) {
    if (!bookmarkedPlants.contains(plant)) {
      bookmarkedPlants.add(plant);
    }
    update();
  }

  void removeBookmark(PlantData plant, BuildContext context) {
    showConfirmValidation(context, 'Delete Bookmark', 'Do you want to delete ?',
        () {
      bookmarkedPlants.remove(plant);
      Get.back();
    });
    update();
  }

  bool isBookmarked(PlantData plant) {
    return bookmarkedPlants.contains(plant);
  }

  List<PlantData> get filteredBookmarks {
    var bookmarks = bookmarkedPlants.where((plant) {
      return plant.plantBasicInfo.plantName.toLowerCase().contains(searchQuery.value);
    }).toList();

    if (!ascendingSort.value) {
      bookmarks.sort((a, b) => b.plantBasicInfo.plantName.compareTo(a.plantBasicInfo.plantName));
    } else {
      bookmarks.sort((a, b) => a.plantBasicInfo.plantName.compareTo(b.plantBasicInfo.plantName));
    }

    return bookmarks;
  }
}
