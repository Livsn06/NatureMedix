import 'package:hive/hive.dart';

part 'client_data.g.dart';

@HiveType(typeId: 3)
class ClientData extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final List<String> imagePaths;

  @HiveField(3)
  final DateTime createdAt;

  ClientData({
    required this.title,
    required this.description,
    required this.imagePaths,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imagePaths': imagePaths,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ClientData.fromMap(Map<String, dynamic> map) {
    return ClientData(
      title: map['title'],
      description: map['description'],
      imagePaths: List<String>.from(map['imagePaths']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
