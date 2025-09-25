import 'package:base_project/api/model/animal_info.dart';

class AnimalScanData {
  final int? id;
  final String? imageHome;
  final String? imagePath;
  final AnimalInfo animalInfo;
  final String? dateTime;
  final AnimalActionType animalActionType;
  final bool isHistory;
  final bool isFavorite;

  AnimalScanData({
    required this.id,
    required this.imageHome,
    required this.imagePath,
    required this.animalInfo,
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
      animalInfo: json['AnimalInfo'],
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
      'AnimalInfo': animalInfo,
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