// import 'package:base_project/l10n/l10n.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/app_config.dart';
import 'module/global_state_controller.dart';
import 'module/home/home_screen.dart';
import 'routes/app_routes.dart';
import 'shared/utils/util.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.current();
  await Shared.init();
  AppRoutes.init();

  Widget startRouter() {
    return const HomeScreen();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalStateController())
      ],
      child: Consumer<GlobalStateController>(
        builder: (context, globalController, child) {
          return MaterialApp(
            navigatorKey: globalKey,
            initialRoute: AppRoutes.home,
            onGenerateRoute: AppRoutes.router.generator,
            debugShowCheckedModeBanner: false,
            home: startRouter(),
            theme: ThemeData(
              dialogTheme: const DialogThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
            ),
            // supportedLocales: L10n.all,
            locale: globalController.locale,
            // localizationsDelegates: const [
            //   AppLocalizations.delegate,
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            // ],
          );
        },
      ),
    ),
  );
}
