// controllers/main_controller.dart

import 'package:get/get.dart';

class MainController extends GetxController {
  // Add any properties or methods related to your main controller here
  final RxInt currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
