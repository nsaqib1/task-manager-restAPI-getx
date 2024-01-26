import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/ui/controllers/new_task_controller.dart';
import 'package:task_manager_project_getx/ui/controllers/task_count_summery_controller.dart';
import 'package:task_manager_project_getx/ui/widgets/snackbar_builder.dart';

import '../../data/models/task_count.dart';
import '../widgets/profile_summery_bar.dart';
import '../widgets/summery_card.dart';
import '../widgets/task_item_card.dart';
import 'add_new_task_screen.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  final NewTaskController _newTaskController = Get.find<NewTaskController>();
  final TaskCountSummeryController _taskCountSummeryController = Get.find<TaskCountSummeryController>();

  @override
  void initState() {
    super.initState();
    _getTaskCountSummaryList();
    _getNewTaskList();
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
          GetBuilder<TaskCountSummeryController>(
            builder: (controller) => Visibility(
              visible: controller.getTaskCountSummaryInProgress == false && controller.taskCountSummaryListModel.taskCountList != null,
              replacement: const LinearProgressIndicator(),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.taskCountSummaryListModel.taskCountList?.length ?? 0,
                  itemBuilder: (context, index) {
                    TaskCount taskCount = controller.taskCountSummaryListModel.taskCountList![index];
                    return FittedBox(
                      child: SummeryCard(
                        count: taskCount.sum.toString(),
                        title: taskCount.sId ?? '',
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<NewTaskController>(
              builder: (controller) => Visibility(
                visible: controller.getNewTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: refreshScreen,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) => TaskItemCard(
                      task: controller.taskListModel.taskList![index],
                      onStatusChange: () {
                        refreshScreen();
                      },
                      onDeleteTask: () {
                        refreshScreen();
                      },
                      showProgress: (inProgress) {
                        controller.getNewTaskInProgress = inProgress;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            AddNewTaskScreen(
              onBack: refreshScreen,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> refreshScreen() async {
    _getNewTaskList();
    _getTaskCountSummaryList();
  }

  Future<void> _getNewTaskList() async {
    final bool response = await _newTaskController.getNewTaskList();

    if (response == false) {
      if (mounted) {
        showSnackMessage(context, "Error getting new task list! Try again");
      }
    }
  }

  Future<void> _getTaskCountSummaryList() async {
    final bool response = await _taskCountSummeryController.getTaskCountSummaryList();

    if (response == false) {
      if (mounted) {
        showSnackMessage(context, "Error getting task count summery! Try again");
      }
    }
  }
}
