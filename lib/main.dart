import 'package:flutter/material.dart';

import 'module/home_screen.dart';
import 'routes/app_routes.dart';
import 'shared/utils/util.dart';

main() {
  runApp(
    MaterialApp(
      navigatorKey: globalKey,
      initialRoute: AppRoutes.root,
      onGenerateRoute: AppRoutes.router.generator,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
      ),
    ),
  );
}
