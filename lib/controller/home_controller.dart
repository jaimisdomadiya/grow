import 'dart:convert';

import 'package:get/get.dart';
import 'package:growmatic/api/api_call_instance.dart';
import 'package:growmatic/api/api_end_points.dart';
import 'package:growmatic/api/api_helper.dart';
import 'package:growmatic/api/app_exception.dart';
import 'package:growmatic/modal/home_modal.dart';
import 'package:growmatic/utils/function/log_utils.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxString name = RxString('');
  RxString profileImage = RxString('');
  List<Booking> bookingList = [];

  @override
  void onInit() async {
    super.onInit();
    homeDataApi();
  }

  Future<void> homeDataApi() async {
    try {
      isLoading.value = true;
      APIRequestInfo requestInfo = APIRequestInfo(
          url: APIUrl.home,
          requestType: HTTPRequestType.POST,
          headers: ApiHelper.getHeaders(true),
          parameter: {
            'date': '',
          });

      String response = await ApiCallPlatInstance.apiInstance
          .callService(requestInfo: requestInfo);

      HomeModal homeModal = HomeModal.fromJson(jsonDecode(response));
      bookingList = homeModal.data?.booking ?? [];
      name.value = homeModal.data?.specialist?.name ?? '';
      profileImage.value = homeModal.data?.specialist?.profileImage ?? '';
    } catch (e, stackStrace) {
      LogUtils.showLogs(message: e.toString(), tag: "Error");
      LogUtils.showLogs(message: "$stackStrace", tag: "StackStrace");
    } finally {
      isLoading.value = false;
    }
  }
}
