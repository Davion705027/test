import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../login/login_head_import.dart';
import '../setting_menu/league_filter/league_filter_controller.dart';
import '../setting_menu/league_filter/league_filter_view.dart';
import '../setting_menu/league_filter/manager/league_manager.dart';
import 'championship_results/championship_results_controller.dart';
import 'gaming_results/gaming_results_controller.dart';
import 'normal_results/normal_results_controller.dart';
import 'result_logic.dart';

class ResultController extends GetxController with GetTickerProviderStateMixin {
  final Resultlogic logic = Resultlogic();
  late TabController titleTabController;

  int titleIndex = 0;

  // 选择联赛的tid
  String tid = '';

  List<String> titleList = [
    LocaleKeys.app_h5_match_normal_results.tr,
    LocaleKeys.app_h5_match_game_results.tr,
    LocaleKeys.app_h5_match_championship_results.tr,
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    titleTabController = TabController(length: titleList.length, vsync: this);
    titleTabController.addListener(() {
      titleIndex =  titleTabController.index;
      update();
    });
    LeagueManager.type.value = 28;
    LeagueManager.euid = '1';
    LeagueManager.tid.clear();
    LeagueManager.entryName = 'result';

    LeagueManager.sort.value = HomeController.to.homeState.matchListReq.sort;
    super.onInit();


  }

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

  onTitleIndex(int index) {
    titleIndex = index;
    titleTabController.animateTo(index);
    update();
    initData();
  }

  initData({String? tid = ''}){
    LeagueManager.euid.isEmpty ?  '1' :  LeagueManager.euid;
     if(titleIndex == 0){
      final normalResultsController = Get.find<NormalResultsController>();
      normalResultsController.initData(stid:tid);
      LeagueManager.type.value = 28;
      LeagueManager.euid = '1';
      LeagueManager.tid.clear();
    }else if(titleIndex == 1) {
       final gamingResultsController = Get.find<GamingResultsController>();
       gamingResultsController.initData(stid: tid);
       LeagueManager.type.value = 28;
       LeagueManager.euid = '100';
       LeagueManager.tid.clear();
    }else {
      final championshipResultsController = Get.find<ChampionshipResultsController>();
      championshipResultsController.initData();
    }
  }

  onSelectLeague() {
    Get.lazyPut(() => LeagueFilterController(finishCb: (String tid){
      initData(tid:tid);
    }));
    Get.bottomSheet(
      LeagueFilterPage(),
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
    );
  }
}
