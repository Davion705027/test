import 'package:flutter_ty_app/app/modules/unsettled_bets/unsettled_bets_state.dart';
import 'package:get/get.dart';



class UnsettledBetsLogic extends GetxController {
  final UnsettledBetsState state = UnsettledBetsState();
  int type = 0;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

   setType(int type) {
    this.type = type;
    update();
  }
}
