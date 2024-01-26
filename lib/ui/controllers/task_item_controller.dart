import 'package:get/get.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/utils/urls.dart';

class TaskItemController extends GetxController {
  Future<bool> updateTaskStatus(String id, String status) async {
    bool result = false;
    final response = await NetworkCaller().getRequest(Urls.updateTaskStatus(id, status));
    if (response.isSuccess) {
      result = true;
    }
    return result;
  }

  Future<bool> deleteTask(String id) async {
    bool result = false;
    final response = await NetworkCaller().getRequest(Urls.deleteTask(id));
    if (response.isSuccess) {
      result = true;
    }
    return result;
  }
}
