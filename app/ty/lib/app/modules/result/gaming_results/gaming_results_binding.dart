import 'package:get/get.dart';

import '../normal_results/normal_results_controller.dart';
import '../result_controller.dart';
import 'gaming_results_controller.dart';

class GamingResultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GamingResultsController());
    Get.lazyPut(() => ResultController());
    Get.lazyPut(() => NormalResultsController());
  }
}
