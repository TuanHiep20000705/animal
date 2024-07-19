part of 'widgets.dart';

class BBSField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String? txt)? onChange;
  final Function()? onTap;
  final Color fillColor;
  final String? hint;
  final Color? hintColor;
  final String? label;
  final bool readOnly;
  final bool enabled;
  final bool isValidationFail;
  final int maxLines;
  final String? suffixIcon;
  final Function()? suffixTap;
  final bool obscure;
  final TextInputAction inputAction;
  final TextCapitalization capitalization;
  final bool autoFocus;
  final TextInputType? type;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? margin;
  final String? Function(String? value)? validation;
  final FontWeight labelFontWeight;
  final double spaceWithInput;
  final bool isRow;
  final bool showObscure;
  final double height;

  const BBSField(
      {Key? key,
      this.controller,
      this.onChange,
      this.onTap,
      this.fillColor = AppColors.colorF8F7F7,
      this.hint,
      this.hintColor,
      this.label,
      this.readOnly = false,
      this.enabled = true,
      this.isValidationFail = false,
      this.maxLines = 1,
      this.suffixIcon,
      this.suffixTap,
      this.obscure = false,
      this.inputAction = TextInputAction.next,
      this.capitalization = TextCapitalization.none,
      this.autoFocus = false,
      this.type,
      this.autofillHints,
      this.inputFormatters,
      this.margin,
      this.validation,
      this.labelFontWeight = FontWeight.bold,
      this.spaceWithInput = 4,
      this.isRow = false,
      this.showObscure = false,
      this.height = 20})
      : super(key: key);

  @override
  State<BBSField> createState() => _BBSFieldState();
}

class _BBSFieldState extends State<BBSField> {
  bool obscure = false;

  @override
  void initState() {
    obscure = widget.obscure;
    super.initState();
  }

  Color get disableColor => widget.enabled ? AppColors.dark : AppColors.dark3;

  Widget? get buildSuffix {
    Widget? child;
    if (widget.obscure) {
      child = obscure ? const BBSImage(Constants.icHide, color: AppColors.dark2, height: 20, width: 20, fit: BoxFit.scaleDown)
      : const Icon(Icons.remove_red_eye, color: AppColors.dark2, size: 20);
    } else if (widget.suffixIcon != null || widget.onTap != null) {
      child = BBSImage(
        widget.suffixIcon ?? Constants.icHome,
        width: widget.suffixIcon != null ? 18 : 8,
        height: widget.suffixIcon != null ? 18 : 8,
        color: widget.hintColor ?? disableColor.withOpacity(0.8),
      );
    }
    if (child == null) return null;
    return Align(
      alignment: Alignment.center,
      child: BBSGesture(
        onTap: () {
          if (widget.obscure) setState(() => obscure = !obscure);
          widget.suffixTap?.call() ?? widget.onTap?.call();
        },
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> commonChildren = [
      if (widget.label != null)
        BBSText(
          content: widget.label!,
          margin: EdgeInsets.only(top: widget.isRow ? 14 : 0),
        ),
      if (widget.label != null)
        SizedBox(
          height: widget.isRow ? null : widget.spaceWithInput,
          width: widget.isRow ? widget.spaceWithInput : null,
        ),
      Container(
        height: widget.height,
        margin: widget.margin,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: TextFormField(
              onTap: widget.onTap,
              onChanged: widget.onChange,
              controller: widget.controller,
              readOnly: widget.readOnly,
              enabled: widget.onTap == null && widget.enabled,
              maxLines: widget.maxLines,
              obscureText: obscure,
              textInputAction: widget.inputAction,
              textCapitalization: widget.capitalization,
              keyboardType: widget.type,
              autofocus: widget.autoFocus,
              style: TextStyle(
                color: widget.hintColor ?? disableColor,
              ),
              cursorColor: AppColors.color221818,
              autofillHints: widget.autofillHints,
              enableSuggestions: true,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                filled: true,
                isDense: true,
                fillColor: widget.isValidationFail
                    ? AppColors.errorFieldBackground
                    : widget.enabled
                        ? widget.fillColor
                        : AppColors.colorDDD8D8,
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  fontSize: 15,
                  color: AppColors.colorB4ACAD,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 20,
                ),
                prefix: const SizedBox(width: 20),
                errorStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                errorMaxLines: 2,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: widget.isValidationFail
                          ? AppColors.colorDB3E34
                          : AppColors.colorDDD8D8),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: widget.isValidationFail
                          ? AppColors.colorDB3E34
                          : AppColors.colorDDD8D8),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: widget.isValidationFail
                        ? AppColors.colorDB3E34
                        : AppColors.colorDDD8D8,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: AppColors.colorDB3E34,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: AppColors.colorDB3E34,
                    width: 1,
                  ),
                ),
                suffixIcon: buildSuffix,
                suffixIconConstraints: const BoxConstraints(maxWidth: 48),
              ),
              validator: widget.validation,
            )),
            if (widget.showObscure) ...[
              const SizedBox(
                width: 5,
              ),
              BBSGesture(
                onTap: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.colorF8F7F7),
                  child: const BBSImage(
                    Constants.icHome,
                    padding: EdgeInsets.all(15),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    ];

    if (widget.isRow) {
      commonChildren = commonChildren.map(
        (item) {
          if (item.runtimeType == Container) {
            return Expanded(child: item);
          }

          if (item.runtimeType == BBSText) {
            return SizedBox(width: 45, child: item);
          }

          return item;
        },
      ).toList();
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: widget.isRow
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: commonChildren,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: commonChildren,
            ),
    );
  }
}
