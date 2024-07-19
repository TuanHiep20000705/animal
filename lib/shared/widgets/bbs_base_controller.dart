import 'package:flutter/cupertino.dart';

class BBSBaseController extends ChangeNotifier {
  late final BuildContext context;
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
  void update(Function update) {
    update();
    notifyListeners();
  }
}