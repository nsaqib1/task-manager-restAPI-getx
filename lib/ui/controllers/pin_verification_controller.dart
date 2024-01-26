import 'package:get/get.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';

class PinVerificationController extends GetxController {
  String _otp = "";
  bool _otpComplete = false;
  bool _otpVerificationInProgress = false;

  String get otp => _otp;
  bool get otpComplete => _otpComplete;
  bool get otpVerificationInProgress => _otpVerificationInProgress;

  set otp(String value) {
    _otp = value;
    update();
  }

  set otpComplete(bool value) {
    _otpComplete = value;
    update();
  }

  Future<bool> verifyOTP(String email) async {
    bool result = false;
    _otpVerificationInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.recoverVerifyOTP(
        email,
        _otp,
      ),
    );

    _otpVerificationInProgress = false;
    update();

    if (response.isSuccess && response.jsonResponse['status'] != 'fail') {
      result = true;
    }

    return result;
  }
}
