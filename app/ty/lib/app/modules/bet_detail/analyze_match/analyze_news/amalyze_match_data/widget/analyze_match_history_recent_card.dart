import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_item3.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/text_no_data.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_other_team_item_entity_entity.dart';

import '../../../../../match_detail/widgets/container/analysis/item/item_headertwo_widget.dart';
import '../analyze_match_data_logic.dart';
import 'analyze_match_history_child_header2.dart';

class AnalyzeMatchHistoryRecentCard extends StatelessWidget {
  List<AnalyzeTeamVsOtherTeamItemEntityEntity> home;
  Map<String, int> homeVSHistoryMap = {};
  String url;
  String teamName;

  AnalyzeMatchHistoryRecentCard(
      this.home, this.teamName, this.url, this.homeVSHistoryMap,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "buildRecentHistory",
        builder: (controller) {

          var url=controller.getPlayImage( this.teamName);
          print("=========>url${url}  ");
          return Column(
            children: [
              Container(
                height: 32.w,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.w,
                      alignment: Alignment.center,
                      child: ImageView(
                              url ?? "",
                              width: 20.w,
                              height: 20.w,
                              cdn: true,
                              // cdn: true,
                            ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Expanded(
                      child: Text(
                        teamName,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Get.theme.tabPanelSelectedColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "${homeVSHistoryMap["success"]}${LocaleKeys.analysis_football_matches_victory.tr}  ${homeVSHistoryMap["flat"]}${LocaleKeys.analysis_football_matches_flat.tr}   ${homeVSHistoryMap["lose"]}${LocaleKeys.analysis_football_matches_negative.tr}    ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Get.theme.tabPanelSelectedColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              AnalyzeDivider(),
              buildRecentHistory(controller)
            ],
          );
        });
  }

  //近期战绩
  buildRecentHistory(AnalyzeMatchDataLogic controller) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.w, left: 5.w, right: 5.w),
              child: AnalyzeMatchHistoryChildHeader2(
                onChanged: (int type) {
                  controller.switchBuildRecentHistoryType(type, teamName);
                },
              ),
            ),
            AnalyzeDivider(),

            home.isEmpty?TextNoData():ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              scrollDirection: Axis.vertical,
              itemCount: home.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              //列表项构造器

              itemBuilder: (BuildContext context, int index) {
                return AnalyzeMatchHistoryChildItem3(
                    home[index], home[0].tournamentName ?? "", teamName);
                ;
              },
              //分割器构造器
              separatorBuilder: (BuildContext context, int index) {
                return AnalyzeDivider();
              },

            )
          ],
        ));
    ;
  }
}
