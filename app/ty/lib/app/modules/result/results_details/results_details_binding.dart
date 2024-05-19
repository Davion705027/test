import 'package:get/get.dart';

import '../../match_detail/controllers/match_detail_controller.dart';
import 'results_details_controller.dart';

class ResultsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResultsDetailsController());
    Get.lazyPut(() => MatchDetailController());
  }
}
