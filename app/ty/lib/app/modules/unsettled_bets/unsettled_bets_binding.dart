import 'package:flutter_ty_app/app/modules/unsettled_bets/unsettled_bets_logic.dart';
import 'package:get/get.dart';



class UnsettledBetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UnsettledBetsLogic());
  }
}
