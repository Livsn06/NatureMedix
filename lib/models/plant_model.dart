class PlantBasicInfo {
  final String plantName;
  final String scientificName;
  final String plantImage;
  final String description;

  PlantBasicInfo({
    required this.plantName,
    required this.scientificName,
    required this.plantImage,
    required this.description,
  });
}

class RemedyInfo {
  final String remedyName;
  final String remedyType;
  final String description;
  final String remedyImage;
  final List<String> treatments;

  RemedyInfo({
    required this.remedyName,
    required this.remedyType,
    required this.description,
    required this.remedyImage,
    required this.treatments,
  });
}
