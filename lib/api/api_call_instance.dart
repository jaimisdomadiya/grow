import 'dart:async';
import 'dart:io';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:growmatic/api/api_error_msg.dart';
import 'package:growmatic/api/api_helper.dart';
import 'package:growmatic/api/app_exception.dart';
import 'package:growmatic/utils/preferences/preference_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ApiCallPlatInstance {
  ApiCallPlatInstance._();

  static ApiCallPlatInstance get apiInstance => ApiCallPlatInstance._();

  // Call API...
  Future<String> callService(
      {required APIRequestInfo requestInfo,
      bool isAttachBaseUrl = true}) async {
    try {
      if (isAttachBaseUrl) {
        requestInfo.url = ApiHelper.getFinalURL(endpoint: requestInfo.url);
      }

      // Print Request info...
      ApiHelper.printApiDetail(requestInfo);

      // Get Response...
      http.Response apiResponse = requestInfo.docList.isEmpty
          ? await _callAPI(requestInfo: requestInfo)
              .timeout(Duration(seconds: requestInfo.timeSecond))
          : await _callMultipartAPI(requestInfo: requestInfo)
              .timeout(Duration(seconds: requestInfo.timeSecond));

      return processResponse(apiResponse);

      // Exceptions...
    } on SocketException catch (e) {
      throw AppException(
        message: e.message,
        type: ExceptionType.NoInternet,
      );
    } on HttpException catch (e) {
      throw AppException(
        message: e.message,
        type: ExceptionType.HTTPException,
      );
    } on FormatException catch (e) {
      throw AppException(
        message: e.source?.toString(),
        type: ExceptionType.FormatException,
      );
    } on TimeoutException {
      throw AppException(
        title: APIErrorMsg.requestTimeOutTitle,
        message: APIErrorMsg.requestTimeOutMessage,
        type: ExceptionType.TimeOut,
      );
    } catch (error) {
      rethrow;
    }
  }

  //Call API...
  Future<http.Response> _callAPI({
    required APIRequestInfo requestInfo,
  }) async {
    // final URL...
    String _url = requestInfo.url;

    // Http Response...
    http.Response response;

    // Add header...
    Map<String, String>? apiHeader = requestInfo.headers;

    //Call API with respect to request type...
    switch (requestInfo.requestType) {
      case HTTPRequestType.POST:
        response = await http.post(
          Uri.parse(_url),
          body:
              (requestInfo.parameter is Map?) || (requestInfo.parameter is Map)
                  ? json.encode(requestInfo.parameter)
                  : requestInfo.parameter,
          headers: apiHeader,
        );
        break;
      case HTTPRequestType.GET:
        response = await http.get(
          Uri.parse(_url),
          headers: apiHeader,
        );
        break;
      case HTTPRequestType.DELETE:
        response = await http.delete(
          Uri.parse(_url),
          headers: apiHeader,
        );
        break;
      case HTTPRequestType.PUT:
        response = await http.put(
          Uri.parse(_url),
          body:
              (requestInfo.parameter is Map?) || (requestInfo.parameter is Map)
                  ? json.encode(requestInfo.parameter)
                  : requestInfo.parameter,
          headers: apiHeader,
        );
        break;
      case HTTPRequestType.PATCH:
        response = await http.patch(
          Uri.parse(_url),
          body:
              (requestInfo.parameter is Map?) || (requestInfo.parameter is Map)
                  ? json.encode(requestInfo.parameter)
                  : requestInfo.parameter,
          headers: apiHeader,
        );
        break;
    }

    // Print Request info...
    ApiHelper.printResponse(response, requestInfo.serviceName);

    //Return Received Response...
    return response;
  }

  // Multipart request...
  Future<http.Response> _callMultipartAPI({
    required APIRequestInfo requestInfo,
  }) async {
    //Get URI...
    Uri uri = Uri.parse(requestInfo.url);
    http.MultipartRequest request = http.MultipartRequest(
      describeEnum(requestInfo.requestType),
      uri,
    );

    //Add Parameters...
    if ((requestInfo.parameter is Map?) || (requestInfo.parameter is Map)) {
      (requestInfo.parameter as Map<String, dynamic>?)
          ?.forEach((key, value) => request.fields[key] = value);
    } else {
      request.fields.addAll(jsonDecode(requestInfo.parameter as String));
    }

    //Add header...
    Map<String, String>? apiHeader = requestInfo.headers;
    apiHeader?.forEach((key, value) => request.headers[key] = value);

    //Set Documents
    List<Future<http.MultipartFile>> _files = requestInfo.docList
        .map(
          (docInfo) => docInfo.docPathList.map(
            (docPath) => http.MultipartFile.fromPath(
              docInfo.docKey,
              docPath,
              filename: basename(docPath),
            ).catchError(
              (error) {
                debugPrint(
                    "-----------------Error While uploading Image: $docPath, Error: $error -----------------");
              },
            ),
          ),
        )
        .expand((multipartFile) => multipartFile)
        .toList();

    // Upload all files...
    List<http.MultipartFile> multiPartFiles =
        await Future.wait<http.MultipartFile>(_files);
    request.files.addAll(multiPartFiles);

    //Send Request...
    http.Response response =
        await http.Response.fromStream(await request.send());

    // Print Request info...
    ApiHelper.printResponse(response, requestInfo.serviceName);

    //Return Received Response...
    return response;
  }

  static String processResponse(http.Response response) {
    String title = ApiHelper.getErrorTitle(response);
    String msg = ApiHelper.getErrorMsg(response);

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 204:
        return response.body;

      case 401:
        AppPreference().clearSharedPreferences();
        return '';
      case 403:
        throw AppException(
          statusCode: response.statusCode,
          title: title,
          message: msg,
          type: ExceptionType.UnAuthorised,
        );

      case 410:
      case 400:
      case 404:
      case 422:
        throw AppException(
          statusCode: response.statusCode,
          title: title,
          message: msg,
          type: ExceptionType.None,
        );

      // Service Unavailable...
      case 503:
        throw AppException(
          statusCode: response.statusCode,
          title: title,
          message: msg,
          type: ExceptionType.UnderMaintainance,
        );

      default:
        throw AppException(
          statusCode: response.statusCode,
          title: title,
          message: msg,
          type: ExceptionType.None,
        );
    }
  }
}

// API Request Obj...
class APIRequestInfo {
  HTTPRequestType requestType;
  String url;
  Object? parameter;
  Map<String, String>? headers;
  List<UploadDocument> docList;
  String serviceName;
  int timeSecond = 90;

  APIRequestInfo({
    this.requestType = HTTPRequestType.POST,
    this.parameter,
    this.headers,
    this.docList = const [],
    required this.url,
    this.serviceName = "",
    this.timeSecond = 90,
  });
}

//Uploading document Object...
class UploadDocument {
  String docKey;
  List<String> docPathList;

  UploadDocument({
    this.docKey = "",
    this.docPathList = const [],
  });
}
