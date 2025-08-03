import 'package:package_info_plus/package_info_plus.dart';

enum EnvironmentType {
  dev(
    apiBaseUrl: 'https://octopus-app-9kaev.ondigitalocean.app/',
    test: 'dev'
  ),
  product(
    apiBaseUrl: 'https://octopus-app-9kaev.ondigitalocean.app/',
    test: 'product'
  );

  const EnvironmentType({
    required this.apiBaseUrl,
    required this.test
  });

  final String apiBaseUrl;
  final String test;
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
      case "com.devmai.aianimal.animalidentifier.product":
        _current = EnvironmentType.product;
        break;
      default:
        _current = EnvironmentType.dev;
    }
    return _current!;
  }
}