import 'package:hive/hive.dart';

part 'remedy_info.g.dart';

@HiveType(typeId: 1) // Ensure the typeId is unique for RemedyInfo
class RemedyInfo {
  @HiveField(0)
  final String remedyName;

  @HiveField(1)
  final String remedyType;

  @HiveField(2)
  final String treatment;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final List<String> remedyImages;

  @HiveField(5)
  final List<String> ingredients;

  @HiveField(6)
  final List<String> steps;

  @HiveField(7)
  final List<String> usage;

  @HiveField(8)
  final List<String> sideEffects;

  @HiveField(9)
  DateTime? bookmarkedAt;

  @HiveField(10) // Added field for rating
  double rating;

  RemedyInfo({
    required this.remedyName,
    required this.remedyType,
    required this.treatment,
    required this.description,
    required this.remedyImages,
    required this.ingredients,
    required this.steps,
    required this.usage,
    required this.sideEffects,
    this.bookmarkedAt, // Initialize to null; set when bookmarked
    this.rating = 0.0, // Default value for rating
  });

  // Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'remedyName': remedyName,
      'remedyType': remedyType,
      'treatment': treatment,
      'description': description,
      'remedyImages': remedyImages,
      'ingredients': ingredients,
      'steps': steps,
      'usage': usage,
      'sideEffects': sideEffects,
      'bookmarkedAt':
          bookmarkedAt?.toIso8601String(), // Convert to string for storage
      'rating': rating, // Added field for rating
    };
  }

  // Convert from Firestore map
  static RemedyInfo fromMap(Map<String, dynamic> map) {
    return RemedyInfo(
      remedyName: map['remedyName'],
      remedyType: map['remedyType'],
      treatment: map['treatment'],
      description: map['description'],
      remedyImages: List<String>.from(map['remedyImages']),
      ingredients: List<String>.from(map['ingredients']),
      steps: List<String>.from(map['steps']),
      usage: List<String>.from(map['usage']),
      sideEffects: List<String>.from(map['sideEffects']),
      bookmarkedAt: map['bookmarkedAt'] != null
          ? DateTime.parse(map['bookmarkedAt'])
          : null,
      rating: map['rating'] ?? 0.0,
    );
  }

  void updateRating(double newRating) {
    rating = newRating;
  }
}
