import 'dart:convert';

import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../../services/models/res/match_entity.dart';
import '../../../../match_detail/controllers/analyze_tab_controller.dart';
import '../../../../match_detail/controllers/match_detail_controller.dart';
import 'analyze_match_result_data.dart';
import 'analyze_match_result_state.dart';

class AnalyzeMatchResultLogic extends GetxController {
  static AnalyzeMatchResultLogic get to => Get.find();
  final AnalyzeMatchResultState state = AnalyzeMatchResultState();
  String? mid;
  late bool noData = true;
  bool showBasketBall = false;

  List<AnalyzeMatchResultItem> first = [];
  List<AnalyzeMatchResultItem> second = [];
  List<AnalyzeMatchResultItem> three = [];
  AnalyzeMatchResultData analyzeMatchResultData = AnalyzeMatchResultData();
  List<AnalyzeMatchResultItem> football_ring_statistics = [];
  List<AnalyzeMatchResultItem> football_card_corner_list = [];
  List<AnalyzeMatchResultItem> football_progress_graph = [];

  List<AnalyzeMatchResultItem> basketball_card_corner_list = [];
  List<AnalyzeMatchResultItem> basketball_ring_statistics = [];
  List<AnalyzeMatchResultItem> basketball_progress_graph = [];

  List<AnalyzeMatchResultItem> ring_statistics = [];
  List<AnalyzeMatchResultItem> card_corner_list = [];
  List<AnalyzeMatchResultItem> progress_graph = [];
  String? tag;

  @override
  void onReady() {
    super.onReady();

    initData();
  }

  Future<void> getData() async {
// 计算第一个环形
    MatchEntity? match = Get.find<MatchDetailController>(tag: tag).detailState.match;

    first = sumCircleNumber(ring_statistics, match);
    second = sumCircleNumber(card_corner_list, match);
    three = sumCircleNumber(progress_graph, match);
    update(["buildMatchProgress"]);
  }

  List<AnalyzeMatchResultItem> sumCircleNumber(
      List<AnalyzeMatchResultItem> arr, MatchEntity? match) {
    List<AnalyzeMatchResultItem> tempList = [];
    //测试代码
    bool env =const bool.fromEnvironment("PACKAGE_MOCK", defaultValue: false);
    if(env){
      match?.msc=["S0|0:1","S1|0:1","S2|0:1","S5|0:1","S6|0:0","S8|2:13","S10|0:0","S11|0:0","S12|0:0","S13|0:0","S14|0:0","S15|0:1","S17|0:3","S18|0:1","S104|6:13","S105|0:0","S555|0:1","S1001|0:1","S1002|0:0","S1003|0:0","S1004|0:0","S1005|0:0","S1006|0:0","S1101|0:4","S5001|0:0","S5002|0:1","S5003|0:0","S5004|0:0","S5005|0:0","S5006|0:0","S10011|0:0","S10013|0:1","S10021|0:0","S10101|0:0","S10102|0:0","S10103|0:0","S11001|0:0","S12001|0:0","S50011|0:0","S50012|0:0"];
    }
    if (match?.msc.isEmpty == true) {
      tempList.addAll(arr);
      return tempList;
    }
    print("=======>数据  ${jsonEncode(match?.msc??"")}");
    for (AnalyzeMatchResultItem item in arr) {
      for (String data in match?.msc ?? []) {
        if (!data.contains(item.score_type)) {
          continue;
        }
        if (data.split("|").length <= 1) {
          continue;
        }
        String k = data.split("|")[0];
        String odds = data.split("|")[1];

        int home = (odds.split(":").length > 1)
            ? (num.tryParse(odds.split(":")[0])?.toInt() ?? 0)
            : 0;
        int away = (odds.split(":").length > 1)
            ? (double.tryParse(odds.split(":")[1])?.toInt() ?? 0)
            : 0;
        if (((home + away) != 0)) {
          item.home = home;
          item.away = away;
        }

        if (["S8", "S105", "S1088", "S111"].contains(item.score_type)) {
          item.proportion = ((double.tryParse((item.away.toDouble() /
                              ((item.home + item.away) == 0
                                  ? 1
                                  : (item.home + item.away)))
                          .toStringAsFixed(2)) ??
                      0) *
                  100)
              .truncate();
        } else if ([
          "S104",
          "S1101",
          "S18",
          "S17",
          "S19",
          "S107",
          "S110",
          "S108"
        ].contains(item.score_type)) {
          item.proportion = ((double.tryParse((item.home.toDouble() /
                              ((item.home + item.away) == 0
                                  ? 1
                                  : (item.home + item.away)))
                          .toStringAsFixed(2)) ??
                      0) *
                  100)
              .truncate();
        }

        tempList.add(item);
        break;
      }
    }
    return tempList;
  }

