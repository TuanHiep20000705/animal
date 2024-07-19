part of 'widgets.dart';

class BBSBaseButton extends StatelessWidget {
  final String text;
  final Color? colorTextButton;
  final bool loading;
  final Color? color;
  final Color? borderColor;
  final bool disable;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function()? onTap;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const BBSBaseButton({
    Key? key,
    required this.text,
    this.loading = false,
    this.color,
    this.disable = false,
    this.width,
    this.height,
    this.margin,
    this.onTap,
    this.padding,
    this.colorTextButton,
    this.borderColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height ?? 55,
      child: TweenAnimationBuilder<Color?>(
        duration: const Duration(milliseconds: 200),
        tween: ColorTween(
          begin:
              loading || disable ? AppColors.dark4 : color ?? AppColors.dark2,
          end: loading || disable ? AppColors.dark4 : color ?? AppColors.dark2,
        ),
        builder: (context, colorA, child) {
          return BBSGesture(
            onTap: (disable || loading)
                ? null
                : () {
                    if (onTap != null) {
                      FocusScope.of(context).unfocus();
                      onTap!();
                    }
                  },
            child: Container(
              width: width ?? double.maxFinite,
              padding: padding ?? EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color ?? AppColors.color2D92F5FF,
                borderRadius: borderRadius ?? BorderRadius.circular(20),
                border: Border.all(
                    color: borderColor ?? AppColors.color2D92F5FF, width: 2),
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  textAlign: TextAlign.center,
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    color: disable ? AppColors.dark3 : AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  child: loading
                      ? const CupertinoActivityIndicator(color: AppColors.dark2)
                      : Text(
                          text,
                          style: TextStyle(
                            color: colorTextButton ?? AppColors.dark2,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ButtonRounded extends StatelessWidget {
  final String? title;
  final Color? color;
  final Color? colorText;
  final double? widthButton;
  final VoidCallback? onPress;
  final BoxBorder? boxBorder;
  final String? image;
  final EdgeInsets? margin;

  const ButtonRounded(
    this.title, {
    Key? key,
    this.color,
    this.colorText,
    this.widthButton,
    this.onPress,
    this.boxBorder,
    this.image,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * (widthButton ?? 1);
    return Container(
      height: 55,
      width: width,
      margin: margin ?? const EdgeInsets.only(top: 10, bottom: 10),
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color ?? AppColors.dark2,
            border: boxBorder,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Constants.tsTitle16,
                      color: colorText ?? AppColors.dark,
                      fontWeight: FontWeight.w600),
                ),
              ),
              if (!(image == null || image!.isEmpty))
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: BBSImage(image),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
