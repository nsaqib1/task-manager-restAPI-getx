import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_project_getx/data/models/user_model.dart';

class AuthController extends GetxController {
  static String? token;
  UserModel? user;

  Future<void> saveUserInformation(String t, UserModel userModel) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", t);
    sharedPreferences.setString("user", jsonEncode(userModel.toJson()));
    token = t;
    user = userModel;
    update();
  }

  Future<void> updateUserInformation(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', jsonEncode(model.toJson()));
    user = model;
    update();
  }

  Future<void> initializeUserCache() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    final userJsonString = sharedPreferences.getString("user");
    if (userJsonString != null) {
      user = UserModel.fromJson(jsonDecode(userJsonString));
      update();
    }
  }

  Future<bool> checkAuthState() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("token")) {
      await initializeUserCache();
      return true;
    }
    return false;
  }

  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    token = null;
  }
}
