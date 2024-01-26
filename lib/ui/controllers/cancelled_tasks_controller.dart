import 'package:get/get.dart';

import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';

class CancelledTasksController extends GetxController {
  bool _getCancelledTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCancelledTaskInProgress => _getCancelledTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  set getCancelledTaskInProgress(bool value) {
    _getCancelledTaskInProgress = value;
    update();
  }

  Future<bool> getCancelledTaskList() async {
    bool result = false;
    _getCancelledTaskInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.getCancelledTasks,
    );

    _getCancelledTaskInProgress = false;

    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      result = true;
    }
    update();
    return result;
  }
}
