import 'package:get/get.dart';

import 'big_and_small_ball_strategy/big_and_small_ball_strategy_controller.dart';
import 'handicap_strategy/handicap_strategy_controller.dart';
import 'tutorial_controller.dart';

class TutorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TutorialController());
    Get.lazyPut(() => HandicapStrategyController());
    Get.lazyPut(() => BigAndSmallBallStrategyController());
  }
}
