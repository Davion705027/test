import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_basketball_header.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_basketball_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_header.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_item.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/analyze_divider.dart';
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

class AnalyzeFundamentalsCard1  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildLeagueTable();
  }

  buildLeagueTable() {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "buildLeagueTable",
        builder: (controller) {
          return Card(
              color: Get.theme.tabPanelBackgroundColor,
              child: Container(
                color: Get.theme.tabPanelBackgroundColor,
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    ItemHeaderWidget(
                      name: controller.state.analyzeList.isEmpty
                          ? LocaleKeys.analysis_football_matches_league_points.tr
                          : (controller.state.analyzeList[0].tournamentType == 0
                          ? LocaleKeys.analysis_football_matches_cup_points.tr
                          : LocaleKeys
                          .analysis_football_matches_league_points.tr),
                      showDivider: true,
                    ),


                    ( controller.state.analyzeList.isEmpty
                        ? NoData(
                      top: 0,
                      bottom: 10.w,
                      content:
                      LocaleKeys.analysis_football_matches_no_data.tr,
                    )
                        : Column(
                      children: [
                        controller.loading
                            ?TextNoData(
                          content: LocaleKeys.app_h5_cathectic_data_loading.tr,
                        )
                        //联赛积分列表
                            : buildPoint(controller.expand),
                        InkWell(
                          onTap: () {
                            controller.expand = !(controller.expand);

                            controller.requestVSInfo(flag: controller.expand ? "0" : "");
                            // ToastUtils.show("测试");
                          },
                          child: Container(
                            // width: 60.w,
                            // height: 35.w,
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.w),
                            child: controller.expand
                                ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 2.w),
                                Text(
                                  LocaleKeys.bet_pack_up.tr,
                                  style: TextStyle(
                                    color: Get.theme.secondTabPanelSelectedFontColor,

                                    // AppColor.mainColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 12.w,
                                  color: Get.theme.analsColorExpand,
                                )
                              ],
                            )
                                : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 2.w),
                                Text(
                                  LocaleKeys.bet_record_pack_down.tr,
                                  style: TextStyle(
                                    color: Get.theme.secondTabPanelSelectedFontColor,
                                    
                                    // AppColor.mainColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 12.w,
                                  color: Get.theme.analsColorExpand,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15.w,),
                      ],
                    ))
                  ],
                ),
              ));
        });
  }
  //联赛积分
  buildPoint(bool expands) {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "pointTitleList",
        builder: (controller) {
          return Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5.w, left: 10.w, right: 10.w),
                    child: controller.showBasketBall==true?AnalyzeMatchHistoryChildBasketBallHeader():AnalyzeMatchHistoryChildHeader(),
                  ),

                  ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.state.analyzeList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

                    //列表项构造器
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(10.w),
                        child: controller.showBasketBall==true?AnalyzeMatchHistoryBasketBallChildItem(index,controller.state.analyzeList.value[index]):AnalyzeMatchHistoryChildItem(
                            controller.state.analyzeList.value[index]),
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