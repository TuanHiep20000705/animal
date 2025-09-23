class HumanInteraction {
  final String dangerLevel;
  final bool petFriendly;
  final String legalStatus;
  final String notes;

  HumanInteraction({
    required this.dangerLevel,
    required this.petFriendly,
    required this.legalStatus,
    required this.notes,
  });

  factory HumanInteraction.fromJson(Map<String, dynamic> json) {
    return HumanInteraction(
      dangerLevel: json['DangerLevel'],
      petFriendly: json['PetFriendly'],
      legalStatus: json['LegalStatus'],
      notes: json['Notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DangerLevel': dangerLevel,
      'PetFriendly': petFriendly,
      'LegalStatus': legalStatus,
      'Notes': notes,
    };
  }
}
