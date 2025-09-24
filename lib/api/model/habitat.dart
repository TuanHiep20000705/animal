class Habitat {
  final String environment;
  final String distribution;
  final List<String> countries;

  Habitat(
      {required this.environment,
        required this.distribution,
        required this.countries,});

  factory Habitat.fromJson(Map<String, dynamic> json) {
    return Habitat(
      environment: json['Environment'],
      distribution: json['Distribution'],
      countries: json['Countries'],);
  }

  Map<String, dynamic> toJson() {
    return {
      'Environment': environment,
      'Distribution': distribution,
      'Countries': countries,
    };
  }
}
