import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:growmatic/utils/app_colors.dart';
import 'package:growmatic/utils/app_images.dart';
import 'package:growmatic/utils/app_string.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final int? maxLines;
  final bool? enable;
  final bool? autoFocus;
  final Color? fillColor;
  final Color? hintTextColor;
  final Function? focusChange;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? readOnly;
  final GestureTapCallback? onTap;
  final String? prefixIcon;
  final double? maxWidth;

  const TextFormFieldWidget({
    Key? key,
    this.hintText,
    this.style,
    this.hintStyle,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.obscureText,
    this.maxLines,
    this.enable,
    this.autoFocus,
    this.fillColor,
    this.hintTextColor,
    this.focusChange,
    this.padding,
    this.margin,
    this.contentPadding,
    this.readOnly,
    this.maxWidth,
    this.prefixIcon,
    this.onTap,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.r),
        border: Border.all(color: AppColors.appColor),
      ),
      child: Row(
        children: [
          Image.asset(
            prefixIcon ?? '',
            height: 26.h,
            width: 26.w,
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              focusNode: focusNode,
              onFieldSubmitted: onFieldSubmitted,
              maxLines: maxLines ?? 1,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.blackColor.withOpacity(0.4))),
              cursorColor: AppColors.appColor,
            ),
          )
        ],
      ),
    );
  }
}
