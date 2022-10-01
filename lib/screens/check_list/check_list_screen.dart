import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:growmatic/common_widget/appbar_painter.dart';
import 'package:growmatic/controller/check_list_controller.dart';
import 'package:growmatic/utils/app_colors.dart';
import 'package:growmatic/utils/app_string.dart';

class CheckListScreen extends StatefulWidget {
  const CheckListScreen({Key? key}) : super(key: key);

  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  CheckListController controller = Get.put(CheckListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        elevation: 0.0,
        centerTitle: true,
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
        title: Text(
          AppString.checkList,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 80.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "13th August, 2022",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                  ),
                  ListView.separated(
                    itemCount: controller.checkList.length,
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(right: 13.w),
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
                              Obx(
                                () => Container(
                                  decoration: BoxDecoration(
                                    color: controller
                                            .checkList[index].isSelected!.value
                                        ? AppColors.appColor
                                        : AppColors.yellowColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.r),
                                      bottomLeft: Radius.circular(15.r),
                                    ),
                                  ),
                                  width: 5.h,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(
                                      () => Text(
                                        '${controller.checkList[index].name}',
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            decoration: controller
                                                    .checkList[index]
                                                    .isSelected!
                                                    .value
                                                ? TextDecoration.lineThrough
                                                : null,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const Spacer(),
                                    Obx(
                                      () => Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor: AppColors
                                              .blackColor
                                              .withOpacity(0.1),
                                        ),
                                        child: Checkbox(
                                          checkColor: const Color(0xffEEEEEE),
                                          activeColor: AppColors.appColor,
                                          value: controller.checkList[index]
                                              .isSelected!.value,
                                          shape: const CircleBorder(),
                                          onChanged: (bool? value) {
                                            controller.checkList[index]
                                                .isSelected!.value = value!;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
}
