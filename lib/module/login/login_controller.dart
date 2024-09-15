import 'package:base_project/api/model/login/login_response.dart';
import 'package:base_project/api/repository/auth_repository.dart';
import 'package:base_project/shared/widgets/bbs_base_controller.dart';
import 'package:flutter/material.dart';

import '../../shared/resources/string.dart';
import '../../shared/utils/util.dart';

class LoginController extends BBSBaseController {
  final _authRepository = AuthRepository();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateUsername(String? username) {
    if (username == null || username.isEmpty || username.trim().isEmpty) {
      return emptyField;
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty || password.trim().isEmpty) {
      return emptyField;
    }
    if (password.trim().contains(' ')) {
      return whiteSpaceFormat;
    }
    return null;
  }

  Future login({required Function() onSuccess}) async {
    final isValid = formKey.currentState?.validate();
    if (isValid == true) {
      final response = await _authRepository.login(
          usernameController.text, passwordController.text);
      if (response.statusCode == 200) {
        LoginResponse loginResponse =
            LoginResponse.fromJson(response.data['data']);
        if (!(loginResponse.accessToken == null ||
            loginResponse.accessToken!.isEmpty)) {
          Shared.setAccessToken(loginResponse.accessToken!);
        }
      }
    }
  }
}
