import 'dart:convert';
import 'animal_info.dart';

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
    this.id,
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

  factory AnimalScanData.fromMap(Map<String, dynamic> map) {
    return AnimalScanData(
      id: map['Id'],
      imageHome: map['ImageHome'],
      imagePath: map['ImagePath'],
      animalInfo: AnimalInfo.fromJson(jsonDecode(map['AnimalInfo'])),
      dateTime: map['DateTime'],
      animalActionType: AnimalActionTypeExt.fromString(map['AnimalActionType']),
      isHistory: map['IsHistory'] == 1,
      isFavorite: map['IsFavorite'] == 1,
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

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'ImageHome': imageHome,
      'ImagePath': imagePath,
      'AnimalInfo': jsonEncode(animalInfo.toJson()),
      'DateTime': dateTime,
      'AnimalActionType': animalActionType.value,
      'IsHistory': isHistory ? 1 : 0,
      'IsFavorite': isFavorite ? 1 : 0
    };
  }
}

enum AnimalActionType {
  explore,
  analyze
}

extension AnimalActionTypeExt on AnimalActionType {
  String get value => toString().split('.').last;

  static AnimalActionType fromString(String str) {
    return AnimalActionType.values
        .firstWhere((e) => e.toString().split('.').last == str);
  }
}