import '../../ui/widgets/task_item_card.dart';

class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createTask = '$_baseUrl/createTask';
  static String getNewTasks = '$_baseUrl/listTaskByStatus/${TaskStatus.New.name}';
  static String getCompletedTasks = '$_baseUrl/listTaskByStatus/${TaskStatus.Completed.name}';
  static String getCancelledTasks = '$_baseUrl/listTaskByStatus/${TaskStatus.Cancelled.name}';
  static String getInProgressTasks = '$_baseUrl/listTaskByStatus/${TaskStatus.Progress.name}';
  static const String getTaskStatusCount = '$_baseUrl/taskStatusCount';

  static String updateTaskStatus(String taskId, String status) => '$_baseUrl/updateTaskStatus/$taskId/$status';

  static String deleteTask(String taskId) => '$_baseUrl/deleteTask/$taskId';

  static const String updateProfile = '$_baseUrl/profileUpdate';

  static String recoverVerifyEmail(String email) => "$_baseUrl/RecoverVerifyEmail/$email";

  static String recoverVerifyOTP(String email, String otp) => "$_baseUrl/RecoverVerifyOTP/$email/$otp";

  static const String recoverResetPass = "$_baseUrl/RecoverResetPass";
}
