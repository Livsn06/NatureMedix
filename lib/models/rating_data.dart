import 'package:hive/hive.dart';

part 'rating_data.g.dart';

@HiveType(typeId: 2)
class RatingData extends HiveObject {
  @HiveField(0)
  final String plantName;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final double rating;

  RatingData({
    required this.plantName,
    required this.userId,
    required this.rating,
  });
}
