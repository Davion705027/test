import 'package:get/get.dart';

import '../gaming_results/gaming_results_controller.dart';
import '../normal_results/normal_results_controller.dart';
import '../result_controller.dart';
import 'championship_results_controller.dart';

class ChampionshipResultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChampionshipResultsController());
    Get.lazyPut(() => ResultController());
    Get.lazyPut(() => NormalResultsController());
    Get.lazyPut(() => GamingResultsController());
  }
}
