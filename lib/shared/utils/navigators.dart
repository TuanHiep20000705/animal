part of 'util.dart';

class Navigators {
  Navigators._();

  static Future push(
      BuildContext context,
      String path, {
        bool replace = false,
        Object? arguments,
        Function(dynamic result)? onResult,
      }) async {
    unFocus();
    final result = await AppRoutes.router.navigateTo(
      context,
      path,
      clearStack: replace,
      transition: TransitionType.cupertino,
      routeSettings: RouteSettings(arguments: arguments),
    );
    if (result != null) onResult?.call(result);
    return result;
  }

  static void pop<T>(BuildContext context, [T? result]) {
    unFocus();
    return AppRoutes.router.pop(context, result);
  }

  static showErrorDialog(
      String message, {
        int code = 0,
        bool isForceLogout = false,
        String? titleDialog,
      }) {
    showDialog(
      barrierDismissible: isForceLogout ? false : true,
      context: globalKey.currentContext!,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: code != 409
                    ? BBSText(
                  content:
                  titleDialog ?? errorTitle,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  margin: const EdgeInsets.all(15),
                )
                    : Container(),
              ),
              BBSText(
                padding: const EdgeInsets.all(20),
                content: message,
                textAlign: TextAlign.center,
              ),
              ButtonRounded(
                close,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                onPress: () async {
                  Navigators.pop(context);
                },
                color: AppColors.white,
                colorText: AppColors.colorBlue,
              ),
            ],
          ),
        );
      },
    );
  }

  static showTokenExpiredDialog() {
    Shared.doLogout();
    showDialog(
      barrierDismissible: false,
      context: globalKey.currentContext!,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            backToLogin(context);
            return false;
          },
          child: Dialog(
            alignment: Alignment.center,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BBSText(
                  padding: EdgeInsets.all(20),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  content: tokenExpired,
                ),
                ButtonRounded(
                  close,
                  margin:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  onPress: () {
                    backToLogin(context);
                  },
                  color: AppColors.white,
                  colorText: AppColors.colorBlue,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showCompleteDialog(
      String message, String title, {
        Function? callBack,
      }) {
    showDialog(
      barrierDismissible: false,
      context: globalKey.currentContext!,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            alignment: Alignment.center,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: BBSText(
                    content: title,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    margin: EdgeInsets.all(15),
                  ),
                ),
                BBSText(
                  padding: const EdgeInsets.all(20),
                  content: message,
                ),
                ButtonRounded(
                  close,
                  margin:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  onPress: () {
                    Navigators.pop(context);
                    if (callBack != null) callBack.call();
                  },
                  color: AppColors.white,
                  colorText: AppColors.colorBlue,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future showBottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool scrollController = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: AppColors.transparent,
      elevation: 0,
      useSafeArea: true,
      isScrollControlled: scrollController,
      builder: builder,
    );
  }

  static backToLogin(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen()),
            (Route<dynamic> route) => false);
  }

  static showDeleteDialog(
      String message, {
        Function? yesCallBack,
      }) {
    showDialog(
      barrierDismissible: false,
      context: globalKey.currentContext!,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            alignment: Alignment.center,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: BBSText(
                    content: notificationTitle,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    margin: const EdgeInsets.all(15),
                    color: AppColors.dark.withOpacity(0.7),
                  ),
                ),
                BBSText(
                  padding: const EdgeInsets.all(20),
                  content: message,
                  color: AppColors.dark.withOpacity(0.7),
                ),
                ButtonRounded(
                  yes,
                  margin:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  onPress: () {
                    Navigators.pop(context);
                    if (yesCallBack != null) yesCallBack.call();
                  },
                  color: AppColors.white,
                  colorText: AppColors.colorBlue,
                ),
                ButtonRounded(
                  close,
                  margin:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  onPress: () {
                    Navigators.pop(context);
                  },
                  color: AppColors.errorFieldBackground,
                  colorText: AppColors.colorDB3E34,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}