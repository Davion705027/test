import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/analyze_match_data_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_board_card.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_stop_list_card.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/widget/BoxShadowContaine.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/text_no_data.dart';
import 'package:flutter_ty_app/app/services/models/res/match_analysises_third_match_sidelined_dto_data_bean.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/models/res/analyze_get_match_analysise_data_entity.dart';
import '../../../../../../services/models/res/analyze_get_match_analysise_data_match_history_battle_entity.dart';
import '../../../../../../widgets/no_data.dart';
import '../../../../../login/login_head_import.dart';

import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';

/**
 * @author[xiongwei]
 * @version[创建日期，2024/2/29 13:29]
 * @function[功能简介 ]
 **/
class disk_surface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "buildPanmian",
        builder: (controller) {
         var data= controller.state.analyzeGetMatchAnalysiseDataItemEntity[
          "matchHistoryBattleDTOMap"];
          return (data==null)
              ? NoData(
                  content: LocaleKeys.analysis_football_matches_no_data.tr,
                  top: 30.h,
                )
              : SingleChildScrollView(
            scrollDirection: Axis.vertical,
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      BoxShadowContainer(
                        padding: EdgeInsets.zero,

                        color: Get.theme.tabPanelBackgroundColor,
                        margin: EdgeInsets.only(top: 10.w,left: 6.w,right: 6.w),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 6.w),
                          color: Get.theme.tabPanelBackgroundColor,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              ItemHeaderWidget(
                                name: LocaleKeys.analysis_football_matches_Turning_trend.tr,
                                showDivider: true,
                              ),
                              buildPanmian(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        });
  }

  buildPanmian() {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "buildPanmian",
        builder: (controller) {
          Map<String, dynamic> map =
              controller.state.analyzeGetMatchAnalysiseDataItemEntity[
                      "matchHistoryBattleDTOMap"] ??
                  {};

          List<AnalyzeGetMatchAnalysiseDataMatchHistoryBattleEntity> entitys =
              [];
          map.forEach((key, value) {
            Map<String, dynamic> childMap = value as Map<String, dynamic>;

            entitys.add(
                AnalyzeGetMatchAnalysiseDataMatchHistoryBattleEntity.fromJson(
                    childMap));
          });

          return entitys.isEmpty
              ? NoData(
                  content: LocaleKeys.analysis_football_matches_no_data.tr,
                  top: 30.h,
                )
              : Column(
                  children: entitys
                      .map((e) =>
                          AnalyzeMatchHistoryBoardCard(e, e == entitys[0]))
                      .toList());
        });
  }
}
