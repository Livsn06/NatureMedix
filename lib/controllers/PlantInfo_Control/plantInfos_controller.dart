import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class PlantInfoController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Box? userBox;
  var totalReactions = 0.obs;
  var isReacted = false.obs;
  var plantReactions = <String, RxInt>{}.obs; // Store reactions per plant
  var remedyRatings = <String, RxDouble>{}.obs; // Store ratings per remedy
  var overallRatingForRemedy =
      <String, RxDouble>{}.obs; // Store overall ratings for each remedy

  @override
  void onInit() {
    super.onInit();
    openUserBox();
    fetchUserRatings(); // Fetch the user's existing ratings
    fetchOverallRatings();
  }

  Future<void> fetchOverallRatings() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      // Fetch overall ratings for each remedy from Firestore
      final remedyRatingsSnapshot =
          await _firestore.collection('plant_ratings').get();

      for (var doc in remedyRatingsSnapshot.docs) {
        final remedyName = doc.id;
        final overallRating = doc.get('overall_rating') ?? 0.0;

        // Update the local state with the overall rating
        overallRatingForRemedy[remedyName] = RxDouble(overallRating);
        print("Fetched overall rating for remedy $remedyName: $overallRating");
      }
    } catch (e) {
      print("Error fetching overall ratings: $e");
    }
  }

  Future<void> fetchUserRatings() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      // Fetch the user's ratings from Firestore
      final userRatingsSnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('ratings')
          .get();

      for (var doc in userRatingsSnapshot.docs) {
        final remedyName = doc.id;
        final rating = doc.get('rating');

        // Update the local state with the user's rating for the remedy
        remedyRatings[remedyName] = RxDouble(rating);
        print("Fetched existing rating for remedy $remedyName: $rating");
      }
    } catch (e) {
      print("Error fetching user ratings: $e");
    }
  }

  Future<void> openUserBox() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    userBox = await Hive.openBox(user.uid);
  }

  // Optimized saveRating using Firestore Batch to speed up writes
  void updateRemedyRating(String remedyName, double newRating) {
    if (!remedyRatings.containsKey(remedyName)) {
      remedyRatings[remedyName] = RxDouble(newRating);
    } else {
      remedyRatings[remedyName]?.value = newRating;
    }
    update(); // Trigger an update for the controller
  }

  // Save the rating for a specific remedy
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

        // Check if the user already rated the remedy
        DocumentSnapshot userRatingSnapshot = await userRatingRef.get();

        if (userRatingSnapshot.exists) {
          // If the user has already rated, update the rating
          double existingRating = userRatingSnapshot.get('rating');
          if (existingRating != rating) {
            batch.update(userRatingRef, {
              'rating': rating,
              'timestamp': FieldValue.serverTimestamp(),
            });
          }
        } else {
          // If the user hasn't rated, save the rating
          batch.set(userRatingRef, {
            'rating': rating,
            'timestamp': FieldValue.serverTimestamp(),
          });
        }

        DocumentReference plantRatingRef =
            _firestore.collection('plant_ratings').doc(remedyName);

        DocumentSnapshot plantRatingSnapshot = await plantRatingRef.get();
        List<double> allRatings = [];
        if (plantRatingSnapshot.exists) {
          allRatings =
              List<double>.from(plantRatingSnapshot.get('ratings') ?? []);
        }
        allRatings.add(rating);

        double total = allRatings.reduce((a, b) => a + b); // Sum all ratings
        double newOverallRating = total / allRatings.length;

        batch.set(plantRatingRef, {
          'ratings': allRatings,
          'overall_rating': newOverallRating,
        });

        await batch.commit();

        // Store the rating in Hive for offline access
        if (userBox != null) {
          await userBox!.put('${user.uid}-rating-$remedyName', rating);
        }

        // Update the local map with the new overall rating
        overallRatingForRemedy[remedyName] = RxDouble(newOverallRating);

        print("Rating saved/updated for remedy $remedyName: $newOverallRating");
      } catch (e) {
        print("Error saving rating: $e");
      }
    }
  }

  //# FOR REACT COUNTS

  Future<void> toggleReactButton(String plantName) async {
    await fetchReactionState(plantName);
    isReacted.value = !isReacted.value;

    await saveReaction(plantName);
    await updateReactionCount(plantName);
  }

  Future<void> fetchReactionState(String plantName) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      // Set the default reaction state as false (favorite_outline)
      isReacted.value = false;

      // First check if the reaction state is in local cache
      if (userBox != null) {
        var cachedReaction = await userBox!
            .get('${user.uid}-reacted-$plantName', defaultValue: false);
        if (cachedReaction != null) {
          isReacted.value = cachedReaction;
          return; // Return early if the state is already cached
        }
      }
      // If no cached value, fetch from Firestore
      final reactionRef = _firestore
          .collection('plant_reacts')
          .doc(plantName)
          .collection('reactions')
          .doc(user.uid);

      DocumentSnapshot snapshot = await reactionRef.get();
      isReacted.value = snapshot.exists && snapshot.get('reacted') == true;

      // Cache the fetched state
      await userBox?.put('${user.uid}-reacted-$plantName', isReacted.value);
    } catch (e) {
      print("Error fetching reaction state: $e");
    }
  }

// Toggle reaction state
  Future<void> toggleReaction(String plantName) async {
    isReacted.value != isReacted.value;
    await saveReaction(plantName);
  }

// Save reaction state to Firestore and update cache
  Future<void> saveReaction(String plantName) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final reactionRef = _firestore
          .collection('plant_reacts')
          .doc(plantName)
          .collection('reactions')
          .doc(user.uid);

      if (isReacted.value) {
        await reactionRef.set({
          'reacted': true,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        await reactionRef.delete();
      }

      // Update local cache
      await userBox?.put('${user.uid}-reacted-$plantName', isReacted.value);

      // Update reaction count
      await updateReactionCount(plantName);
    } catch (e) {
      print("Error saving reaction: $e");
    }
  }

// Update total reaction count for a plant
  Future<void> updateReactionCount(String plantName) async {
    try {
      final reactionsQuery = await _firestore
          .collection('plant_reacts')
          .doc(plantName)
          .collection('reactions')
          .get();

      int count = reactionsQuery.docs.length;
      plantReactions[plantName] = RxInt(count);

      // Cache the count locally
      await userBox?.put('${plantName}-reactionCount', count);
    } catch (e) {
      print("Error updating reaction count: $e");
    }
  }
}
