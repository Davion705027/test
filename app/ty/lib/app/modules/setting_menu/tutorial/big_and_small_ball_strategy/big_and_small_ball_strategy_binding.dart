import 'package:get/get.dart';

import 'big_and_small_ball_strategy_controller.dart';

class BigAndSmallBallStrategyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BigAndSmallBallStrategyController());
  }
}
