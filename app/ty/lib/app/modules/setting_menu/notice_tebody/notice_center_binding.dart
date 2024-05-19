import 'package:get/get.dart';

import 'notice_ttbody_controller.dart';



class NoticeTtBodyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoticeTtBodyController());
  }
}
