part of 'widgets.dart';

class BBSImage extends StatelessWidget {
  final String? url;
  final double? height;
  final double? width;
  final double radius;
  final bool isImagePicker;
  final BoxFit fit;
  final Color? color;
  final EdgeInsets? padding;
  final Function()? onTap;

  const BBSImage(this.url,
      {Key? key,
      this.height,
      this.width,
      this.radius = 8,
      this.fit = BoxFit.cover,
      this.isImagePicker = false,
      this.color,
      this.padding = EdgeInsets.zero,
      this.onTap})
      : super(key: key);

  Widget buildPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: AppColors.white,
      period: const Duration(milliseconds: 800),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget buildError() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        Constants.icHome,
        height: height,
        width: width,
      ),
    );
  }

  bool get isLocal => !Uri.parse(url ?? '').isAbsolute;

  Widget buildSVG() {
    if (isLocal) {
      return SvgPicture.asset(
        url!,
        height: height,
        width: width,
        color: color,
        placeholderBuilder: (context) => buildPlaceholder(),
      );
    } else {
      return SvgPicture.network(
        url!,
        height: height,
        width: width,
        color: color,
        placeholderBuilder: (context) => buildPlaceholder(),
      );
    }
  }

  Widget buildPathImage() {
    return Image.file(File(url!), height: height, width: width, fit: fit);
  }

  Widget buildImage() {
    if (isLocal) {
      return Image.asset(
        url!,
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: (context, e, s) => buildError(),
      );
    } else {
      return CachedNetworkImage(
          imageUrl: url!,
          height: height,
          width: width,
          fit: fit,
          color: color,
          placeholder: (context, s) => buildPlaceholder(),
          errorWidget: (context, s, e) => buildError());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) return buildError();
    final isSvg = url!.split('.').last == 'svg';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: padding!,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isSvg ? 0 : radius),
          child: isImagePicker
              ? buildPathImage()
              : isSvg
                  ? buildSVG()
                  : buildImage(),
        ),
      ),
    );
  }
}
