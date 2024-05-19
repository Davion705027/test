import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_basketball_header.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_basketball_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_header.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_header2.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_item2.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_recent_card.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_stop_list_card.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_history_header_two_widget.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_history_header_widget.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/text_no_data.dart';
import 'package:flutter_ty_app/app/services/models/res/match_analysises_third_match_sidelined_dto_data_bean.dart';

import '../../../../../../services/api/analyze_v_s_info_entity.dart';

import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/analyze_match_data_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_board_card.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/widget/BoxShadowContaine.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/models/res/analyze_get_match_analysise_data_entity.dart';
import '../../../../../../services/models/res/analyze_get_match_analysise_data_match_history_battle_entity.dart';
import '../../../../../../widgets/no_data.dart';
import '../../../../../login/login_head_import.dart';

import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';

class AnalyzeFundamentalsCard4  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildStopageCondition();
  }

  //伤停名单
  buildStopageCondition() {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "buildStopMeunList",
        builder: (controller) {
          var data = controller
              .state.analyzeGetMatchAnalysiseDataItemEntity["basicInfoMap"];

          return Card(
            color: Get.theme.tabPanelBackgroundColor,
            margin: EdgeInsets.only(top: 10.w),
            child: Container(
              color: Get.theme.tabPanelBackgroundColor,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  ItemHeaderWidget(
                    name: LocaleKeys.analysis_football_matches_Injury_situation.tr,
                    showDivider: true,
                  ),
                  (controller.state.analyzeGetMatchAnalysiseDataItemEntity[
                  "basicInfoMap"] ==
                      null ||
                      controller.state.analyzeGetMatchAnalysiseDataItemEntity[
                      "basicInfoMap"]["sThirdMatchSidelinedDTOMap"] ==
                          null)
                      ? TextNoData()
                      : buildStopMeunList(),
                  SizedBox(
                    height: 200.w,
                  )
                ],
              ),
            ),
          );
        });
  }



  buildStopMeunList() {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "buildStopMeunList",
        builder: (controller) {
          List<MatchAnalysisesThirdMatchSidelinedDTODataBean> entitys = [];

          Map<String, dynamic> map = controller
              .state.analyzeGetMatchAnalysiseDataItemEntity["basicInfoMap"]
          ["sThirdMatchSidelinedDTOMap"] ??
              {};
          List<List<MatchAnalysisesThirdMatchSidelinedDTODataBean>> list = [];
          print("=======>length  ${map.length}");

          map.forEach((key, value) {
            var childMap = value as List;
            List<MatchAnalysisesThirdMatchSidelinedDTODataBean> childList = childMap
                .map((e) =>
                MatchAnalysisesThirdMatchSidelinedDTODataBean.fromJson(e))
                .toList();
            list.add(childList);
          });
          return list.isEmpty?TextNoData():Column(
            children: list
                .map((e) => AnalyzeMatchStopListCard(e == list[0],
              e,
              e == list[0]?
              controller.state.home[0].awayTeamName ?? ""
                  :controller.state.home[0].homeTeamName?? "",
              controller.state.home[0].awayTeamName ?? "",
            ))
                .toList(),
          );
        });
  }
}