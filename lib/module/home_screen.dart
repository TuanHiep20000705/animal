import 'package:flutter/cupertino.dart';
import '../shared/widgets/widgets.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();
    return BBSBaseScaffold<HomeController>(
      controller: homeController,
      builder: (controller) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BBSText(content: 'Home screen')
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
