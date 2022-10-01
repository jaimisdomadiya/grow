import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:growmatic/utils/preferences/preference_manager.dart';
import 'package:growmatic/utils/preferences/preferences_key.dart';
import 'package:growmatic/utils/routes/navigation_pages.dart';
import 'package:growmatic/utils/routes/routes_strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreference().initialAppPreference();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            title: 'Growmatic',
            theme: ThemeData(),
            initialRoute: AppPreference().getBool(PreferencesKey.isLogin)
                ? RoutesConstants.bottomNavigationBar
                : RoutesConstants.loginScreen,
            getPages: GetPages.getPages,
          );
        });
  }
}
