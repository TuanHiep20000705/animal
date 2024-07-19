import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> globalKey = GlobalKey();

void unFocus() => FocusManager.instance.primaryFocus?.unfocus();