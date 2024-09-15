import 'package:fluro/fluro.dart';

import '../module/home/home_screen.dart';
import '../module/login/login_screen.dart';

class AppRoutes {
  static const root = '/';
  static const login = '/login';
  static const home = '/home';

  static final router = FluroRouter();

  static void init() {
    router.define(
      root,
      handler: Handler(
        handlerFunc: (context, params) => const HomeScreen(),
      ),
    );

    router.define(
      login,
      handler: Handler(
        handlerFunc: (context, params) => const LoginScreen(),
      ),
    );
  }
}