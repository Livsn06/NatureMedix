import 'package:hive/hive.dart';
import 'remedy_info.dart';

part 'plant_info.g.dart'; // Make sure this part directive matches your generated file

@HiveType(typeId: 0) // Ensure the typeId is unique for PlantData
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
  DateTime? bookmarkedAt;

  PlantData({
    required this.plantName,
    required this.scientificName,
    required this.plantImages,
    required this.description,
    required this.treatments,
    required this.remedyList,
    this.bookmarkedAt, // Initialize to null; set when bookmarked
  });

  // Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'plantName': plantName,
      'scientificName': scientificName,
      'plantImages': plantImages,
      'description': description,
      'treatments': treatments,
      'remedyList': remedyList.map((e) => e.toMap()).toList(),
      'bookmarkedAt':
          bookmarkedAt?.toIso8601String(), // Convert to string for storage
    };
  }

  // Convert from Firestore map
  static PlantData fromMap(Map<String, dynamic> map) {
    return PlantData(
      plantName: map['plantName'],
      scientificName: map['scientificName'],
      plantImages: List<String>.from(map['plantImages']),
      description: map['description'],
      treatments: List<String>.from(map['treatments']),
      remedyList: List<RemedyInfo>.from(
          map['remedyList'].map((e) => RemedyInfo.fromMap(e))),
      bookmarkedAt: map['bookmarkedAt'] != null
          ? DateTime.parse(map['bookmarkedAt'])
          : null,
    );
  }
}
