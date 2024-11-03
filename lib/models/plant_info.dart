import 'package:hive/hive.dart';
import 'remedy_info.dart'; // Your RemedyInfo model

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
 
  void updateRating(double newRating) {
    rating = newRating;
  }
}
