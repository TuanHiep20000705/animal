class Classification {
  final String kingdom;
  final String phylum;
  final String clazz;
  final String order;
  final String family;
  final String genus;
  final String species;

  Classification(
      {required this.kingdom,
      required this.phylum,
      required this.clazz,
      required this.order,
      required this.family,
      required this.genus,
      required this.species});

  factory Classification.fromJson(Map<String, dynamic> json) {
    return Classification(
        kingdom: json['Kingdom'],
        phylum: json['Phylum'],
        clazz: json['Class'],
        order: json['Order'],
        family: json['Family'],
        genus: json['Genus'],
        species: json['Species']);
  }

  Map<String, dynamic> toJson() {
    return {
      'Kingdom': kingdom,
      'Phylum': phylum,
      'Class': clazz,
      'Order': order,
      'Family': family,
      'Genus': genus,
      'Species': species,
    };
  }
}
