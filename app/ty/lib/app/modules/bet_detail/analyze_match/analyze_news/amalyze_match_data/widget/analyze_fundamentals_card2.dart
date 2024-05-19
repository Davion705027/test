import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_basketball_header.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_basketball_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_header.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_header2.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_item2.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_history_header_widget.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/text_no_data.dart';

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

class AnalyzeFundamentalsCard2  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildHistoryWar();
  }

//  历史交战
  buildHistoryWar() {
    return Card(
      margin: EdgeInsets.only(top: 10.w),
      color: Get.theme.tabPanelBackgroundColor,
      child: Container(
        color: Get.theme.tabPanelBackgroundColor,
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            ItemHistoryHeaderWidget(
              name: LocaleKeys.analysis_football_matches_historical_war.tr,
            ),
            AnalyzeDivider(),
            buildHistory()
          ],
        ),
      ),
    );
  }
  //历史交战
  buildHistory() {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "buildHistory",
        builder: (controller) {
          return controller.state.analyzeTeamsList.isEmpty
              ? TextNoData(
            content: LocaleKeys.analysis_football_matches_no_data.tr,
          )
              : Container(
              margin: EdgeInsets.all(5.w),
              child: Column(
                children: [
                  Container(
                    margin:
                    EdgeInsets.only(top: 10.w, left: 5.w, right: 5.w),
                    child: AnalyzeMatchHistoryChildHeader2(
                        onChanged: (int value) {
                          controller.switchBuildHistory(value);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.w),
                    child: AnalyzeDivider(),
                  ),
                  ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.state.analyzeTeamsList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    //列表项构造器
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(10.w),
                        child: AnalyzeMatchHistoryChildItem2(
                            controller.state.analyzeTeamsList[index]),
                      );
                    },
                    //分割器构造器
                    separatorBuilder: (BuildContext context, int index) {
                      return AnalyzeDivider();
                    },
                  )
                ],
              ));
        });
  }
}