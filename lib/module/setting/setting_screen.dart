import 'package:base_project/module/setting/setting_controller.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/widgets/widgets.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingController settingController = SettingController();

    return BBSBaseScaffold<SettingController>(
      controller: settingController,
      builder: (controller) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [BBSText(content: 'Setting screen')],
              ),
            ],
          ),
        );
      },
    );
  }
}
