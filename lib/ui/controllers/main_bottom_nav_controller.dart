import 'package:get/get.dart';

class MainBottomNavController extends GetxController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  void changeSelectedIndex(int value) {
    _selectedIndex = value;
    update();
  }
}
