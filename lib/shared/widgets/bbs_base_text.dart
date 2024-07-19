part of 'widgets.dart';

class BBSText extends StatelessWidget {
  final String? content;
  final double? fontSize;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final Color? color;
  final int? lines;
  final double? opacity;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final Decoration? decoration;
  final Function()? onTap;
  final double? width;

  const BBSText({
    Key? key,
    required this.content,
    this.fontSize,
    this.lineHeight,
    this.fontWeight,
    this.color,
    this.lines,
    this.overflow,
    this.padding,
    this.margin,
    this.textAlign,
    this.textDecoration,
    this.opacity,
    this.fontStyle,
    this.decoration,
    this.onTap,
    this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: decoration,
        width: width,
        child: Opacity(
          opacity: opacity ?? 1.0,
          child: Text(
            content ?? "",
            maxLines: lines,
            textAlign: textAlign ?? TextAlign.start,
            overflow: overflow ?? TextOverflow.visible,
            style: TextStyle(
              fontStyle: fontStyle,
              fontSize: fontSize ?? 20,
              fontFamily:'Quicksand',
              fontWeight: fontWeight ?? FontWeight.w400,
              color: color ?? AppColors.grey,
              height: lineHeight,
              decoration: textDecoration ?? TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
