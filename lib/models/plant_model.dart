class PlantBasicInfo {
  final String plantName;
  final String scientificName;
  final String plantImage;
  final String description;
  final List<String> treatments;
  final List<String> remedy;

  PlantBasicInfo({
    required this.plantName,
    required this.scientificName,
    required this.plantImage,
    required this.description,
    required this.treatments,
    required this.remedy,
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

class PlantData {
  final PlantBasicInfo plantBasicInfo;
  final RemedyInfo remedyInfo;
  final List<String> ingredients;
  final List<String> steps;

  PlantData({
    required this.plantBasicInfo,
    required this.remedyInfo,
    required this.ingredients,
    required this.steps,
  });
}
