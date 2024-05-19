import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../bet_analyze_controller.dart';

class BetHaveAnalyzeController extends GetxController {
  int pageSize = 20;
  int page = 1;
  String ticketResult = "";
  RefreshController refreshController = RefreshController(initialRefresh: true);
  RxBool waiting = true.obs;
  BetAnalyzeController betAnalyzeController = Get.find<BetAnalyzeController>();

  BetHaveAnalyzeController() {
    onRefresh();

    print("=====>初始化BetAnalyzeController");
  }

  @override
  void onReady() {
    super.onReady();

    // onRefresh();
  }

  onRefresh() async {
    print("=========>加载");

    update(["listBetAnalyzeController"]);
  }

  onLoading() async {

  }

  @override
  onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
