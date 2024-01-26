import 'package:get/get.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';

class SignupController extends GetxController {
  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;

  Future<bool> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String mobile,
  }) async {
    bool result = false;
    _signUpInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.registration,
      body: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "mobile": mobile,
      },
    );
    _signUpInProgress = false;
    update();
    if (response.isSuccess && response.jsonResponse["status"] == "success") {
      result = true;
    }

    return result;
  }
}
