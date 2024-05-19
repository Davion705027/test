import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import 'big_and_small_ball_strategy/big_and_small_ball_strategy_controller.dart';
import 'handicap_strategy/handicap_strategy_controller.dart';
import 'tutorial_logic.dart';

class TutorialController extends GetxController {
  final Tutoriallogic logic = Tutoriallogic();

  int tutorial = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  onTutorial(int index) {
    tutorial = index;
    tutorial == 0
        ? Get.lazyPut(() => HandicapStrategyController())
        : Get.lazyPut(() => BigAndSmallBallStrategyController());

    update();
  }
}
