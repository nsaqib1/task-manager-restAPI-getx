import 'package:get/get.dart';
import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;

  set getNewTaskInProgress(bool value) {
    _getNewTaskInProgress = value;
    update();
  }

  TaskListModel _taskListModel = TaskListModel();

  bool get getNewTaskInProgress => _getNewTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getNewTasks);

    _getNewTaskInProgress = false;
    update();

    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
