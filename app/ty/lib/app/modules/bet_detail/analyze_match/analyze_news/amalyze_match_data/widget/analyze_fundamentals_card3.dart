import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_basketball_header.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_basketball_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_header.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_header2.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_item2.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_recent_card.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_history_header_two_widget.dart';
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

class AnalyzeFundamentalsCard3  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildRecentWar();
  }
//近期战绩
  buildRecentWar() {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "buildRecentHistory",
        builder: (controller) {
          return Card(
            color: Get.theme.tabPanelBackgroundColor,
            margin: EdgeInsets.only(top: 10.w),
            child: Container(
              color: Get.theme.tabPanelBackgroundColor,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  ItemHistoryHeaderTwoWidget(
                    name: LocaleKeys.analysis_football_matches_recent_record.tr,
                  ),
                  (controller.state.home.isNotEmpty ||
                      controller.state.away.isNotEmpty)
                      ?Column(
                    children: [
                      AnalyzeMatchHistoryRecentCard(
                          controller.state.home,
                          controller.state.home[0].homeTeamName ?? "",

                          controller.getPlayImage( controller.state.home[0].homeTeamName??""),
                          controller.state.homeVSHistoryMap),
                      AnalyzeMatchHistoryRecentCard(
                          controller.state.away,
                          controller.state.home[0].awayTeamName ?? "",

                          controller.getPlayImage( controller.state.home[0].awayTeamName??""),
                          controller.state.awayVSHistoryMap),
                    ],
                  ): NoData(
                    content:
                    LocaleKeys.analysis_football_matches_no_data.tr,
                    top: 30.h,
                  )

                  // AnalyzeDivider(
                  //   color: Colors.grey.withOpacity(0.2),
                  //   height: 0.5,
                  // ),
                  // AnalyzeMatchHistoryRecentCard(controller.state.away)
                ],
              ),
            ),
          );
        });
  }

}