class Reproduction {
  final String maturityAge;
  final String gestationPeriod;
  final String offspringPerBirth;
  final String reproductionCycle;

  Reproduction({
    required this.maturityAge,
    required this.gestationPeriod,
    required this.offspringPerBirth,
    required this.reproductionCycle,
  });

  factory Reproduction.fromJson(Map<String, dynamic> json) {
    return Reproduction(
      maturityAge: json['MaturityAge'],
      gestationPeriod: json['GestationPeriod'],
      offspringPerBirth: json['OffspringPerBirth'],
      reproductionCycle: json['ReproductionCycle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaturityAge': maturityAge,
      'GestationPeriod': gestationPeriod,
      'OffspringPerBirth': offspringPerBirth,
      'ReproductionCycle': reproductionCycle,
    };
  }
}
