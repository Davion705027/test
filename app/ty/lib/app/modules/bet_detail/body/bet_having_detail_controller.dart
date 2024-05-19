import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../bet_analyze_controller.dart';

class BetHavingAnalyzeController extends GetxController {


  BetHavingAnalyzeController( ) {
    BetAnalyzeController controller=Get.find<BetAnalyzeController>();
    onRefresh();
    print("=====>初始化BetAnalyzeController");
  }

  @override
  void onReady() {
    super.onReady();

    // onRefresh();
  }

  onRefresh() async {

    update(["listBetAnalyzeController"]);
  }

  onLoading() async {

  }

  @override
  onClose() {
    super.onClose();
  }
}
