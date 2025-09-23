import 'package:base_project/module/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:base_project/module/scan/scan_screen.dart';
import 'package:fluro/fluro.dart';

import '../module/login/login_screen.dart';

class AppRoutes {
  static const root = '/';
  static const login = '/login';
  static const home = '/home';
  static const scan = '/scan';

  static final router = FluroRouter();

  static void init() {
    router.define(
      home,
      handler: Handler(
        handlerFunc: (context, params) => const BottomNavBar(),
      ),
    );

    router.define(
      login,
      handler: Handler(
        handlerFunc: (context, params) => const LoginScreen(),
      ),
    );

    router.define(
      scan,
      handler: Handler(
        handlerFunc: (context, params) => const ScanScreen(),
      ),
    );
  }
}