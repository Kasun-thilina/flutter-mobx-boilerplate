import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_street_merchant/data/constants/endpoints.dart';
import 'package:my_street_merchant/domain/deserializer.dart';
import 'package:my_street_merchant/domain/model/response/auth/user.dart';
import 'package:my_street_merchant/utils/environment_utils.dart';

import '../domain/model/response/api_single_response.dart';
import '../utils/sharedpref_utils.dart';
import 'api_exception.dart';
import 'check_connection.dart';

class ApiClient {
  static final ApiClient _apiClient = ApiClient._internal();
  final Dio _dio = Dio();
  final _regList = RegExp(r'^List<(.*)>$');
  final _regMap = RegExp(r'^Map<String,(.*)>$');
  int retryCounter = 0;

  factory ApiClient() {
    return _apiClient;
  }

  Dio get client => _dio;

  ApiClient._internal() {
    _dio.options.baseUrl = "http://${EnvironmentUtils.apiBaseURL}/api/v1/";
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) =>
            requestInterceptor(options, handler),
        onResponse: (
          Response response,
          ResponseInterceptorHandler handler,
        ) =>
            responseInterceptor(response, handler),
        onError: (
          DioError dioError,
          ErrorInterceptorHandler handler,
        ) =>
            errorInterceptor(dioError, handler)));
  }

  dynamic requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    ///Logger
    debugPrint("--> ${options.method.toUpperCase()} ${"${options.baseUrl ?? ""}${options.path ?? ""}"}");
    debugPrint("Headers:");
    options.headers.forEach((k, v) => debugPrint('$k: $v'));
    debugPrint("queryParameters:");
    options.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
    if (!await Connection.getInstance().checkConnection()) {
      debugPrint(">>>NO NETWORK!");
      handler.reject(DioError(
        error: "No Network",
        requestOptions: options,
      ));
    }
    if (options.data != null) {
      if (options.data is FormData) {
        debugPrint("Body: ${options.data.fields.toString()}");
      }else{
        debugPrint("Body: ${options.data.toString()}");
      }
    }
    debugPrint("--> END ${options.method.toUpperCase()}");

    var token = SharedPrefs().accessToken;
    debugPrint("TOKEN: $token");
    if (token == "") {
      options.headers.addAll({"Content-Type": "application/json", "X-Requested-With": "XMLHttpRequest"});
    } else {
      options.headers.addAll(
          {"Content-Type": "application/json", "X-Requested-With": "XMLHttpRequest", "Authorization": "Bearer $token"});
    }
    return handler.next(options);
  }

  dynamic responseInterceptor(Response response, ResponseInterceptorHandler handler) async {
    ///Logger
    debugPrint("<-- ${response.statusCode} $response}");
    debugPrint("Headers:");
    response.headers.forEach((k, v) => debugPrint('$k: $v'));
    debugPrint("Response: ${response.data}");
    debugPrint("<-- END HTTP");
    if (response.statusCode != null) {
      if (response.statusCode! >= 400) {
        throw ApiException(response.statusCode!, response.data);
      } else {
        return handler.next(response);
      }
    } else {
      return handler.next(response);
    }
  }

  dynamic errorInterceptor(DioError dioError, ErrorInterceptorHandler handler) async {
    ///Logger
    debugPrint("<-- ${dioError.message}");
    debugPrint("${dioError.response != null ? dioError.response?.data : 'Unknown Error'}");
    debugPrint("<-- End error");
    // RequestOptions origin = dioError.response?.request;
    if (dioError.response?.statusCode == 401) {
      debugPrint(">>> retryCounter: $retryCounter");
      if (retryCounter > 4) {
        return handler.next(dioError);
      } else {
        debugPrint("--> Refreshing token");
        try {
          Response refreshData = await client.post(Endpoints.refreshToken, data: {"token": SharedPrefs().refreshToken});
          retryCounter++;
          User? user = ApiSingleResponse<User>.fromJson(refreshData.data).body;
          if (user != null) {
            SharedPrefs().setAccessToken(user.accessToken ?? "");
            SharedPrefs().setRefreshToken(user.refreshToken ?? "");
            debugPrint("--> Continuing ${dioError.requestOptions.path}");
            dynamic response;
            RequestOptions options = dioError.requestOptions;
            if (dioError.requestOptions.data.toString().isEmpty) {
              response = await client.request(options.path,
                  options: Options(
                      method: options.method,
                      headers: {
                        "Content-Type": "application/json",
                        "X-Requested-With": "XMLHttpRequest",
                        "Authorization": "Bearer ${user.accessToken}"
                      },
                      contentType: options.contentType,
                      extra: options.extra));
            } else {
              if (options.data is FormData) {
                FormData formData = FormData();
                formData.fields.addAll(options.data.fields);
                for (MapEntry mapFile in options.data.files) {
                  formData.files.add(MapEntry(mapFile.key,
                      MultipartFile.fromFileSync(mapFile.value.filePath, filename: mapFile.value.filename)));
                  // MultipartFileExtended.fromFileSync(mapFile.value.filePath,
                  //     filename: mapFile.value.filename)));
                }
                options.data = formData;
              }
              response = await client.request(options.path,
                  data: options.data,
                  options: Options(
                      method: options.method,
                      headers: {
                        "Content-Type": "application/json",
                        "X-Requested-With": "XMLHttpRequest",
                        "Authorization": "Bearer ${user.accessToken}"
                      },
                      contentType: options.contentType,
                      extra: options.extra));
            }
            handler.resolve(response);
          } else {
            return handler.next(dioError);
          }
        } catch (e) {
          debugPrint(">>> Refresh Failed:$e");
          return handler.next(dioError);
        }
      }
    }
    if (dioError.response?.statusCode == 500) {
      return handler.next(dioError);
      // throw new DioError(error: "Server Error", requestOptions: dioError.response.requestOptions);
    } else {
      return handler.next(dioError);
    }
  }

  dynamic deserialize(String jsonVal, String targetType) {
    targetType = targetType.replaceAll(' ', '');
    if (targetType == 'String') return jsonVal;
    return DeSerializer.fromJson(json.decode(jsonVal));
  }

  dynamic _deserialize(dynamic value, String targetType) {
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          return value is bool ? value : '$value'.toLowerCase() == 'true';
        case 'double':
          return value is double ? value : double.parse('$value');
        default:
          {
            Match? match;
            if (value is List && (match = _regList.firstMatch(targetType)) != null) {
              var newTargetType = match![1];
              return value.map((v) => _deserialize(v, newTargetType!)).toList();
            } else if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
              var newTargetType = match![1];
              return Map.fromIterables(value.keys, value.values.map((v) => _deserialize(v, newTargetType!)));
            }
          }
      }
    } catch (e, stack) {
      throw ApiException.withInner(500, 'Exception during deserialization.', e as Exception, stack);
    }
    throw ApiException(500, 'Could not find a suitable class for deserialization');
  }
}
