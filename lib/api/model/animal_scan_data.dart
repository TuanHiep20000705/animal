class AnimalScanData {
  final int? id;
  final String? imageHome;
  final String? imagePath;
  final AnimalScanData animalScanData;
  final String? dateTime;
  final AnimalActionType animalActionType;
  final bool isHistory;
  final bool isFavorite;

  AnimalScanData({
    required this.id,
    required this.imageHome,
    required this.imagePath,
    required this.animalScanData,
    required this.dateTime,
    required this.animalActionType,
    required this.isHistory,
    required this.isFavorite
  });

  factory AnimalScanData.fromJson(Map<String, dynamic> json) {
    return AnimalScanData(
      id: json['Id'],
      imageHome: json['ImageHome'],
      imagePath: json['ImagePath'],
      animalScanData: json['AnimalScanData'],
      dateTime: json['DateTime'],
      animalActionType: json['AnimalActionType'],
      isHistory: json['IsHistory'],
      isFavorite: json['IsFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'ImageHome': imageHome,
      'ImagePath': imagePath,
      'AnimalScanData': animalScanData,
      'DateTime': dateTime,
      'AnimalActionType': animalActionType,
      'IsHistory': isHistory,
      'IsFavorite': isFavorite
    };
  }
}

enum AnimalActionType {
  explore,
  analyze
}