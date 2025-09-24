class Behavior {
  final String activityTime;
  final String socialType;
  final String intelligenceLevel;
  final String communication;

  Behavior({
    required this.activityTime,
    required this.socialType,
    required this.intelligenceLevel,
    required this.communication,
  });

  factory Behavior.fromJson(Map<String, dynamic> json) {
    return Behavior(
      activityTime: json['ActivityTime'],
      socialType: json['SocialType'],
      intelligenceLevel: json['IntelligenceLevel'],
      communication: json['Communication'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ActivityTime': activityTime,
      'SocialType': socialType,
      'IntelligenceLevel': intelligenceLevel,
      'Communication': communication,
    };
  }
}
