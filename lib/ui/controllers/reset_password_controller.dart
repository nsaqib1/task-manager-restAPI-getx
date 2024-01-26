import 'package:get/get.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';

class ResetPasswordController extends GetxController {
  bool _resetPasswordInProgress = false;
  bool get resetPasswordInProgress => _resetPasswordInProgress;

  Future<bool> resetPassword({required String email, required String otp, required String password}) async {
    bool result = false;
    _resetPasswordInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.recoverResetPass,
      body: {
        "email": email,
        "OTP": otp,
        "password": password,
      },
    );

    _resetPasswordInProgress = false;
    update();

    if (response.isSuccess && response.jsonResponse["status"] == "success") {
      result = true;
    }

    return result;
  }
}
