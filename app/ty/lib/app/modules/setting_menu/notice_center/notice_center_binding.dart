import 'package:get/get.dart';

import 'notice_center_controller.dart';

class NoticeCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoticeCenterController());
  }
}
