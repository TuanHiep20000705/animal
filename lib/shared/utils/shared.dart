part of 'util.dart';

class Shared {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String getAccessToken() {
    return _preferences!.getString(Constants.keyAccessToken) ?? "";
  }

  static Future<void> setAccessToken(String token) async {
    await _preferences!.setString(Constants.keyAccessToken, token);
  }

  static doLogout() async {
    _preferences!
        .remove(Constants.keyAccessToken);
  }
}