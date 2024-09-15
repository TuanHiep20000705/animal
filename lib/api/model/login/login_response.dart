class LoginResponse {
  final String? accessToken;

  LoginResponse({required this.accessToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(accessToken: json['access_token']);
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken};
  }
}
