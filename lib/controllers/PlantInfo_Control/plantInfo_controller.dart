import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import '../../models/plant_info.dart';

class PlantInfoController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Box? userBox;
  Box? ratingsBox;

  Future<void> openUserBox() async {
    User? user = _auth.currentUser;
    if (user != null) {
      userBox = await Hive.openBox(user.uid);
    }
  }

  Future<void> openRatingsBox() async {
    ratingsBox = await Hive.openBox('ratings');
  }

  Future<void> saveRating(String plantName, double rating) async {
    if (userBox == null) await openUserBox();
    if (ratingsBox == null) await openRatingsBox();

    // Save the individual user rating in the user's box
    List<double> userRatings = userBox!.get('$plantName-ratings', defaultValue: <double>[]);
    userRatings.add(rating);
    userBox!.put('$plantName-ratings', userRatings);

    // Retrieve and calculate overall rating across all user ratings
    List<double> allRatings = ratingsBox!.get(plantName, defaultValue: <double>[]);
    allRatings.add(rating);
    ratingsBox!.put(plantName, allRatings);

    double total = allRatings.reduce((a, b) => a + b);
    double overallRating = total / allRatings.length;

    // Update the overall rating in the plant model in Hive
    var plantBox = await Hive.openBox<PlantData>('plants');
    PlantData? plant = plantBox.get(plantName);
    if (plant != null) {
      plant.updateRating(overallRating);
      plantBox.put(plantName, plant);
    }
  }

  Future<double> getOverallRating(String plantName) async {
    if (ratingsBox == null) await openRatingsBox();

    // Retrieve all ratings and calculate the average
    List<double> allRatings = ratingsBox!.get(plantName, defaultValue: <double>[]);
    if (allRatings.isEmpty) return 0.0;

    double total = allRatings.reduce((a, b) => a + b);
    return total / allRatings.length;
  }
}
