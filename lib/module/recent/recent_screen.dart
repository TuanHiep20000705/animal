import 'package:base_project/module/recent/recent_controller.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/widgets/widgets.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RecentController recentController = RecentController();

    return BBSBaseScaffold<RecentController>(
      controller: recentController,
      builder: (controller) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [BBSText(content: 'Recent screen')],
              ),
            ],
          ),
        );
      },
    );
  }
}
