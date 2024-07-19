import 'package:fluro/fluro.dart';

import '../module/home_screen.dart';

class AppRoutes {
  static const root = '/';
  static const home = '/home';

  static final router = FluroRouter();

  static void init() {
    router.define(
      root,
      handler: Handler(
        handlerFunc: (context, params) => const HomeScreen(),
      ),
    );
  }
}