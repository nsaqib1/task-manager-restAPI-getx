import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/ui/controllers/progress_task_controller.dart';
import 'package:task_manager_project_getx/ui/widgets/snackbar_builder.dart';
import '../widgets/profile_summery_bar.dart';
import '../widgets/task_item_card.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
  final ProgressTaskController _progressTaskController = Get.find<ProgressTaskController>();
  @override
  void initState() {
    super.initState();
    getInProgressTaskList();
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
            child: GetBuilder<ProgressTaskController>(
              builder: (controller) => Visibility(
                visible: controller.getInProgressTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getInProgressTaskList,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) => TaskItemCard(
                      task: controller.taskListModel.taskList![index],
                      onStatusChange: () {
                        getInProgressTaskList();
                      },
                      onDeleteTask: () {
                        getInProgressTaskList();
                      },
                      showProgress: (inProgress) {
                        controller.getInProgressTaskInProgress = inProgress;
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

  Future<void> getInProgressTaskList() async {
    final bool response = await _progressTaskController.getInProgressTaskList();
    if (response == false) {
      if (mounted) {
        showSnackMessage(context, "Error getting the data! Try again");
      }
    }
  }
}
