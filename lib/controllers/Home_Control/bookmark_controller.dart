import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naturemedix/models/history_data.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      searchQuery.value = searchController.text.toLowerCase();
    });
    loadBookmarks();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    update();
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

  void removeBookmark(PlantData plant, BuildContext context) async {
    showConfirmValidation(
      context,
      'Delete Bookmark',
      'Do you want to delete?',
      () async {
        bookmarkedPlants.remove(plant);
        await saveBookmarks();
        Get.back();
        Get.snackbar(
          'Success',
          'Successfully delete bookmark.',
          icon: Icon(Icons.delete_outline_outlined,
              color: Application().color.white),
          colorText: Application().color.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Application().color.valid,
        );
      },
      Application().gif.removed,
    );
    update();
  }

  void addBookmark(PlantData plant) async {
    if (!bookmarkedPlants.contains(plant)) {
      plant.bookmarkedAt = DateTime.now();
      bookmarkedPlants.add(plant);
      await saveBookmarks();
    }
    update();
  }

  void addRemedyBookmark(RemedyInfo remedy) async {
    if (!bookmarkedRemedies.contains(remedy)) {
      remedy.bookmarkedAt = DateTime.now();
      bookmarkedRemedies.add(remedy);
      await saveBookmarks();
    }
    update();
  }

  void removeRemedyBookmark(RemedyInfo remedy, BuildContext context) async {
    showConfirmValidation(
      context,
      'Delete Bookmark',
      'Do you want to delete?',
      () async {
        Get.back();
        try {
          bookmarkedRemedies.remove(remedy);
          await saveBookmarks();
          Get.snackbar(
            'Success',
            'Successfully delete bookmark.',
            icon: Icon(Icons.delete_outline_outlined,
                color: Application().color.white),
            colorText: Application().color.white,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Application().color.valid,
          );
        } catch (e) {
          print('Error deleting request: $e');
        }
        update();
      },
      Application().gif.removed,
    );
  }

  void removeAllBookmark(BuildContext context) async {
    if (bookmarkedPlants.isEmpty && bookmarkedRemedies.isEmpty) return;
    showConfirmValidation(
      context,
      'Delete Bookmark',
      'Do you want to delete all?',
      () async {
        Get.back();
        try {
          bookmarkedPlants.clear();
          bookmarkedRemedies.clear();
          await saveBookmarks();
          Get.snackbar(
            'Success',
            'Successfully delete all bookmark.',
            icon: Icon(Icons.delete_outline_outlined,
                color: Application().color.white),
            colorText: Application().color.white,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Application().color.valid,
          );
        } catch (e) {
          print('Error deleting request: $e');
        }
        update();
      },
      Application().gif.removed,
    );
  }

  bool isPlantBookmarked(PlantData plant) {
    return bookmarkedPlants.any((p) => p.plantName == plant.plantName);
  }

  bool isRemedyBookmarked(RemedyInfo remedy) {
    return bookmarkedRemedies.any((r) => r.remedyName == remedy.remedyName);
  }

  List<HistoryEntry> get filteredHistory {
    final query = searchQuery.value;
    List<HistoryEntry> combinedHistory = [];

    // Retrieve history from Hive and convert it to HistoryEntry objects
    final historyData = userBox?.get(
        '${FirebaseAuth.instance.currentUser?.uid}-bookmarkHistory',
        defaultValue: []);

    if (historyData is List) {
      for (var historyEntryMap in historyData) {
        // Convert Map<String, dynamic> to HistoryEntry
        final historyEntry = HistoryEntry.fromMap(historyEntryMap);
        combinedHistory.add(historyEntry);
      }
    }

    // Apply search query filter
    final filteredHistory = combinedHistory.where((historyEntry) {
      bool plantsMatch = historyEntry.plants.any((plant) {
        return (plant.plantName.toLowerCase().contains(query) ||
            plant.scientificName.toLowerCase().contains(query));
      });

      bool remediesMatch = historyEntry.remedies.any((remedy) {
        return (remedy.remedyName.toLowerCase().contains(query) ||
            remedy.description.toLowerCase().contains(query));
      });

      return plantsMatch || remediesMatch;
    }).toList();

    // Apply date filter
    DateTime now = DateTime.now();
    List<HistoryEntry> finalFilteredHistory =
        filteredHistory.where((historyEntry) {
      DateTime bookmarkDate = DateTime.parse(historyEntry.timestamp);

      switch (selectedFilter.value) {
        case 'Today':
          return bookmarkDate.day == now.day &&
              bookmarkDate.month == now.month &&
              bookmarkDate.year == now.year;
        case 'Yesterday':
          DateTime yesterday = now.subtract(Duration(days: 1));
          return bookmarkDate.day == yesterday.day &&
              bookmarkDate.month == yesterday.month &&
              bookmarkDate.year == yesterday.year;
        case 'Old':
          return bookmarkDate.isBefore(now.subtract(Duration(days: 2)));
        default: // 'All'
          return true;
      }
    }).toList();

    // Sort the filtered history based on timestamp (ascending or descending)
    finalFilteredHistory.sort((a, b) {
      DateTime dateA = DateTime.parse(a.timestamp);
      DateTime dateB = DateTime.parse(b.timestamp);
      return ascendingSort.value
          ? dateA.compareTo(dateB)
          : dateB.compareTo(dateA);
    });

    return finalFilteredHistory;
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

    List<dynamic> combinedList = [...filteredPlants, ...filteredRemedies];

    // Apply date filter
    DateTime now = DateTime.now();
    combinedList = combinedList.where((item) {
      DateTime? bookmarkDate = (item is PlantData)
          ? item.bookmarkedAt
          : (item as RemedyInfo).bookmarkedAt;
      if (bookmarkDate == null) return false;

      switch (selectedFilter.value) {
        case 'Today':
          return bookmarkDate.day == now.day &&
              bookmarkDate.month == now.month &&
              bookmarkDate.year == now.year;
        case 'Yesterday':
          DateTime yesterday = now.subtract(Duration(days: 1));
          return bookmarkDate.day == yesterday.day &&
              bookmarkDate.month == yesterday.month &&
              bookmarkDate.year == yesterday.year;
        case 'Old':
          return bookmarkDate.isBefore(now.subtract(Duration(days: 2)));
        default: // 'All'
          return true;
      }
    }).toList();

    // Sort the combined list based on ascendingSort
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

  Future<void> saveBookmarks() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    List<Map<String, dynamic>> plantMaps =
        bookmarkedPlants.map((plant) => plant.toMap()).toList();
    List<Map<String, dynamic>> remedyMaps =
        bookmarkedRemedies.map((remedy) => remedy.toMap()).toList();

    // Ensure that the data for history is structured properly
    final historyEntry = {
      'plants': plantMaps,
      'remedies': remedyMaps,
      'timestamp': DateTime.now().toIso8601String(),
    };

    if (userBox == null) await openUserBox();
    if (userBox == null) return;

    // Save locally in Hive
    await userBox!.put('$uid-bookmarkedPlants', plantMaps);
    await userBox!.put('$uid-bookmarkedRemedies', remedyMaps);
    await userBox!.put('$uid-bookmarkHistory', historyEntry);

    // Save to Firestore
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        WriteBatch batch = _firestore.batch();
        DocumentReference userDocRef =
            _firestore.collection('users').doc(user.uid);

        batch.set(
            userDocRef,
            {
              'bookmarkedPlants': plantMaps,
              'bookmarkedRemedies': remedyMaps,
            },
            SetOptions(merge: true));

        batch.set(
            userDocRef,
            {
              'History': FieldValue.arrayUnion([historyEntry]),
            },
            SetOptions(merge: true));

        await batch.commit();
      } catch (e) {
        print("Error saving bookmarks to Firestore: $e");
      }
    }
  }

  Future<void> loadHistory() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return; // Ensure the user is logged in

    // Load from Hive (offline)
    if (userBox == null) await openUserBox();
    if (userBox == null) return;

    // Retrieve the bookmark history from Hive
    final history =
        userBox!.get('${user.uid}-bookmarkHistory', defaultValue: []);
    if (history != null && history is List) {
      List<Map<String, dynamic>> plantMaps =
          history.map((e) => e['plants'] as Map<String, dynamic>).toList();
      List<Map<String, dynamic>> remedyMaps =
          history.map((e) => e['remedies'] as Map<String, dynamic>).toList();

      // Update the history with the loaded data
      bookmarkedPlants.value = plantMaps.map(PlantData.fromMap).toList();
      bookmarkedRemedies.value = remedyMaps.map(RemedyInfo.fromMap).toList();
    }

    // Load from Firestore (online)
    final docSnapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data != null && data.containsKey('bookmarkHistory')) {
        final firestoreHistory = List.from(data['bookmarkHistory'] ?? []);
        // Update history with Firestore data (if available)
        for (var entry in firestoreHistory) {
          final plants = List<Map<String, dynamic>>.from(entry['plants'] ?? []);
          final remedies =
              List<Map<String, dynamic>>.from(entry['remedies'] ?? []);

          // Update plants and remedies with history data
          bookmarkedPlants.addAll(plants.map(PlantData.fromMap));
          bookmarkedRemedies.addAll(remedies.map(RemedyInfo.fromMap));
        }
      }
    }
  }

  Future<void> loadBookmarks() async {
    final user = FirebaseAuth.instance.currentUser;

    // Load from Hive (offline)
    if (userBox == null) await openUserBox();
    if (userBox == null) return;

    final plantList = userBox!
        .get('${user!.uid}-bookmarkedPlants', defaultValue: <PlantData>[]);
    final remedyList = userBox!
        .get('${user.uid}-bookmarkedRemedies', defaultValue: <RemedyInfo>[]);

    bookmarkedPlants.value = plantList.cast<PlantData>();
    bookmarkedRemedies.value = remedyList.cast<RemedyInfo>();

    // Load from Firestore (online)
    final docSnapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data != null) {
        final firestorePlants = List.from(data['bookmarkedPlants'] ?? []);
        final firestoreRemedies = List.from(data['bookmarkedRemedies'] ?? []);
        // Update bookmarks with Firestore data (if available)
        bookmarkedPlants.value =
            firestorePlants.map((e) => PlantData.fromMap(e)).toList();
        bookmarkedRemedies.value =
            firestoreRemedies.map((e) => RemedyInfo.fromMap(e)).toList();
      }
    }
  }

  final borderCust = OutlineInputBorder(
    borderSide: BorderSide(color: Application().color.white),
    borderRadius: BorderRadius.circular(15),
  );
}
