import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/ui/controllers/cancelled_tasks_controller.dart';
import 'package:task_manager_project_getx/ui/widgets/snackbar_builder.dart';
import '../widgets/profile_summery_bar.dart';
import '../widgets/task_item_card.dart';

class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({super.key});

  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}

class _CancelledTasksScreenState extends State<CancelledTasksScreen> {
  final _cancelledTasksController = Get.find<CancelledTasksController>();

  @override
  void initState() {
    getCancelledTaskList();
    super.initState();
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
          const ProfileSummeryBar(),
          Expanded(
            child: GetBuilder<CancelledTasksController>(
              builder: (controller) => Visibility(
                visible: controller.getCancelledTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getCancelledTaskList,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) => TaskItemCard(
                      task: controller.taskListModel.taskList![index],
                      onStatusChange: () {
                        getCancelledTaskList();
                      },
                      onDeleteTask: () {
                        getCancelledTaskList();
                      },
                      showProgress: (inProgress) {
                        controller.getCancelledTaskInProgress = inProgress;
                      },
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemCount: controller.taskListModel.taskList?.length ?? 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getCancelledTaskList() async {
    final response = await _cancelledTasksController.getCancelledTaskList();
    if (response == false) {
      if (mounted) {
        showSnackMessage(context, "Error! Could Not Get The Data");
      }
    }
  }
}
