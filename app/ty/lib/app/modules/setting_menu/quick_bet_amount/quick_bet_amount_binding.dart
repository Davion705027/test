import 'package:get/get.dart';

import 'quick_bet_amount_controller.dart';

class QuickBetAmountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuickBetAmountController());
  }
}
