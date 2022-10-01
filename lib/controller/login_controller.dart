import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:growmatic/api/api_call_instance.dart';
import 'package:growmatic/api/api_end_points.dart';
import 'package:growmatic/api/api_helper.dart';
import 'package:growmatic/api/app_exception.dart';
import 'package:growmatic/modal/login_modal.dart';
import 'package:growmatic/utils/function/log_utils.dart';
import 'package:growmatic/utils/function/validation.dart';
import 'package:growmatic/utils/preferences/preference_manager.dart';
import 'package:growmatic/utils/preferences/preferences_key.dart';
import 'package:growmatic/utils/routes/routes_strings.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString emailErrorMsg = ''.obs;
  RxString passwordErrorMsg = ''.obs;
  RxBool isLoading = false.obs;

  Future<void> loginOnTap() async {
    try {
      FocusScopeNode currentFocus = FocusScope.of(Get.context!);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.focusedChild!.unfocus();
      }
      emailErrorMsg.value = Validation.validateEmail(emailController.text);
      passwordErrorMsg.value =
          Validation.validatePassword(passwordController.text);
      if (emailErrorMsg.value.isEmpty && passwordErrorMsg.value.isEmpty) {
        await loginUserApi();
      }
    } catch (e) {
      log(e.toString(), name: "Error");
    }
  }

  Future<void> loginUserApi() async {
    try {
      isLoading.value = true;
      APIRequestInfo requestInfo = APIRequestInfo(
          url: APIUrl.login,
          requestType: HTTPRequestType.POST,
          headers: ApiHelper.getHeaders(false),
          parameter: {
            'push_token':
                '8AB9DDD04B7AA4B5FCAD57D3369B3BA4394576813F2628ADE4B1B2B0EA66CB90',
            'device_id': '8ECB6CC4-D436-4C19-9350-6BCC6A1F8BC1s',
            'device_type': 'ios',
            'email': emailController.text.trim(),
            'password': passwordController.text.trim(),
          });

      String response = await ApiCallPlatInstance.apiInstance
          .callService(requestInfo: requestInfo);

      LoginModal loginModal = LoginModal.fromJson(jsonDecode(response));

      String loginData = loginModalToJson(loginModal);
      await AppPreference()
          .setString(PreferencesKey.userToken, loginModal.data?.token ?? '');
      await AppPreference().setBool(PreferencesKey.isLogin, true);
      await AppPreference().setString(PreferencesKey.loginData, loginData);
      Get.offAllNamed(RoutesConstants.bottomNavigationBar);
    } catch (e, stackStrace) {
      LogUtils.showLogs(message: e.toString(), tag: "Error");
      LogUtils.showLogs(message: "$stackStrace", tag: "StackStrace");
    } finally {
      isLoading.value = false;
    }
  }
}
