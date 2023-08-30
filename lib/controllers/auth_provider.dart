import 'package:flutter/cupertino.dart';
import '/database/dio/exception/api_error_handler.dart';
import '/database/model/response/additional/user_model.dart';
import '/services/auth_service.dart';
import '/utils/logger.dart';

import '../database/model/response/base/api_response.dart';
import '../database/repositories/auth_repo.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({required this.authRepo});
  final AuthRepo authRepo;
  final String tag = 'AuthProvider';
  late UserModel user;

  UserModel get currentUser => user;

  bool sendingLoginOTP = false;
  bool updatingProfile = false;
  bool otpSent = false;
  setOtpSent(bool val) {
    otpSent = val;
    notifyListeners();
  }

  Future<int?> sendLoginOTP(String email) async {
    int? registered;
    sendingLoginOTP = true;
    notifyListeners();
/*    ApiResponse apiResponse = await authRepo.sendLoginOTP(email);
    sendingLoginOTP = true;
    notifyListeners();
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      Map map = apiResponse.response?.data;
      bool status = false;
      String message = '';
      try {
        message = map["message"];
        status = map["status"];
      } catch (e) {}
      // status
      //     ? Toasts.showSuccessNormalToast(message.split('.').first)
      //     : Toasts.showErrorNormalToast(message.split('.').first);
      if (status) {
        setOtpSent(true);
        registered = map['registered'];
        // Future.delayed(
        //     Duration(milliseconds: 2000), () => Get.offAll(LoginScreen()));
      }
      notifyListeners();
    } else {
      String errorMessage = ApiErrorHandler.getErrorText(apiResponse);
      notifyListeners();
    }*/
    await Future.delayed(const Duration(seconds: 1));
    setOtpSent(true);
    sendingLoginOTP = false;
    notifyListeners();
    return 1;
    return registered;
  }

  Future<bool> verifyLoginOTP(
      String email, otp, int registered, BuildContext context) async {
    bool status = false;
    sendingLoginOTP = true;
    notifyListeners();

/*    try {
      ApiResponse apiResponse =
      await authRepo.verifyLoginOTP(email, otp, registered);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        Map map = apiResponse.response?.data;
        String message = '';
        try {
          message = map["message"];
          status = map["status"];
          status = map["token"];
        } catch (e) {}
        // status
        //     ? Toasts.showSuccessNormalToast(message.split('.').first)
        //     : Toasts.showErrorNormalToast(message.split('.').first);
        if (status) {
          authRepo.updateHeader(map['token']);
          if (registered == 1) {
            try {
              await updateUser(UserModel.fromJson(map['userData']));
              await saveLoginToken(map['token']);
            } catch (e) {
              logD(' auth provider updatingProfile error $e', tag);
            }
          }
          // Future.delayed(
          //     Duration(milliseconds: 2000), () => Get.offAll(LoginScreen()));
          snackBar(message, context);
        } else {
          snackBar(message, context);
        }
        notifyListeners();
      } else {
        String errorMessage = ApiErrorHandler.getErrorText(apiResponse);
        notifyListeners();
      }
    } catch (e) {}*/
    await saveLoginToken('token');
    var user = UserModel(
        id: 2345678,
        email: 'thetdsdev@gmail.com',
        fullname: 'Chandan Kumar Singh');
    await StreamAuthScope.of(context).signIn(user);
    await updateUser(user);
    sendingLoginOTP = false;
    notifyListeners();
    var token = await authRepo.getLoginToken();
    var userData = await authRepo.getUser();

    infoLog('verifyLoginOTP token $token, userdata $userData');

    return true;
    return status;
  }

  Future<bool> updateProfile(String email, String fullname) async {
    bool status = false;
    updatingProfile = true;
    notifyListeners();
    /*   ApiResponse apiResponse =
        await authRepo.updateProfile({'email': email, 'fullname': fullname});
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      Map map = apiResponse.response?.data;
      String message = '';
      try {
        message = map["message"];
        status = map["status"];
      } catch (e) {}
      // status
      //     ? Toasts.showSuccessNormalToast(message.split('.').first)
      //     : Toasts.showErrorNormalToast(message.split('.').first);
      if (status) {
        try {
          await updateUser(UserModel.fromJson(map['userData']));
          await saveLoginToken(map['token']);
        } catch (e) {
          logD(' auth provider updatingProfile error $e', tag);
        }
      }
      notifyListeners();
    } else {
      String errorMessage = ApiErrorHandler.getErrorText(apiResponse);
      notifyListeners();
    }
*/
    await Future.delayed(Duration(seconds: 3));
    updatingProfile = false;
    notifyListeners();
    return status;
  }

  Future<UserModel?> getUserInfo() async {
    bool status = false;
    UserModel? user;
    ApiResponse apiResponse = await authRepo.getUserInfo();
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      Map map = apiResponse.response?.data;
      String message = '';
      try {
        message = map["message"];
        status = map["status"];
      } catch (e) {}
      // status
      //     ? Toasts.showSuccessNormalToast(message.split('.').first)
      //     : Toasts.showErrorNormalToast(message.split('.').first);
      if (status) {
        try {
          user = UserModel.fromJson(map['userData']);
          await updateUser(user);
        } catch (e) {
          logD(' auth provider getUser Info error $e', tag);
        }
      }
      notifyListeners();
    } else {
      String errorMessage = ApiErrorHandler.getErrorText(apiResponse);
      notifyListeners();
    }
    return user;
  }

  Future<void> updateUser(UserModel newUser) async {
    user = newUser;
    notifyListeners();
    await authRepo.saveUser(newUser);
    logD('user update in prefs successfully! ${user.toJson()}', tag);
  }

  Future<UserModel?> getUser() async {
    return await authRepo.getUser();
  }

  Future<void> saveLoginToken(String token) async =>
      await authRepo.saveLoginToken(token);
  Future<void> clearUser() async => await authRepo.clearUser();
}
