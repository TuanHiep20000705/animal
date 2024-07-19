part of 'widgets.dart';

class BBSGesture extends StatefulWidget {
  final Function()? onTap;
  final Widget child;
  final bool animation;
  final EdgeInsets padding;
  final bool needToUnFocus;

  const BBSGesture({
    Key? key,
    required this.onTap,
    required this.child,
    this.animation = true,
    this.padding = EdgeInsets.zero,
    this.needToUnFocus = true
  }) : super(key: key);

  @override
  State<BBSGesture> createState() => _BBSGestureState();
}

class _BBSGestureState extends State<BBSGesture> {
  bool pressed = false;

  void pressUpdated({required bool pressed}) {
    if (widget.onTap == null) return;
    setState(() => this.pressed = pressed);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (widget.needToUnFocus) {
          unFocus();
        }
        widget.onTap?.call();
      },
      onPanDown: (s) => pressUpdated(pressed: true),
      onPanEnd: (s) => pressUpdated(pressed: false),
      onPanCancel: () => pressUpdated(pressed: false),
      child: Padding(
        padding: widget.padding,
        child: AnimatedOpacity(
          opacity: widget.animation
              ? pressed
              ? 0.6
              : 1
              : 1,
          duration: const Duration(milliseconds: 200),
          child: widget.child,
        ),
      ),
    );
  }
}
