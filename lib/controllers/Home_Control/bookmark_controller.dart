import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/cust_ConfirmAlert.dart';
import '../../models/plant_info.dart';
import '../../models/remedy_info.dart';
import '../../utils/_initApp.dart';

class BookmarkController extends GetxController {
  var ascendingSort = true.obs;
  var bookmarkedPlants = <PlantData>[].obs;
  var bookmarkedRemedies = <RemedyInfo>[].obs;
  var searchQuery = ''.obs;
  final searchController = TextEditingController();
  Box? userBox;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      searchQuery.value = searchController.text.toLowerCase();
    });
    loadBookmarksFromHive();
  }

  void toggleSort() {
    ascendingSort.value = !ascendingSort.value;
    update();
  }

  Future<void> openUserBox() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Open a Hive box specific to the user's UID.
    userBox = await Hive.openBox(user.uid);
  }

  void addBookmark(PlantData plant) async {
    if (!bookmarkedPlants.contains(plant)) {
      bookmarkedPlants.add(plant);
      await saveBookmarksToHive();
    }
    update();
  }

  void removeBookmark(PlantData plant, BuildContext context) async {
    showConfirmValidation(
      context,
      'Delete Bookmark',
      'Do you want to delete?',
      () async {
        bookmarkedPlants.remove(plant);
        await saveBookmarksToHive();
        Get.back();
        Get.snackbar(
          'Success',
          'Successfully delete bookmark.',
          icon: Icon(Icons.delete_outline_outlined,
              color: Application().color.white),
          colorText: Application().color.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Application().color.primary,
        );
      },
      Application().gif.removed,
    );
    update();
  }

  void addRemedyBookmark(RemedyInfo remedy) async {
    if (!bookmarkedRemedies.contains(remedy)) {
      bookmarkedRemedies.add(remedy);
      await saveBookmarksToHive();
    }
    update();
  }

  void removeRemedyBookmark(RemedyInfo remedy, BuildContext context) async {
    showConfirmValidation(
      context,
      'Delete Bookmark',
      'Do you want to delete?',
      () async {
        bookmarkedRemedies.remove(remedy);
        await saveBookmarksToHive();
        Get.back();
        Get.snackbar(
          'Success',
          'Successfully delete bookmark.',
          icon: Icon(Icons.delete_outline_outlined,
              color: Application().color.white),
          colorText: Application().color.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Application().color.primary,
        );
      },
      Application().gif.removed,
    );
    update();
  }

  void removeAllBookmark(BuildContext context) async {
    if (bookmarkedPlants.isEmpty && bookmarkedRemedies.isEmpty) return;
    showConfirmValidation(
      context,
      'Delete Bookmark',
      'Do you want to delete all?',
      () async {
        bookmarkedPlants.clear();
        bookmarkedRemedies.clear();
        await saveBookmarksToHive();
        Get.back();
        Get.snackbar(
          'Success',
          'Successfully delete all bookmark.',
          icon: Icon(Icons.delete_outline_outlined,
              color: Application().color.white),
          colorText: Application().color.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Application().color.primary,
        );
      },
      Application().gif.removed,
    );
    update();
  }

  bool isPlantBookmarked(PlantData plant) {
    return bookmarkedPlants.any((p) => p.plantName == plant.plantName);
  }

  bool isRemedyBookmarked(RemedyInfo remedy) {
    return bookmarkedRemedies.any((r) => r.remedyName == remedy.remedyName);
  }

  List<dynamic> get filteredBookmarks {
    final query = searchQuery.value;
    final filteredPlants = bookmarkedPlants.where((plant) {
      return plant.plantName.toLowerCase().contains(query) ||
          plant.scientificName.toLowerCase().contains(query);
    }).toList();
    final filteredRemedies = bookmarkedRemedies.where((remedy) {
      return remedy.remedyName.toLowerCase().contains(query) ||
          remedy.description.toLowerCase().contains(query);
    }).toList();
    final combinedList = [...filteredPlants, ...filteredRemedies];
    combinedList.sort((a, b) {
      String nameA =
          (a is PlantData) ? a.plantName : (a as RemedyInfo).remedyName;
      String nameB =
          (b is PlantData) ? b.plantName : (b as RemedyInfo).remedyName;
      return ascendingSort.value
          ? nameA.compareTo(nameB)
          : nameB.compareTo(nameA);
    });
    return combinedList;
  }

  Future<void> saveBookmarksToHive() async {
    if (userBox == null) await openUserBox();
    if (userBox == null) return;

    // Save the bookmarks in the user's Hive box with a unique key
    await userBox!.put(
        '${FirebaseAuth.instance.currentUser!.uid}-bookmarkedPlants',
        bookmarkedPlants.toList());
    await userBox!.put(
        '${FirebaseAuth.instance.currentUser!.uid}-bookmarkedRemedies',
        bookmarkedRemedies.toList());
  }

  Future<void> loadBookmarksFromHive() async {
    if (userBox == null) await openUserBox();
    if (userBox == null) return;

    // Load the bookmarks from the user's Hive box using the unique key
    final plantList = userBox!.get(
        '${FirebaseAuth.instance.currentUser!.uid}-bookmarkedPlants',
        defaultValue: <PlantData>[]);
    final remedyList = userBox!.get(
        '${FirebaseAuth.instance.currentUser!.uid}-bookmarkedRemedies',
        defaultValue: <RemedyInfo>[]);

    // Convert the dynamic lists to specific types
    bookmarkedPlants.value = plantList.cast<PlantData>();
    bookmarkedRemedies.value = remedyList.cast<RemedyInfo>();
  }

  final borderCust = OutlineInputBorder(
    borderSide: BorderSide(color: Application().color.white),
    borderRadius: BorderRadius.circular(15),
  );
}
