import 'package:get/get.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';

class ForgotPasswordController extends GetxController {
  bool _verifyEmailInProgress = false;
  bool get verifyEmailInProgress => _verifyEmailInProgress;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Future<bool> forgetPassword(String email) async {
    bool result = false;
    _verifyEmailInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.recoverVerifyEmail(email),
    );

    _verifyEmailInProgress = false;
    update();

    if (response.jsonResponse["status"] == "success" && response.statusCode == 200) {
      result = true;
    } else {
      _errorMessage = response.jsonResponse["data"] ?? "Error!";
      update();
    }

    return result;
  }
}
