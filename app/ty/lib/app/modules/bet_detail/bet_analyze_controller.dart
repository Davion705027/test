import 'dart:convert';
import 'dart:math';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

class BetAnalyzeController extends GetxController {
  int pageSize = 20;
  int page = 1;

  RefreshController refreshController = RefreshController(initialRefresh: true);
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  RxBool isHave = true.obs;

  BetAnalyzeController() {
    onRefresh();
    print("=====>初始化BetAnalyzeController");
  }

  @override
  void onReady() {
    super.onReady();
    initData();
    // onRefresh();
  }
  onRefresh() async {

    update(["listBetAnalyzeController","betHaveAnalyzeController"]);
  }
  void initData() async {
    update(["betHaveAnalyzeController"]);
  }



  @override
  onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
