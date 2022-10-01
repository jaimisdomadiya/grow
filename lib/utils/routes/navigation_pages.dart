import 'package:get/get.dart';
import 'package:growmatic/binding/login_binding.dart';
import 'package:growmatic/screens/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:growmatic/screens/login/login_screen.dart';
import 'package:growmatic/utils/routes/routes_strings.dart';

class GetPages {
  static List<GetPage> getPages = [
    GetPage(
      name: RoutesConstants.loginScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RoutesConstants.bottomNavigationBar,
      page: () => const BottomNavigationScreen(),
    ),
  ];
}
