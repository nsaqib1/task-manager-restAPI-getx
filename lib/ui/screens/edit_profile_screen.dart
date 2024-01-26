import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_project_getx/ui/controllers/auth_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/edit_profile_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/photo_picker_controller.dart';
import 'package:task_manager_project_getx/ui/utils/form_validators.dart';
import '../widgets/body_background.dart';
import '../widgets/profile_summery_bar.dart';
import '../widgets/snackbar_builder.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = Get.find<AuthController>();
  final EditProfileController _editProfileController = Get.find<EditProfileController>();
  final PhotoPickerController _photoPickerController = Get.find<PhotoPickerController>();

  @override
  void initState() {
    super.initState();
    _emailController.text = _authController.user?.email ?? "";
    _firstNameController.text = _authController.user?.firstName ?? "";
    _lastNameController.text = _authController.user?.lastName ?? "";
    _mobileController.text = _authController.user?.mobile ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Column(
        children: [
          const ProfileSummeryBar(enableOnTap: false),
          Expanded(
            child: BodyBackground(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 30,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Update Profile",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        photoPickerField(),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "Email",
                          ),
                          validator: FormValidators.validateEmail,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            hintText: "First Name",
                          ),
                          validator: (String? value) {
                            return FormValidators.validateEmptyField(
                              value,
                              "First Name is Required!",
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            hintText: "Last Name",
                          ),
                          validator: (String? value) {
                            return FormValidators.validateEmptyField(
                              value,
                              "Last Name is Required!",
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _mobileController,
                          decoration: const InputDecoration(
                            hintText: "Mobile",
                          ),
                          validator: (String? value) {
                            return FormValidators.validateEmptyField(
                              value,
                              "Mobile is Required!",
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            hintText: "Password (Optional)",
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: GetBuilder<EditProfileController>(
                            builder: (controller) => Visibility(
                              visible: controller.updateProfileInProgress == false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                onPressed: updateProfile,
                                child: const Icon(Icons.arrow_circle_right_outlined),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateProfile() async {
    if (_formKey.currentState!.validate() == false) return;

    final bool response = await _editProfileController.updateProfile(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      mobile: _mobileController.text.trim(),
      password: _passwordController.text,
      photo: _photoPickerController.photo,
    );

    if (response) {
      _photoPickerController.clear();
      if (mounted) {
        showSnackMessage(context, 'Update profile success!');
      }
    } else {
      if (mounted) {
        showSnackMessage(context, 'Update profile failed. Try again.');
      }
    }
  }

  Future<void> _pickPhoto() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      _photoPickerController.photo = image;
    }
  }

  Container photoPickerField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: _pickPhoto,
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: GetBuilder<PhotoPickerController>(
                  builder: (controller) => Visibility(
                    visible: controller.photo == null,
                    replacement: Text(controller.photo?.name ?? ''),
                    child: const Text('Select a photo'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
