class PhysicalTraits {
  final String size;
  final String weight;
  final String color;
  final String lifespan;
  final List<String> specialTraits;

  PhysicalTraits({
    required this.size,
    required this.weight,
    required this.color,
    required this.lifespan,
    required this.specialTraits,
  });

  factory PhysicalTraits.fromJson(Map<String, dynamic> json) {
    return PhysicalTraits(
      size: json['Size'],
      weight: json['Weight'],
      color: json['Color'],
      lifespan: json['Lifespan'],
      specialTraits: json['SpecialTraits'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Size': size,
      'Weight': weight,
      'Color': color,
      'Lifespan': lifespan,
      'SpecialTraits': specialTraits,
    };
  }
}
