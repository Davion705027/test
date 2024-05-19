import 'package:flutter_ty_app/app/modules/result/results_details/results_details_controller.dart';
import 'package:get/get.dart';

import 'championship_results/championship_results_controller.dart';
import 'gaming_results/gaming_results_controller.dart';
import 'normal_results/normal_results_controller.dart';
import 'result_controller.dart';

class ResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResultController());
    Get.lazyPut(() => NormalResultsController());
    Get.lazyPut(() => GamingResultsController());
    Get.lazyPut(() => ChampionshipResultsController());
  }
}
