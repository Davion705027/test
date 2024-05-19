import 'package:get/get.dart';

import '../controllers/match_bet_list_controller.dart';

class MatchBetListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MatchBetListController());
  }
}
