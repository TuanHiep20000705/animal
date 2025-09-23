import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../module/login/login_screen.dart';
import '../../routes/app_routes.dart';
import '../resources/resource.dart';
import '../resources/string.dart';
import '../widgets/widgets.dart';

part 'shared.dart';
part 'navigators.dart';

final GlobalKey<NavigatorState> globalKey = GlobalKey();

void unFocus() => FocusManager.instance.primaryFocus?.unfocus();

Future<bool> isNetworkConnected() async {
  final List<ConnectivityResult> connectivityResult =
  await Connectivity().checkConnectivity();

  if (connectivityResult.contains(ConnectivityResult.none)) {
    return false;
  }
  return true;
}