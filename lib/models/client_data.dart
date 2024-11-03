import 'package:hive/hive.dart';

part 'client_data.g.dart'; 
@HiveType(typeId: 3) 
class ClientData {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String imagePath;

  @HiveField(3)
  final DateTime createdAt;

  ClientData({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.createdAt,
  });
}
