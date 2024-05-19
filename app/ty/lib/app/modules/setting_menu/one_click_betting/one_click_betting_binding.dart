import 'package:get/get.dart';

import 'one_click_betting_controller.dart';

class OneClickBettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OneClickBettingController());
  }
}
