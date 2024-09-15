import 'package:package_info_plus/package_info_plus.dart';

enum EnvironmentType {
  dev(
    apiBaseUrl: 'https://octopus-app-9kaev.ondigitalocean.app/',
  ),
  product(
    apiBaseUrl: 'https://octopus-app-9kaev.ondigitalocean.app/',
  );

  const EnvironmentType({
    required this.apiBaseUrl,
  });

  final String apiBaseUrl;
}

class AppConfig {
  static EnvironmentType? _current;

  static EnvironmentType get buildType => _current!;

  static Future<EnvironmentType> current() async {
    if (_current != null) {
      return _current!;
    }
    final packageInfo = await PackageInfo.fromPlatform();
    switch (packageInfo.packageName) {
      case "com.example.base_project":
        _current = EnvironmentType.dev;
        break;
      default:
        _current = EnvironmentType.product;
    }
    return _current!;
  }
}