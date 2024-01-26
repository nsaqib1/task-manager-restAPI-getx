import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/ui/controllers/completed_tasks_controller.dart';
import 'package:task_manager_project_getx/ui/widgets/snackbar_builder.dart';
import '../widgets/profile_summery_bar.dart';
import '../widgets/task_item_card.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  final CompletedTasksController _completedTasksController = Get.find<CompletedTasksController>();

  @override
  void initState() {
    super.initState();
    getCompletedTaskList();
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
            child: GetBuilder<CompletedTasksController>(
              builder: (controller) => Visibility(
                visible: controller.getCompletedTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getCompletedTaskList,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) => TaskItemCard(
                      task: controller.taskListModel.taskList![index],
                      onStatusChange: () {
                        getCompletedTaskList();
                      },
                      onDeleteTask: () {
                        getCompletedTaskList();
                      },
                      showProgress: (inProgress) {
                        controller.getCompletedTaskInProgress = inProgress;
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

  Future<void> getCompletedTaskList() async {
    final bool response = await _completedTasksController.getCompletedTaskList();
    if (response == false) {
      if (mounted) {
        showSnackMessage(context, "Error! Could Not Get The Data");
      }
    }
  }
}
