import 'package:get/get.dart';

import '../../data/models/task_count_summery_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';

class TaskCountSummeryController extends GetxController {
  bool _getTaskCountSummaryInProgress = false;
  bool get getTaskCountSummaryInProgress => _getTaskCountSummaryInProgress;

  TaskCountSummaryListModel _taskCountSummaryListModel = TaskCountSummaryListModel();
  TaskCountSummaryListModel get taskCountSummaryListModel => _taskCountSummaryListModel;
  Future<bool> getTaskCountSummaryList() async {
    bool result = false;
    _getTaskCountSummaryInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getTaskStatusCount);

    if (response.isSuccess) {
      _taskCountSummaryListModel = TaskCountSummaryListModel.fromJson(response.jsonResponse);
      result = true;
    }
    _getTaskCountSummaryInProgress = false;
    update();
    return result;
  }
}
