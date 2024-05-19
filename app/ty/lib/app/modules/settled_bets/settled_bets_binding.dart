import 'package:flutter_ty_app/app/modules/settled_bets/settled_bets_logic.dart';
import 'package:get/get.dart';



class SettledBetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettledBetsLogic());
  }
}
