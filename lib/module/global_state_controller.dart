import 'package:flutter/cupertino.dart';

import '../shared/widgets/bbs_base_controller.dart';

class GlobalStateController extends BBSBaseController {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  String _languageCode = 'en';

  void changeLanguage(String languageCode) {
    _languageCode = _languageCode == 'en' ? 'vi' : 'en';
    _locale = Locale(_languageCode);
    notifyListeners();
  }
}