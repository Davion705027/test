import 'dart:collection';

import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_item_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../../services/api/analyze_v_s_info_entity.dart';
import '../../../../../services/models/res/analyze_team_vs_other_team_item_entity_entity.dart';

class AnalyzeMatchDataState {
  RxInt curMainTab = 0.obs;

  //历史交战选择器
  RxBool curSelectTab1 = false.obs;
  RxBool curSelectTab2 = false.obs;
  RxString  curDay = "5".obs;
  RxString  curFlag = "0".obs;

  //近期选择器
  RxBool curOtherSelectTab1 = false.obs;
  RxBool curOtherSelectTab2 = false.obs;
  RxString  curOtherDay = "5".obs;
  RxString  curOtherFlag = "0".obs;


  RxList<AnalyzeVSInfoEntity> analyzeList = <AnalyzeVSInfoEntity>[].obs;
  RxList<AnalyzeTeamVsHistoryEntity> analyzeTeamsList =
      <AnalyzeTeamVsHistoryEntity>[].obs;
  RxList<AnalyzeTeamVsOtherTeamItemEntityEntity>
      analyzeTeamVsOtherTeamItemList =
      <AnalyzeTeamVsOtherTeamItemEntityEntity>[].obs;
  Map<String,dynamic>
      analyzeGetMatchAnalysiseDataItemEntity =
  {};

  //近期战绩
  List<AnalyzeTeamVsOtherTeamItemEntityEntity> home = [];
  List<AnalyzeTeamVsOtherTeamItemEntityEntity> away = [];
  Map<String, int> homeVSHistoryMap = {};
  Map<String, int> awayVSHistoryMap = {};

  AnalyzeMatchDataState() {
    ///Initialize variables
  }
}
