part of 'widgets.dart';

class BBSAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool hasBackButton;
  final Widget child;
  final Color backgroundColor;

  const BBSAppbar({
    Key? key,
    this.title,
    this.actions,
    this.onBackPressed,
    this.hasBackButton = true,
    this.backgroundColor = AppColors.white,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      color: backgroundColor,
      child: child,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
