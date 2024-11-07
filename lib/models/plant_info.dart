import 'package:hive/hive.dart';
import 'remedy_info.dart'; 

part 'plant_info.g.dart';

@HiveType(typeId: 0)
class PlantData {
  @HiveField(0)
  final String plantName;

  @HiveField(1)
  final String scientificName;

  @HiveField(2)
  final List<String> plantImages;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final List<String> treatments;

  @HiveField(5)
  final List<RemedyInfo> remedyList;

  @HiveField(6)
  double rating;

  PlantData({
    required this.plantName,
    required this.scientificName,
    required this.plantImages,
    required this.description,
    required this.treatments,
    required this.remedyList,
    this.rating = 0.0,
  });

  // Convert PlantData to a map (Firestore)
  Map<String, dynamic> toMap() {
    return {
      'plantName': plantName,
      'scientificName': scientificName,
      'plantImages': plantImages,
      'description': description,
      'treatments': treatments,
      'remedyList': remedyList.map((e) => e.toMap()).toList(),
      'rating': rating,
    };
  }

  // Create PlantData from a map (Firestore)
  static PlantData fromMap(Map<String, dynamic> map) {
    return PlantData(
      plantName: map['plantName'],
      scientificName: map['scientificName'],
      plantImages: List<String>.from(map['plantImages']),
      description: map['description'],
      treatments: List<String>.from(map['treatments']),
      remedyList: List<RemedyInfo>.from(
          map['remedyList'].map((e) => RemedyInfo.fromMap(e))),
      rating: map['rating'] ?? 0.0,
    );
  }

  void updateRating(double newRating) {
    rating = newRating;
  }
}
