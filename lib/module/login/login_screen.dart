import 'package:flutter/cupertino.dart';

import '../../routes/app_routes.dart';
import '../../shared/resources/resource.dart';
import '../../shared/resources/string.dart';
import '../../shared/utils/util.dart';
import '../../shared/widgets/widgets.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => BBSBaseScaffold(
        controller: LoginController(),
        initState: (controller) {},
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        builder: (controller) {
          return Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      const BBSText(
                          content: baseApp,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: AppColors.dark),
                      const Spacer(),
                      BBSBaseButton(
                        text: signUp,
                        color: AppColors.white,
                        borderColor: AppColors.dark,
                        width: 100,
                        borderRadius: BorderRadius.circular(40),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 200),
                  BBSField(
                    controller: controller.usernameController,
                    height: 70,
                    hint: username,
                    validation: (username) =>
                        controller.validateUsername(username),
                  ),
                  BBSField(
                    controller: controller.passwordController,
                    margin: const EdgeInsets.only(top: 10),
                    height: 70,
                    hint: password,
                    obscure: true,
                    validation: (password) =>
                        controller.validatePassword(password),
                  ),
                  BBSBaseButton(
                    margin: const EdgeInsets.only(top: 50),
                    text: signIn,
                    colorTextButton: AppColors.white,
                    onTap: () async {
                      await controller.login(onSuccess: () {
                        Navigators.push(context, AppRoutes.home, replace: true);
                      });
                    },
                  ),
                  BBSGesture(
                    onTap: () {},
                    child: const BBSText(
                      margin: EdgeInsets.only(top: 20),
                      content: forgetPassword,
                      textDecoration: TextDecoration.underline,
                      color: AppColors.dark,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
}
