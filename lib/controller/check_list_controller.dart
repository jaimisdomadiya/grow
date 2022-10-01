import 'package:get/get.dart';
import 'package:growmatic/api/api_call_instance.dart';
import 'package:growmatic/api/api_end_points.dart';
import 'package:growmatic/api/app_exception.dart';
import 'package:growmatic/modal/check_list_data_modal.dart';
import 'dart:convert';
import 'package:growmatic/api/api_helper.dart';
import 'package:growmatic/modal/home_modal.dart';
import 'package:growmatic/utils/function/log_utils.dart';

class CheckListController extends GetxController {
  List<CheckListModal> checkList = [
    CheckListModal(name: "Minoxidil Foam", isSelected: RxBool(false)),
    CheckListModal(name: "Biotin ", isSelected: RxBool(false)),
    CheckListModal(name: "Omega3 x 3 ", isSelected: RxBool(false)),
    CheckListModal(name: "Iron", isSelected: RxBool(false)),
    CheckListModal(name: "Zinc", isSelected: RxBool(false)),
    CheckListModal(name: "Multivitamin x 2 ", isSelected: RxBool(false)),
    CheckListModal(name: "Hair Growth Oil", isSelected: RxBool(false)),
    CheckListModal(
        name: "Laser treatment for 30 mins", isSelected: RxBool(false)),
    CheckListModal(
        name: "Scalp massage (optional) ", isSelected: RxBool(false)),
  ];

  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    checkListDataApi();
  }

  Future<void> checkListDataApi() async {
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
    } catch (e, stackStrace) {
      LogUtils.showLogs(message: e.toString(), tag: "Error");
      LogUtils.showLogs(message: "$stackStrace", tag: "StackStrace");
    } finally {
      isLoading.value = false;
    }
  }
}
