import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/ui/controllers/auth_controller.dart';
import 'package:task_manager_project_getx/ui/screens/login_screen.dart';

import '../screens/edit_profile_screen.dart';

import 'dart:convert';
import 'dart:typed_data';

class ProfileSummeryBar extends StatefulWidget {
  const ProfileSummeryBar({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileSummeryBar> createState() => _ProfileSummeryBarState();
}

class _ProfileSummeryBarState extends State<ProfileSummeryBar> {
  final AuthController _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => ListTile(
        onTap: widget.enableOnTap
            ? () {
                Get.to(const EditProfileScreen());
              }
            : null,
        leading: CircleAvatar(
          child: photo == null
              ? const Icon(Icons.person)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.memory(
                    photo!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
        title: Text(
          fullname,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          email,
          style: const TextStyle(color: Colors.white),
        ),
        tileColor: Colors.green,
        trailing: IconButton(
          onPressed: () async {
            await AuthController.clearAuthData();
            Get.offAll(const LoginScreen());
          },
          icon: const Icon(Icons.logout),
        ),
      ),
    );
  }

  String get fullname {
    final user = _authController.user;
    return "${user?.firstName ?? ""} ${user?.lastName ?? ""}";
  }

  String get email {
    return _authController.user?.email ?? "";
  }

  Uint8List? get photo {
    final String? userPhoto = _authController.user?.photo;
    if (userPhoto == null) return null;
    try {
      Uint8List imageBytes = const Base64Decoder().convert(userPhoto);
      return imageBytes;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
