import 'package:get/get.dart';

import 'handicap_strategy_controller.dart';

class HandicapStrategyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HandicapStrategyController());
  }
}
