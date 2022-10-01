import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:growmatic/common_widget/circular_button.dart';
import 'package:growmatic/common_widget/text_form_field.dart';
import 'package:growmatic/controller/login_controller.dart';
import 'package:growmatic/utils/app_colors.dart';
import 'package:growmatic/utils/app_images.dart';
import 'package:growmatic/utils/app_string.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                Image.asset(
                  AppImages.appLogo,
                  height: 94.h,
                  width: 86.w,
                ),
                SizedBox(height: 8.h),
                Text(
                  AppString.growMatic,
                  style: TextStyle(fontSize: 42.sp),
                ),
                SizedBox(height: 78.h),
                Text(
                  AppString.login,
                  style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.appColor),
                ),
                SizedBox(height: 31.h),
                TextFormFieldWidget(
                  controller: controller.emailController,
                  prefixIcon: AppImages.emailIc,
                  hintText: AppString.emailID,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                Obx(
                  () => controller.emailErrorMsg.value.isNotEmpty
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(
                              controller.emailErrorMsg.value,
                              style: TextStyle(
                                  color: AppColors.redColor, fontSize: 12.sp),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                SizedBox(height: 25.h),
                TextFormFieldWidget(
                  controller: controller.passwordController,
                  prefixIcon: AppImages.passwordIc,
                  hintText: AppString.password,
                  textInputAction: TextInputAction.done,
                ),
                Obx(
                  () => controller.passwordErrorMsg.value.isNotEmpty
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(
                              controller.passwordErrorMsg.value,
                              style: TextStyle(
                                  color: AppColors.redColor, fontSize: 12.sp),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 22.h),
                  child: Text(
                    AppString.forgotPassword,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.appColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Obx(
                  () => CircularButton(
                    isLoaderShow: controller.isLoading.value,
                    label: AppString.login.toUpperCase(),
                    onPressed: () {
                      controller.loginOnTap();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
