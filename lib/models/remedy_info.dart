import 'package:hive/hive.dart';

part 'remedy_info.g.dart';

@HiveType(typeId: 1)
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

  RemedyInfo({
    required this.remedyName,
    required this.remedyType,
    required this.treatment,
    required this.description,
    required this.remedyImages,
    required this.ingredients,
    required this.steps,
    required this.usage,
  });

  // Convert RemedyInfo object to a map
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
    };
  }

  // Create RemedyInfo object from a map
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
    );
  }
}
