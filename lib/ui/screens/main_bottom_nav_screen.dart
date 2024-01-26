import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/ui/controllers/main_bottom_nav_controller.dart';

import 'cancelled_tasks_screen.dart';
import 'completed_tasks_screen.dart';
import 'new_tasks_screen.dart';
import 'progress_tasks_screen.dart';

class MainBottomNavScreen extends StatelessWidget {
  const MainBottomNavScreen({super.key});

  final List<Widget> _screens = const [
    NewTasksScreen(),
    ProgressTasksScreen(),
    CompletedTasksScreen(),
    CancelledTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (controller) => Scaffold(
        body: _screens[controller.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          onTap: controller.changeSelectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              label: "New",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.change_circle_outlined),
              label: "In Progress",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check),
              label: "Completed",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cancel),
              label: "Cancelled",
            ),
          ],
        ),
      ),
    );
  }
}
