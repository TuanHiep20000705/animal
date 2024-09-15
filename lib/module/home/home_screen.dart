import 'package:base_project/module/global_state_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/widgets.dart';
import 'home_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();
    final globalController = context.read<GlobalStateController>();

    return BBSBaseScaffold<HomeController>(
      controller: homeController,
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BBSGesture(onTap: () { globalController.changeLanguage('vi'); },
                  child: BBSText(content: AppLocalizations.of(context)!.language))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
