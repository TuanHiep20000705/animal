class ConservationStatus {
  final String iUCNStatus;
  final String populationTrend;
  final List<String> threats;

  ConservationStatus({
    required this.iUCNStatus,
    required this.populationTrend,
    required this.threats,
  });

  factory ConservationStatus.fromJson(Map<String, dynamic> json) {
    return ConservationStatus(
      iUCNStatus: json['IUCNStatus'],
      populationTrend: json['PopulationTrend'],
      threats: json['Threats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IUCNStatus': iUCNStatus,
      'PopulationTrend': populationTrend,
      'Threats': threats,
    };
  }
}
