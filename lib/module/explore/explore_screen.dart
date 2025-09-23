import 'package:base_project/module/explore/explore_controller.dart';
import 'package:base_project/shared/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ExploreController exploreController = ExploreController();

    return BBSBaseScaffold<ExploreController>(
      controller: exploreController,
      builder: (controller) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [BBSText(content: 'Explore screen')],
              ),
            ],
          ),
        );
      },
    );
  }
}
