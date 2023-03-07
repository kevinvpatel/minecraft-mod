import 'package:get/get.dart';

import '../controllers/web_screen_controller.dart';

class WebScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebScreenController>(
      () => WebScreenController(),
    );
  }
}
