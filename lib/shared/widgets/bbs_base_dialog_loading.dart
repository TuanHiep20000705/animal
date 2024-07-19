part of 'widgets.dart';

class BBSBaseDialogLoading {
  BBSBaseDialogLoading._();

  static void show(BuildContext context) {
    // FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      barrierDismissible: false,
      routeSettings: const RouteSettings(name: 'dialog-loading'),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Align(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const CupertinoActivityIndicator(
                radius: 16,
                color: AppColors.colorProcessBar,
              ),
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    return Navigator.of(context).popUntil(
      (route) => route.settings.name != 'dialog-loading',
    );
  }
}
