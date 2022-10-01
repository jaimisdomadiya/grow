import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:growmatic/common_widget/appbar_painter.dart';
import 'package:growmatic/controller/home_controller.dart';
import 'package:growmatic/utils/app_colors.dart';
import 'package:growmatic/utils/app_images.dart';
import 'package:growmatic/utils/app_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130.0,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
            ),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xff2DAE6D), Color(0xff39CC7E)]),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
          ),
        ),
        title: Row(
          children: [
            Obx(
              () => controller.profileImage.value.isNotEmpty
                  ? Container(
                      width: 65.w,
                      height: 65.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              controller.profileImage.value),
                        ),
                        color: AppColors.greenColor,
                      ),
                    )
                  : Container(
                      width: 65.w,
                      height: 65.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.greenColor,
                      ),
                    ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    'Hi, ${controller.name.value}',
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.whiteColor),
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'How are you doind today?',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: AppColors.greenColor, shape: BoxShape.circle),
              child: Image.asset(
                AppImages.notificationIc,
                height: 20.h,
                width: 22.w,
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.appColor),
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 80.h),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          masterGamingWidget(),
                          boosterListWidget(),
                          badassListWidget(),
                          consultationWidget()
                        ],
                      ),
                    ),
                  ),
          ),
          CustomPaint(
            painter: AppBarPainter(),
            child: Container(height: 0),
          ),
        ],
      ),
    );
  }

  Widget masterGamingWidget() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 15.h, left: 17.w),
          margin: EdgeInsets.only(top: 14.h, bottom: 10.h),
          decoration: BoxDecoration(
              color: AppColors.darkAppColor,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                    blurRadius: 20,
                    spreadRadius: 0,
                    color: AppColors.blackColor.withOpacity(0.15),
                    offset: const Offset(0, 8))
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.masterGamePlan,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: AppColors.whiteColor),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        AppString.takeATour,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: AppColors.lightGreenColor),
                      ),
                      SizedBox(width: 11.w),
                      Icon(Icons.arrow_forward_outlined,
                          color: AppColors.yellowColor)
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(
                AppImages.roundedEffectImage,
                width: 169.w,
                height: 103.h,
                alignment: Alignment.centerRight,
              )
            ],
          ),
        ),
        Positioned(
          right: 23,
          top: 0.h,
          child: Image.asset(
            AppImages.gamePlanImage,
            height: 96.h,
            width: 96.w,
          ),
        )
      ],
    );
  }

  Widget boosterListWidget() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 15.h, left: 17.w),
          margin: EdgeInsets.only(top: 14.h, bottom: 10.h),
          decoration: BoxDecoration(
              color: AppColors.darkAppColor,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                    blurRadius: 20,
                    spreadRadius: 0,
                    color: AppColors.blackColor.withOpacity(0.15),
                    offset: const Offset(0, 8))
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.theBoosterList,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: AppColors.whiteColor),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h, bottom: 8.h, left: 0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90.r),
                        color: const Color(0xff20E87E).withOpacity(0.19)),
                    child: Text(
                      AppString.articled10,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        AppString.takeATour,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: AppColors.lightGreenColor),
                      ),
                      SizedBox(width: 11.w),
                      Icon(Icons.arrow_forward_outlined,
                          color: AppColors.yellowColor)
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(
                AppImages.roundedEffectImage,
                width: 169.w,
                height: 103.h,
                alignment: Alignment.centerRight,
              )
            ],
          ),
        ),
        Positioned(
          right: 23,
          top: 0.h,
          child: Image.asset(
            AppImages.boosterImage,
            height: 96.h,
            width: 96.w,
          ),
        )
      ],
    );
  }

  Widget badassListWidget() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 15.h, left: 17.w),
          margin: EdgeInsets.only(top: 14.h, bottom: 45.h),
          decoration: BoxDecoration(
              color: AppColors.darkAppColor,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                    blurRadius: 20,
                    spreadRadius: 0,
                    color: AppColors.blackColor.withOpacity(0.15),
                    offset: const Offset(0, 8))
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.theBadassList,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: AppColors.whiteColor),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h, bottom: 8.h, left: 0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90.r),
                        color: const Color(0xff20E87E).withOpacity(0.19)),
                    child: Text(
                      AppString.articled10,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        AppString.takeATour,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: AppColors.lightGreenColor),
                      ),
                      SizedBox(width: 11.w),
                      Icon(Icons.arrow_forward_outlined,
                          color: AppColors.yellowColor)
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(
                AppImages.roundedEffectImage,
                width: 169.w,
                height: 103.h,
                alignment: Alignment.centerRight,
              )
            ],
          ),
        ),
        Positioned(
          right: 23,
          top: 0.h,
          child: Image.asset(
            AppImages.warningImage,
            height: 96.h,
            width: 96.w,
          ),
        )
      ],
    );
  }

  Widget consultationWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "13th August, 2022",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            Text(
              "View All",
              style: TextStyle(
                  color: AppColors.appColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        ListView.separated(
          itemCount: 2,
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(right: 19.w),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 17,
                        spreadRadius: 0,
                        offset: const Offset(0, 8),
                        color: AppColors.blackColor.withOpacity(0.10))
                  ]),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.yellowColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          bottomLeft: Radius.circular(15.r),
                        ),
                      ),
                      width: 5.h,
                    ),
                    SizedBox(width: 12.w),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${index + 1}st consultation",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppImages.calenderIc2,
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    "23/08/2022",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xff545454),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(width: 10.w),
                                  Image.asset(
                                    AppImages.clockIc,
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    "10:00 AM",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xff545454),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(width: 13.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(90.r),
                                        color: const Color(0xffCFF8E3)),
                                    child: Text(
                                      AppString.confirmed,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.appColor),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.more_vert)
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 13.h);
          },
        ),
      ],
    );
  }
}
