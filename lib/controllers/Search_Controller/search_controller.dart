import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naturemedix/data/PlantData/plant_data.dart';
import '../../models/plant_info.dart';
import '../../models/remedy_info.dart';
import '../../utils/_initApp.dart';

class SearchingController extends GetxController {
  var filteredPlants = <PlantData>[].obs;
  var filteredRemedies = <RemedyInfo>[].obs;
  final searchController = TextEditingController();

  var ascendingSort = true.obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_filterResults);
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> incrementSearchCount({
    required String name,
    required String type,
  }) async {
    try {
      // Reference the document for the searched item
      final searchRef = _firestore.collection('most_search').doc(name);

      // Perform a transaction to increment the count safely
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(searchRef);

        if (snapshot.exists) {
          // If the document exists, increment the count
          transaction.update(searchRef, {
            'count': FieldValue.increment(1),
          });
        } else {
          // If the document does not exist, create it with initial values
          transaction.set(searchRef, {
            'type': type,
            'count': 1,
          });
        }
      });
    } catch (e) {
      print("Error incrementing search count: $e");
    }
  }



  void _filterResults() {
    final query = searchController.text.toLowerCase();

    if (query.isEmpty) {
      filteredPlants.clear();
      filteredRemedies.clear();
    } else {
      filteredPlants.value = plantList.where((plant) {
        final matchesPlantName = plant.plantName.toLowerCase().contains(query);
        final matchesScientificName =
            plant.scientificName.toLowerCase().contains(query);
        final matchesTreatment = plant.treatments
            .any((treatment) => treatment.toLowerCase().contains(query));
        final matchesRemedyInPlant = plant.remedyList.any((remedy) {
          return remedy.remedyName.toLowerCase().contains(query) ||
              remedy.treatment.toLowerCase().contains(query) ||
              remedy.description.toLowerCase().contains(query);
        });

        return matchesPlantName ||
            matchesScientificName ||
            matchesTreatment ||
            matchesRemedyInPlant;
      }).toList();

      filteredRemedies.value =
          plantList.expand((plant) => plant.remedyList).where((remedy) {
        final matchesRemedyName =
            remedy.remedyName.toLowerCase().contains(query);
        final matchesRemedyType =
            remedy.remedyType.toLowerCase().contains(query);
        final matchesTreatment = remedy.treatment.toLowerCase().contains(query);
        final matchesDescription =
            remedy.description.toLowerCase().contains(query);

        return matchesRemedyName ||
            matchesRemedyType ||
            matchesTreatment ||
            matchesDescription;
      }).toList();
    }
    _sortFilteredResults();
  }

  void toggleSort() {
    ascendingSort.value = !ascendingSort.value;
    _sortFilteredResults();
    update();
  }

  void _sortFilteredResults() {
    if (ascendingSort.value) {
      filteredPlants.sort((a, b) => a.plantName.compareTo(b.plantName));
      filteredRemedies.sort((a, b) => a.remedyName.compareTo(b.remedyName));
    } else {
      filteredPlants.sort((a, b) => b.plantName.compareTo(a.plantName));
      filteredRemedies.sort((a, b) => b.remedyName.compareTo(a.remedyName));
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  final borderCust = OutlineInputBorder(
    borderSide: BorderSide(color: Application().color.white),
    borderRadius: BorderRadius.circular(15),
  );
}
