import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../models/plant_model.dart';

class BookmarkController extends GetxController {
  var ascendingSort = true.obs;
  var bookmarkedPlants = <PlantBasicInfo>[].obs;
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

  void addBookmark(PlantBasicInfo plant) {
    if (!bookmarkedPlants.contains(plant)) {
      bookmarkedPlants.add(plant);
    }
    update();
  }

  void removeBookmark(PlantBasicInfo plant) {
    bookmarkedPlants.remove(plant);
    update();
  }

  bool isBookmarked(PlantBasicInfo plant) {
    return bookmarkedPlants.contains(plant);
  }

  List<PlantBasicInfo> get filteredBookmarks {
    var bookmarks = bookmarkedPlants.where((plant) {
      return plant.plantName.toLowerCase().contains(searchQuery.value);
    }).toList();

    if (!ascendingSort.value) {
      bookmarks.sort((a, b) => b.plantName.compareTo(a.plantName));
    } else {
      bookmarks.sort((a, b) => a.plantName.compareTo(b.plantName));
    }

    return bookmarks;
  }
}
