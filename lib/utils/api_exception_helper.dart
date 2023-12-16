import 'package:dio/dio.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:my_street_merchant/utils/sharedpref_utils.dart';

import '../generated/l10n.dart';

class ApiExceptionHelper {
  String getErrorMessage(dynamic error) {
    try {
      debugPrint("---- API ERROR: ${error.toString()}");
      if (error is DioError) {
        if (error.response != null) {
          if (error.response!.statusCode == 401) {
            if(SharedPrefs().accessToken.isNotEmpty){
              SharedPrefs().clearAll();
              return S.current.authorizationError;
            }else{
              return "";
            }
          }
          if (error.response!.data != null) {
            String msg = error.response!.data!["message"];
            String? errorCode = error.response!.data!["body"]?[0]?["errorCode"];
            if(errorCode!=null){
              switch(errorCode){
                case "4001200":{
                  return "";
                }
              }
            }
          }
        } else {
          if (error.type == DioErrorType.unknown) {
            if(!kDebugMode) {
              // FirebaseCrashlytics.instance.recordError(error, error.stackTrace, fatal: false);
            }
            if (error.message == "No Network") {
              return S.current.noNetwork;
            } else {
              return "${S.current.serverError} \n(${error.error?.toString().toUpperCase()})";
            }
          } else {
            return "${S.current.serverError} \n(${error.error?.toString().toUpperCase()})";
          }
        }
      } else {
        if(!kDebugMode) {
          // FirebaseCrashlytics.instance.recordError(error, error.stackTrace, fatal: false);
        }
        return S.current.somethingWentWrong;
      }
    } catch (e) {
      if(!kDebugMode) {
        // FirebaseCrashlytics.instance.recordError(error, error.stackTrace, fatal: false);
      }
      return S.current.somethingWentWrong;
    }
    return S.current.somethingWentWrong;
  }
}
