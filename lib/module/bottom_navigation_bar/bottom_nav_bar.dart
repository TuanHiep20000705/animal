import 'package:base_project/module/explore/explore_screen.dart';
import 'package:base_project/module/explore/test.dart';
import 'package:base_project/module/favorite/favorite_screen.dart';
import 'package:base_project/module/recent/recent_screen.dart';
import 'package:base_project/module/setting/setting_screen.dart';
import 'package:base_project/shared/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../shared/resources/resource.dart';
import '../../shared/utils/util.dart';
import '../../shared/widgets/widgets.dart';
import 'bottom_nav_bar_controller.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  final BottomNavBarController controller = BottomNavBarController();
  late final TabController tabController;
  int currentPage = 0;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() => currentPage = tabController.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BBSBaseScaffold(
    padding: const EdgeInsets.only(top: 30),
    bottomNavigationBar: Container(
      height: context.viewInsets > 0 ? 0 : null,
      padding: EdgeInsets.only(
        bottom: context.paddingBottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.color221818.withOpacity(0.3),
            blurRadius: 25,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTabItem(0, Constants.icExplore, 'Explore'),
          buildTabItem(1, Constants.icRecent, 'Recent'),
          buildScanItem(Constants.icScan, 'Scan'),
          buildTabItem(2, Constants.icFavorite, 'Favorite'),
          buildTabItem(3, Constants.icSetting, 'Setting'),
        ],
      ),
    ),
    child: menuPages[currentPage],
  );

  Expanded buildTabItem(int i, String img, String title) {
    return Expanded(
      child: BBSGesture(
        padding: const EdgeInsets.all(10),
        onTap: () {
          tabController.animateTo(i);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BBSImage(
              img,
              height: 30,
              width: 30,
              color: i == currentPage
                  ? AppColors.colorFF34A853
                  : AppColors.colorFF4C4C4C,
              fit: BoxFit.scaleDown,
            ),
            BBSText(
              margin: const EdgeInsets.only(top: 5.0),
              content: title,
              color:
              i == currentPage ? AppColors.colorFF34A853 : AppColors.colorFF4C4C4C,
              fontSize: 10,
              fontFamily: 'lato_regular',
            )
          ],
        ),
      ),
    );
  }

  Expanded buildScanItem(String img, String title) {
    return Expanded(
      child: BBSGesture(
        padding: const EdgeInsets.all(10),
        onTap: () {
          Navigators.push(
            context,
            AppRoutes.scan,
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BBSImage(
              img,
              height: 30,
              width: 30,
              color: AppColors.colorFF4C4C4C,
              fit: BoxFit.scaleDown,
            ),
            BBSText(
              margin: const EdgeInsets.only(top: 5.0),
              content: title,
              color: AppColors.colorFF4C4C4C,
              fontSize: 10,
              fontFamily: 'lato_regular',
            )
          ],
        ),
      ),
    );
  }

  List<Widget> get menuPages =>
      [ ExploreScreen2(), const RecentScreen(), const FavoriteScreen(), const SettingScreen(),];
}
