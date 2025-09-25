import 'package:base_project/api/model/physical_traits.dart';
import 'package:base_project/api/model/reproduction.dart';

import 'behavior.dart';
import 'classification.dart';
import 'conservation_status.dart';
import 'diet.dart';
import 'habitat.dart';
import 'human_interaction.dart';

class AnimalInfo {
  final String commonName;
  final String scientificName;
  final List<String> otherNames;
  final Classification classification;
  final Habitat habitat;
  final PhysicalTraits physicalTraits;
  final Diet diet;
  final Behavior behavior;
  final Reproduction reproduction;
  final ConservationStatus conservationStatus;
  final HumanInteraction humanInteraction;
  final List<String> funFacts;

  AnimalInfo({
    required this.commonName,
    required this.scientificName,
    required this.otherNames,
    required this.classification,
    required this.habitat,
    required this.physicalTraits,
    required this.diet,
    required this.behavior,
    required this.reproduction,
    required this.conservationStatus,
    required this.humanInteraction,
    required this.funFacts,
  });

  factory AnimalInfo.fromJson(Map<String, dynamic> json) {
    return AnimalInfo(
      commonName: json['CommonName'],
      scientificName: json['ScientificName'],
      otherNames: List<String>.from(json['OtherNames'] ?? []),
      classification: Classification.fromJson(json['Classification']),
      habitat: Habitat.fromJson(json['Habitat']),
      physicalTraits: PhysicalTraits.fromJson(json['PhysicalTraits']),
      diet: Diet.fromJson(json['Diet']),
      behavior: Behavior.fromJson(json['Behavior']),
      reproduction: Reproduction.fromJson(json['Reproduction']),
      conservationStatus: ConservationStatus.fromJson(json['ConservationStatus']),
      humanInteraction: HumanInteraction.fromJson(json['HumanInteraction']),
      funFacts: List<String>.from(json['FunFacts'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CommonName': commonName,
      'ScientificName': scientificName,
      'OtherNames': otherNames,
      'Classification': classification,
      'Habitat': habitat,
      'PhysicalTraits': physicalTraits,
      'Diet': diet,
      'Behavior': behavior,
      'Reproduction': reproduction,
      'ConservationStatus': conservationStatus,
      'HumanInteraction': humanInteraction,
      'FunFacts': funFacts,
    };
  }
}
