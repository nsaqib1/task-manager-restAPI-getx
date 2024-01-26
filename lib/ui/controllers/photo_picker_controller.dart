import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerController extends GetxController {
  XFile? _photo;
  XFile? get photo => _photo;

  set photo(XFile? file) {
    _photo = file;
    update();
  }

  void clear() {
    _photo = null;
    update();
  }
}