  getTeamName(
    MatchEntity otherMatch, {
    int? type,
  }) {
    return Get.find<MatchDetailController>(tag: tag).getTeamName(
        type: type ?? 1, match: otherMatch);
  }

  void initAnalyzeData() {
    football_ring_statistics.clear();
    basketball_ring_statistics.clear();

    football_card_corner_list.clear();
    basketball_card_corner_list.clear();

    football_progress_graph.clear();
    basketball_progress_graph.clear();

    ring_statistics.clear();
    card_corner_list.clear();
    progress_graph.clear();

    analyzeMatchResultData = AnalyzeMatchResultData();

    football_ring_statistics.add(AnalyzeMatchResultItem(
        "S8", LocaleKeys.match_result_dangerous_offense.tr, ""));
    football_ring_statistics.add(AnalyzeMatchResultItem(
        "S105", LocaleKeys.match_result_ball_possession.tr, ""));

    //S1088 三分命中率
    basketball_ring_statistics.add(AnalyzeMatchResultItem(
        "S1088", LocaleKeys.match_result_three_point_shooting.tr, ""));
    //S1235 投篮命中率
    basketball_ring_statistics.add(AnalyzeMatchResultItem(
        "S1235", LocaleKeys.match_result_Field_goal_percentage.tr, ""));
    //S111 罚球命中率
    basketball_ring_statistics.add(AnalyzeMatchResultItem(
        "S111", LocaleKeys.match_result_Free_throw_percentage.tr, ""));

    // S12 黄牌比分
    football_card_corner_list.add(AnalyzeMatchResultItem(
        "S12", LocaleKeys.match_result_yellow_card.tr, "yellow_card"));
    // S11	红牌比分
    football_card_corner_list.add(AnalyzeMatchResultItem(
        "S11", LocaleKeys.match_result_red_card.tr, "red_card"));
    // S5	角球比分
    football_card_corner_list.add(AnalyzeMatchResultItem(
        "S5", LocaleKeys.football_playing_way_corner.tr, ""));

    //犯规数
    basketball_card_corner_list.add(AnalyzeMatchResultItem(
        "S106", LocaleKeys.match_result_Fouls.tr, "whistle_img"));
    //剩余暂停
    basketball_card_corner_list.add(AnalyzeMatchResultItem(
        "S109", LocaleKeys.match_result_Remaining_pause.tr, "time_out_img"));


    //S104 进攻
    football_progress_graph.add(
        AnalyzeMatchResultItem("S104", LocaleKeys.match_result_attack.tr, ""));


    // S1101 射门
    football_progress_graph.add(
        AnalyzeMatchResultItem("S1101", LocaleKeys.match_result_shot.tr, ""));
    // S18   射正
    football_progress_graph.add(AnalyzeMatchResultItem(
        "S18", LocaleKeys.match_result_shoot_right.tr, ""));
    // S17   射偏
    football_progress_graph.add(
        AnalyzeMatchResultItem("S17", LocaleKeys.match_result_shot_off.tr, ""));

    // 三分球得分
    basketball_progress_graph.add(AnalyzeMatchResultItem(
        "S108", LocaleKeys.match_result_Three_pointer.tr, ""));
    // 两分球得分
    basketball_progress_graph.add(AnalyzeMatchResultItem(
        "S107", LocaleKeys.match_result_Two_pointer.tr, ""));
    // 罚球得分
    basketball_progress_graph.add(AnalyzeMatchResultItem(
        "S110", LocaleKeys.match_result_Free_throw.tr, ""));

    if (showBasketBall) {
      ring_statistics = basketball_ring_statistics;
      card_corner_list = basketball_card_corner_list;
      progress_graph = basketball_progress_graph;
      //S1088 三分命中率
      analyzeMatchResultData.ring_statistics.add(AnalyzeMatchResultItem(
          "S1088", LocaleKeys.match_result_three_point_shooting.tr, ""));
      //S1235 投篮命中率
      analyzeMatchResultData.ring_statistics.add(AnalyzeMatchResultItem(
          "S1235", LocaleKeys.match_result_Field_goal_percentage.tr, ""));
      //S111 罚球命中率
      analyzeMatchResultData.ring_statistics.add(AnalyzeMatchResultItem(
          "S111", LocaleKeys.match_result_Free_throw_percentage.tr, ""));

      //犯规数
      analyzeMatchResultData.card_corner_list.add(AnalyzeMatchResultItem(
          "S106", LocaleKeys.match_result_Fouls.tr, "whistle_img"));
      //剩余暂停
      analyzeMatchResultData.card_corner_list.add(AnalyzeMatchResultItem(
          "S109", LocaleKeys.match_result_Remaining_pause.tr, "time_out_img"));

// 三分球得分
      analyzeMatchResultData.progress_graph.add(AnalyzeMatchResultItem(
          "S108", LocaleKeys.match_result_Three_pointer.tr, ""));
      // 两分球得分
      analyzeMatchResultData.progress_graph.add(AnalyzeMatchResultItem(
          "S107", LocaleKeys.match_result_Two_pointer.tr, ""));
      // 罚球得分
      analyzeMatchResultData.progress_graph.add(AnalyzeMatchResultItem(
          "S110", LocaleKeys.match_result_Free_throw.tr, ""));
    } else {
      ring_statistics = football_ring_statistics;
      card_corner_list = football_card_corner_list;
      progress_graph = football_progress_graph;
      //S8 危险进攻
      analyzeMatchResultData.ring_statistics.add(AnalyzeMatchResultItem(
          "S8", LocaleKeys.match_result_dangerous_offense.tr, ""));
      // S105 球权/控球率
      analyzeMatchResultData.ring_statistics.add(AnalyzeMatchResultItem(
          "S105", LocaleKeys.match_result_ball_possession.tr, ""));

      // S12 黄牌比分
      analyzeMatchResultData.card_corner_list.add(AnalyzeMatchResultItem(
          "S12", LocaleKeys.match_result_yellow_card.tr, "yellow_card"));
      // S11	红牌比分
      analyzeMatchResultData.card_corner_list.add(AnalyzeMatchResultItem(
          "S11", LocaleKeys.match_result_red_card.tr, "red_card"));
      // S5	角球比分
      analyzeMatchResultData.card_corner_list.add(
          AnalyzeMatchResultItem("S5", LocaleKeys.match_result_corner.tr, ""));
    //   //    S104 进攻
    //       {score_type:'S104', text: i18n_t('match_result.attack'), home: 0, away: 0, proportion: 0 },
    // //    S1101 射门        S12 黄牌比分
    //     {score_type:'S1101', text: i18n_t('match_result.shot'), home: 0, away: 0, proportion: 0 },
    // //    S18   射正        S11	红牌比分
    //     {score_type:'S18', text: i18n_t('match_result.shoot_right'), home: 0, away: 0, proportion: 0 },
    // //    S17   射偏        S5	角球比分
    //     {score_type:'S17', text: i18n_t('match_result.shot_off'), home: 0, away: 0, proportion: 0 }

    // S1101 射门
    analyzeMatchResultData.progress_graph.add(
    AnalyzeMatchResultItem("S104", LocaleKeys.match_result_attack.tr, ""));
    // S1101 射门
      analyzeMatchResultData.progress_graph.add(
          AnalyzeMatchResultItem("S1101", LocaleKeys.match_result_shot.tr, ""));
      // S18   射正
      analyzeMatchResultData.progress_graph.add(AnalyzeMatchResultItem(
          "S18", LocaleKeys.match_result_shoot_right.tr, ""));
      // S17   射偏
      analyzeMatchResultData.progress_graph.add(AnalyzeMatchResultItem(
          "S17", LocaleKeys.match_result_shot_off.tr, ""));
    }
  }

  void initData() async {
    mid = Get.find<MatchDetailController>(tag: tag).detailState.mId;
    print("===========>联赛小改mid  ${mid}");
    String csid = Get.find<MatchDetailController>(tag: tag).detailState.match?.csid ?? "";
    if (csid == "2") {
      showBasketBall = true;
    }
    initAnalyzeData();
    getData();
  }
}
