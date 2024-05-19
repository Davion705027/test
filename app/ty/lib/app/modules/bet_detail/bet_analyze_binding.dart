import 'package:get/get.dart';

import 'bet_analyze_controller.dart';

class BetAnalyzeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BetAnalyzeController());
  }
}
