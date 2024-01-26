import 'package:get/get.dart';

import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';

class CompletedTasksController extends GetxController {
  bool _getCompletedTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCompletedTaskInProgress => _getCompletedTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  set getCompletedTaskInProgress(bool value) {
    _getCompletedTaskInProgress = value;
    update();
  }

  Future<bool> getCompletedTaskList() async {
    bool result = false;
    _getCompletedTaskInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.getCompletedTasks,
    );

    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      result = true;
    }

    getCompletedTaskInProgress = false;
    update();
    return result;
  }
}
