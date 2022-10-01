import 'package:flutter/foundation.dart';
import 'package:growmatic/api/api_call_instance.dart';
import 'package:growmatic/api/api_error_msg.dart';
import 'package:growmatic/api/api_setup.dart';
import 'package:growmatic/utils/function/log_utils.dart';
import 'package:growmatic/utils/preferences/preference_manager.dart';
import 'package:growmatic/utils/preferences/preferences_key.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  // API Header
  static Map<String, String> getHeaders(bool isAccessRequired,
      {bool isAppJson = true}) {
    return isAccessRequired
        ? {
            'Authorization':
                'Bearer ${AppPreference().getString(PreferencesKey.userToken)}',
            'Content-Type': 'application/json',
          }
        : {
            'Content-Type': 'application/json',
          };
  }

  // API info...
  static printApiDetail(APIRequestInfo info) {
    String apiLog = """

        ${info.serviceName} Service Parameters
        |-------------------------------------------------------------------------------------------------------------------------
        | ApiType :- ${describeEnum(info.requestType)}
        | URL     :- ${info.url}
        | Header  :- ${info.headers}
        | Params  :- ${info.parameter}
        |-------------------------------------------------------------------------------------------------------------------------
        """;
    LogUtils.showLogs(message: apiLog, tag: "apiLog");
  }

  // API response info...
  static printResponse(http.Response response, String serviceName) {
    String apiLog = """

        $serviceName Service Response
        |--------------------------------------------------------------------------------------------------------------------------
        | API        :- $serviceName
        | StatusCode :- ${response.statusCode}
        | Message    :- ${response.body}
        |--------------------------------------------------------------------------------------------------------------------------
        """;
    LogUtils.showLogs(message: apiLog, tag: "apiLog");
  }

  static String getFinalURL({String endpoint = ""}) {
    // Production url + end point...
    String finalURL = (APISetup.useLiveToTest
            ? APISetup.productionURL
            : APISetup.stagingURL) +
        endpoint;
    return finalURL;
  }

  static String getErrorTitle(http.Response response) =>
      APIErrorMsg.defaultErrorTitle;

  //Get Error Message...
  static String getErrorMsg(http.Response response) =>
      APIErrorMsg.somethingWentWrong;
}
