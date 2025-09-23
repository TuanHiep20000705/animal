import 'package:base_project/module/favorite/favorite_controller.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/widgets/widgets.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteController favoriteController = FavoriteController();

    return BBSBaseScaffold<FavoriteController>(
      controller: favoriteController,
      builder: (controller) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [BBSText(content: 'Favorite screen')],
              ),
            ],
          ),
        );
      },
    );
  }
}
