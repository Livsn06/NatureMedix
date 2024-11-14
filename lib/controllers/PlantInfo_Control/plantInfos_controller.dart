import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class PlantInfoController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Box? userBox;
  var overallRating = 0.0.obs;
  var totalReactions = 0.obs;
  var isReacted = false.obs;

  double get currentRating => overallRating.value;

  @override
  void onInit() {
    super.onInit();
    openUserBox();
  }

  Future<void> openUserBox() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    userBox = await Hive.openBox(user.uid);
  }

  void updateRating(double newRating) {
    overallRating.value = newRating;
  }

  // Optimized saveRating using Firestore Batch to speed up writes
  Future<void> saveRating(String remedyName, double rating) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        WriteBatch batch = _firestore.batch();

        final userRatingRef = _firestore
            .collection('users')
            .doc(user.uid)
            .collection('ratings')
            .doc(remedyName);
        batch.set(userRatingRef, {
          'rating': rating,
          'timestamp': FieldValue.serverTimestamp(),
        });

        DocumentReference plantRatingRef =
            _firestore.collection('plant_ratings').doc(remedyName);
        DocumentSnapshot snapshot = await plantRatingRef.get();
        List<double> allRatings = [];
        if (snapshot.exists) {
          allRatings = List<double>.from(snapshot.get('ratings') ?? []);
        }
        allRatings.add(rating);

        double total = allRatings.reduce((a, b) => a + b);
        double newOverallRating = total / allRatings.length;

        batch.set(plantRatingRef, {
          'ratings': allRatings,
          'overall_rating': newOverallRating,
        });

        await batch.commit();

        if (userBox != null) {
          await userBox!
              .put('${user.uid}-overallRating-$remedyName', newOverallRating);
        }

        // Update the local state for UI
        updateRating(newOverallRating);

        print(
            "Rating saved to Firestore for user ${user.uid} and plant $remedyName");
      } catch (e) {
        print("Error saving rating: $e");
      }
    }
  }

  // Use cached rating from Hive or fetch from Firestore if not cached
  Future<double> getOverallRating(String remedyName) async {
    final user = _auth.currentUser;
    if (user == null) return 0.0;

    if (userBox != null) {
      var cachedRating = await userBox!
          .get('${user.uid}-overallRating-$remedyName', defaultValue: 0.0);
      if (cachedRating != 0.0) return cachedRating;
    }

    try {
      DocumentReference plantRatingRef =
          _firestore.collection('plant_ratings').doc(remedyName);

      DocumentSnapshot snapshot = await plantRatingRef.get();
      if (!snapshot.exists) return 0.0;

      double overallRating = snapshot.get('overall_rating') ?? 0.0;

      if (userBox != null) {
        await userBox!
            .put('${user.uid}-overallRating-$remedyName', overallRating);
      }
      updateRating(overallRating); // Update local state with latest rating

      return overallRating;
    } catch (e) {
      print("Error fetching overall rating: $e");
      return 0.0;
    }
  }

  //# FOR REACT COUNTS

  Future<void> fetchReactionState(String plantName) async {
    final user = _auth.currentUser;
    if (user == null) return;

    if (userBox != null) {
      var cachedReaction = await userBox!
          .get('${user.uid}-reacted-$plantName', defaultValue: false);
      if (cachedReaction != false) {
        isReacted.value = cachedReaction;
      }
    }

    try {
      final reactionRef = _firestore
          .collection('plants')
          .doc(plantName)
          .collection('reactions')
          .doc(user.uid);
      DocumentSnapshot snapshot = await reactionRef.get();
      if (snapshot.exists) {
        isReacted.value = snapshot.get('reacted');
      }
    } catch (e) {
      print("Error fetching reaction state: $e");
    }
  }

  // Function to toggle the react button
  Future<void> toggleReactButton(String plantName) async {
    isReacted.value = !isReacted.value;
    await saveReaction(plantName);
    await updateReactionCount(plantName);
  }

  // Function to save the reaction to Firestore or Hive
  Future<void> saveReaction(String plantName) async {
    final user = _auth.currentUser;
    if (user == null) return;

    if (isReacted.value) {
      if (userBox != null) {
        await userBox!.put('${user.uid}-reacted-$plantName', true);
      }
      try {
        final reactionRef = _firestore
            .collection('plants')
            .doc(plantName)
            .collection('reactions')
            .doc(user.uid);
        await reactionRef
            .set({'reacted': true, 'timestamp': FieldValue.serverTimestamp()});
      } catch (e) {
        print("Error saving reaction: $e");
      }
    } else {
      if (userBox != null) {
        await userBox!.put('${user.uid}-reacted-$plantName', false);
      }
      try {
        final reactionRef = _firestore
            .collection('plants')
            .doc(plantName)
            .collection('reactions')
            .doc(user.uid);
        await reactionRef.delete();
      } catch (e) {
        print("Error deleting reaction: $e");
      }
    }
  }

  // Method to count total reactions for a specific plant
  Future<void> updateReactionCount(String plantName) async {
    try {
      final reactionsQuery = await _firestore
          .collection('plants')
          .doc(plantName)
          .collection('reactions')
          .get();

      int count = reactionsQuery.docs.length;
      totalReactions.value = count;

      if (userBox != null) {
        await userBox!.put('totalReactions-$plantName', count);
      }

      print("Total reactions for $plantName: $count");
    } catch (e) {
      print("Error updating reaction count: $e");
      // Offline mode: Retrieve the cached reaction count from Hive
      if (userBox != null) {
        totalReactions.value =
            await userBox!.get('totalReactions-$plantName', defaultValue: 0);
      }
    }
  }
}
