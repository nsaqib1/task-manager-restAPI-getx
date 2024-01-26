import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/user_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class EditProfileController extends GetxController {
  bool _updateProfileInProgress = false;
  bool get updateProfileInProgress => _updateProfileInProgress;

  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String mobile,
    required String password,
    required XFile? photo,
  }) async {
    bool result = false;
    _updateProfileInProgress = true;
    update();

    String? photoInBase64;
    Map<String, dynamic> inputData = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "mobile": mobile,
    };

    if (password.isNotEmpty) {
      inputData['password'] = password;
    }

    if (photo != null) {
      List<int> imageBytes = await photo.readAsBytes();
      photoInBase64 = base64Encode(imageBytes);
      inputData['photo'] = photoInBase64;
    }

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.updateProfile,
      body: inputData,
    );
    _updateProfileInProgress = false;
    update();
    if (response.isSuccess) {
      final authController = Get.find<AuthController>();
      authController.updateUserInformation(
        UserModel(
          email: email,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile,
          photo: photoInBase64 ?? authController.user?.photo,
        ),
      );
      result = true;
      update();
    }
    return result;
  }
}
