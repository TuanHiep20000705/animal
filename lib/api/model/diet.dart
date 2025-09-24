class Diet {
  final String type;
  final List<String> foods;

  Diet(
      {required this.type,
        required this.foods,});

  factory Diet.fromJson(Map<String, dynamic> json) {
    return Diet(
      type: json['Type'],
      foods: json['Foods'],);
  }

  Map<String, dynamic> toJson() {
    return {
      'Type': type,
      'Foods': foods,
    };
  }
}
