import 'package:get/get.dart';

import '../controllers/list_screen_controller.dart';

class ListScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListScreenController>(
      () => ListScreenController(),
    );
  }
}
