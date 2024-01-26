import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  String _errorMessage = "";

  bool get loginInProgress => _loginInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _loginInProgress = true;
    update();

    final response = await NetworkCaller().postRequest(
      Urls.login,
      body: {
        "email": email,
        "password": password,
      },
      isLogin: true,
    );

    _loginInProgress = false;
    update();

    if (response.isSuccess) {
      Get.find<AuthController>().saveUserInformation(
        response.jsonResponse["token"],
        UserModel.fromJson(
          response.jsonResponse["data"],
        ),
      );

      return true;
    } else {
      if (response.statusCode == 401) {
        _errorMessage = "Please Check Email/Password";
      } else {
        _errorMessage = "Login Failed! Try Again";
      }
      update();
    }

    return false;
  }
}
