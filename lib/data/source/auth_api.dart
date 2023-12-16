import 'package:dio/dio.dart';
import 'package:my_street_merchant/domain/model/response/api_single_response.dart';

import '../../domain/model/response/auth/user.dart';
import '../constants/constants.dart';
import '../constants/endpoints.dart';
import '../network_client.dart';

class AuthApi {
  final Dio _apiClient = ApiClient().client;

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    var response = await _apiClient.post(Endpoints.signIn, data: {"email": email.toLowerCase(), "password": password});
    return ApiSingleResponse<User>.fromJson(response.data).body;
  }

  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    var response = await _apiClient.post(Endpoints.signUp, data: {"email": email.toLowerCase(), "password": password});
    return ApiSingleResponse<User>.fromJson(response.data).body;
  }

  Future<dynamic> sendResetPasswordOtp({
    required String email,
  }) async {
    var response = await _apiClient.post(Endpoints.sendResetPWOtp, data: {"email": email.toLowerCase(),});
    return ApiSingleResponse<dynamic>.fromJson(response.data);
  }

  Future<User?> resetPassword({
    required String email,
    required String password,
  }) async {
    var response = await _apiClient.post(Endpoints.resetPassword, data: {"email": email.toLowerCase(), "password": password});
    return ApiSingleResponse<User>.fromJson(response.data).body;
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    var response = await _apiClient.post(Endpoints.changePassword, data: {"currentPassword": currentPassword,
      "newPassword": newPassword,"confirmPassword": newPassword});
    return ApiSingleResponse<dynamic>.fromJson(response.data).message == CommonConsts.passwordChanged;
  }

  Future<bool> verifyResetPasswordOtp({
    required String email,
    required int otpCode,
  }) async {
    var response = await _apiClient.post(Endpoints.verifyResetPWOtp, data: {"email": email.toLowerCase(), "otpCode": otpCode});
    return ApiSingleResponse<dynamic>.fromJson(response.data).message == CommonConsts.success;
  }

  Future<bool> verifyEmail({
    required String email,
    required int otpCode,
  }) async {
    var response = await _apiClient.post(Endpoints.verifyEmail, data: {"email": email.toLowerCase(), "otpCode": otpCode});
    return ApiSingleResponse<dynamic>.fromJson(response.data).message == CommonConsts.success;
  }

}
