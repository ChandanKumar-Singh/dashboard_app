import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_dashboard/constants/sp_constants.dart';
import 'package:my_dashboard/database/dio/dio/dio_client.dart';
import 'package:my_dashboard/database/model/response/additional/user_model.dart';
import 'package:my_dashboard/database/model/response/base/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/api_constants.dart';
import '../dio/exception/api_error_handler.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final DioClient dioClient;
  AuthRepo({required this.sharedPreferences, required this.dioClient});

  Future<void> updateHeader(String token) async {
    try {
      dioClient.updateHeader(token);
    } catch (e) {}
  }

  Future<ApiResponse> sendLoginOTP(String email) async {
    try {
      Response response =
          await dioClient.post(ApiConst.sendLoginOTP, data: {"email": email});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyLoginOTP(String email, otp, registered) async {
    try {
      Response response = await dioClient.post(ApiConst.verifyLoginOTP,
          data: {"email": email, 'otp': otp, 'registered': registered});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateProfile(Map<String, dynamic> data) async {
    try {
      Response response =
          await dioClient.post(ApiConst.updateProfile, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getUserInfo() async {
    try {
      Response response = await dioClient.get(ApiConst.getUserInfo);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///shared preferences

  Future<void> saveUser(UserModel user) async => await sharedPreferences
      .setString(SpConst.user, jsonEncode(user.toJson()));

  Future<UserModel?> getUser() async {
    UserModel? user;
    var data = sharedPreferences.getString(SpConst.user);
    try {
      if (data != null) {
        user = UserModel.fromJson(jsonDecode(data));
      }
    } catch (e) {}
    return user;
  }

  Future<void> saveLoginToken(String token) async =>
      await sharedPreferences.setString(SpConst.loginToken, token);

  Future<String?> getLoginToken() async =>
      sharedPreferences.getString(SpConst.loginToken);

  Future<void> clearUser() async => sharedPreferences.clear();
}
