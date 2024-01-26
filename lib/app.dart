import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/auth_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/cancelled_tasks_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/completed_tasks_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/edit_profile_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/forgot_password_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/login_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/main_bottom_nav_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/new_task_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/pin_verification_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/photo_picker_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/progress_task_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/reset_password_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/signup_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/task_count_summery_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/task_item_controller.dart';
import 'ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationKey,
      theme: ThemeData(
        useMaterial3: false,
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(MainBottomNavController());
    Get.put(LoginController());
    Get.put(NewTaskController());
    Get.put(TaskCountSummeryController());
    Get.put(TaskItemController());
    Get.put(ProgressTaskController());
    Get.put(AddNewTaskController());
    Get.put(CancelledTasksController());
    Get.put(CompletedTasksController());
    Get.put(EditProfileController());
    Get.put(PhotoPickerController());
    Get.put(ForgotPasswordController());
    Get.put(PinVerificationController());
    Get.put(ResetPasswordController());
    Get.put(SignupController());
  }
}
