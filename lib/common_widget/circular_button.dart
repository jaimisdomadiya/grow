import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:growmatic/utils/app_colors.dart';

class CircularButton extends StatelessWidget {
  const CircularButton(
      {Key? key,
      required this.label,
      this.height,
      this.margin,
      this.padding,
      this.onPressed,
      this.width,
      this.gradientColors,
      this.radius,
      this.alignment,
      this.isLoaderShow,
      this.labelStyle})
      : super(key: key);

  final String label;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final GestureTapCallback? onPressed;
  final TextStyle? labelStyle;
  final double? height;
  final double? width;
  final double? radius;
  final AlignmentGeometry? alignment;
  final List<Color>? gradientColors;
  final bool? isLoaderShow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        margin: margin,
        padding: padding ?? EdgeInsets.symmetric(vertical: 19.h),
        alignment: alignment ?? Alignment.center,
        height: height,
        decoration: BoxDecoration(
            color: AppColors.appColor,
            borderRadius: BorderRadius.circular(radius ?? 90.r)),
        child: isLoaderShow ?? false
            ? SizedBox(
                height: 16.w,
                width: 16.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
                ),
              )
            : Text(
                label,
                style: labelStyle ??
                    TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
