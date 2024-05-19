import 'package:get/get.dart';

import '../gaming_results/gaming_results_controller.dart';
import '../result_controller.dart';
import 'normal_results_controller.dart';

class NormalResultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResultController());
    Get.lazyPut(() => NormalResultsController());
    Get.lazyPut(() => GamingResultsController());
  }
}
