import 'package:get/get.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';

class AddNewTaskController extends GetxController {
  bool _createTaskInProgress = false;
  bool get createTaskInProgress => _createTaskInProgress;

  Future<bool> createTask({required String title, required String description}) async {
    bool result = false;
    _createTaskInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.createTask,
      body: {
        "title": title,
        "description": description,
        "status": "New",
      },
    );
    _createTaskInProgress = false;
    update();

    if (response.isSuccess) {
      result = true;
      update();
    }

    return result;
  }
}
