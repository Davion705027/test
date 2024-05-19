import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/services/models/res/match_details_history_entity.dart';
import 'package:get/get.dart';

import '../../../../../services/api/analyze_detail_api.dart';
import '../../../../../services/api/match_detail_api.dart';
import '../../../../../services/models/res/analyze_match_information_entity.dart';
import '../../../../../services/models/res/macth_details_news_new_entity.dart';
import '../../../../../services/models/res/match_intelligence_entity.dart';
import '../../../../match_detail/controllers/analyze_tab_controller.dart';
import '../../../../match_detail/controllers/match_detail_controller.dart';
import '../analyze_battle_array/analyze_battle_array_logic.dart';
import '../widget/data/data_tab.dart';
import 'analyze_match_information_state.dart';

class AnalyzeMatchInformationLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AnalyzeMatchInformationLogic get to => Get.find();
  final AnalyzeMatchInformationState state = AnalyzeMatchInformationState();
  late TabController tabController;
  GlobalKey<MSTabbarAnalyzeDemo1State>  mSTabbarDemo1StateKey=GlobalKey();
  MatchIntelligenceEntity? matchIntelligenceEntity;
  String? mid;
  late bool noData;
  String? tag;
  @override
  void onInit() {
    super.onInit();
    setController();
    MatchDetailController controller = Get.find<MatchDetailController>(tag: tag);
    mid = controller.detailState.mId;
  }

  @override
  void onReady(){
    super.onReady();
  }


  Future<void> initData() async {
    MatchDetailController controller = Get.find<MatchDetailController>(tag: tag);
    mid = controller.detailState.mId;
    setController();
    requestMatchData("4", "${state.curMainTab.value}", mid);
    AnalyzeBattleArrayLogic analyzeBattleArrayLogic= Get.find<AnalyzeBattleArrayLogic>();
    List<String> _tabs = analyzeBattleArrayLogic.state.teamsNames.value;
    mSTabbarDemo1StateKey.currentState?.initTeams(_tabs);
    //测试代码
    bool env =const bool.fromEnvironment("PACKAGE_MOCK", defaultValue: false);
    if(env){
      requestTest();
    }
  }

  void requestMatchData(
    String? parentMenuId,
    String? sonMenuId,
    String? standardMatchId,
  ) {
    // 接口获取的数据
    AnalyzeDetailApi.instance()
        .getMatchAnalysiseData(
      parentMenuId,
      sonMenuId,
      standardMatchId,
    ) .then((value) {
      state.analyzeGetMatchAnalysiseDataItemEntity = value.data ?? {};
      print(matchIntelligenceEntity?.data);
      if (state.analyzeGetMatchAnalysiseDataItemEntity["sThirdMatchInformationDTOList"] == null) {
        noData = true;
      } else {
        noData = false;
        state.datalist=(  state.analyzeGetMatchAnalysiseDataItemEntity["sThirdMatchInformationDTOList"] as List).map((e) => AnalyzeMatchInformationEntity.fromJson(e)).toList();
        dealData(state.datalist);
      }
      update([
        "buildList1",
      ]);
    });
  }

  void dealData(List<AnalyzeMatchInformationEntity> datalist) {

  
    for (int i = 0; i < datalist.length; i++) {
      var item=datalist[i];
      if (tabController.index== 1) {//主队
        if (item.benefit == 2) {
          state.lineupInfo[0].add(item);
        } else if (item.benefit == 4) {
          state.lineupInfo[1].add(item);
        } else if (item.benefit == 0) {
          state.lineupInfo[2].add(item);
        }
      } else {
        if (item.benefit == 3) {
          state.lineupInfo[0].add(item);
        } else if (item.benefit == 5) {
          state.lineupInfo[1].add(item);
        } else if (item.benefit == 1) {
          state.lineupInfo[2].add(item);
        }
      }
    }

  }

  void setController() {

    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (tabController.index.toDouble() == tabController.animation?.value) {
          state.curMainTab.value = tabController.index;
          requestMatchData("4", "${state.curMainTab.value+1}", mid);
        }
      });
  }

  void requestTest() {



  }
}
