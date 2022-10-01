import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:growmatic/screens/check_list/check_list_screen.dart';
import 'package:growmatic/screens/home_screen/home_screen.dart';
import 'package:growmatic/utils/app_colors.dart';
import 'package:growmatic/utils/app_images.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int currentIndex = 0;

  void setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          currentIndex == 0 ? const HomeScreen() : const CheckListScreen(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: size.width,
              height: 90.h,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    heightFactor: 0.4,
                    child: Container(
                      height: 55.w,
                      width: 55.w,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.yellowColor,
                      ),
                      child: Image.asset(
                        AppImages.calenderIc,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setBottomBarIndex(0);
                          },
                          child: Container(
                            padding: EdgeInsets.all(9.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 0
                                  ? AppColors.greenColor
                                  : Colors.transparent,
                            ),
                            child: Image.asset(
                              AppImages.homeIc,
                              width: 22.w,
                              height: 23.h,
                              color: currentIndex == 0
                                  ? AppColors.whiteColor
                                  : AppColors.whiteColor.withOpacity(0.4),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setBottomBarIndex(1);
                          },
                          child: Container(
                            padding: EdgeInsets.all(9.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 1
                                  ? AppColors.greenColor
                                  : Colors.transparent,
                            ),
                            child: Image.asset(
                              AppImages.checkListIc,
                              width: 22.w,
                              height: 23.h,
                              color: currentIndex == 1
                                  ? AppColors.whiteColor
                                  : AppColors.whiteColor.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.appColor
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 10);
    path.arcToPoint(Offset(size.width * 0.60, 10),
        radius: const Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
