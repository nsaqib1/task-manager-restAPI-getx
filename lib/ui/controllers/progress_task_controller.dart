import 'package:get/get.dart';
import 'package:task_manager_project_getx/data/models/task_list_model.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';

class ProgressTaskController extends GetxController {
  bool _getInProgressTaskInProgress = false;
  bool get getInProgressTaskInProgress => _getInProgressTaskInProgress;

  set getInProgressTaskInProgress(bool value) {
    _getInProgressTaskInProgress = value;
    update();
  }

  TaskListModel _taskListModel = TaskListModel();
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getInProgressTaskList() async {
    bool result = false;
    _getInProgressTaskInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.getInProgressTasks,
    );

    _getInProgressTaskInProgress = false;
    update();

    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      result = true;
    }

    return result;
  }
}
