import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_item3.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_other_team_item_entity_entity.dart';

import '../../../../../../services/models/res/match_analysises_third_match_sidelined_dto_data_bean.dart';
import '../../../../../match_detail/controllers/match_detail_controller.dart';
import '../../../../../match_detail/widgets/container/analysis/item/item_headertwo_widget.dart';
import '../analyze_match_data_logic.dart';
import 'analyze_match_history_child_header2.dart';
import 'analyze_match_history_child_header4.dart';
import 'analyze_match_history_child_item4.dart';

class AnalyzeMatchStopListCard extends StatelessWidget {
  List<MatchAnalysisesThirdMatchSidelinedDTODataBean> home;
  String url;
  String teamName;
  bool isFirst = true;
  AnalyzeMatchStopListCard(
      this.isFirst,
      this.home, this.teamName, this.url,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "buildRecentHistory",
        builder: (controller) {
          MatchDetailController detailController = Get.find<MatchDetailController>(tag: controller.tag);
          String url = (isFirst == true)
              ? detailController.detailState?.match?.mhlu[0]
              : detailController.detailState?.match?.malu[0];
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
                      child: detailController.detailState.isDJDetail
                          ? ImageView(
                              url,
                              width: 20.w,
                              height: 20.w,
                              dj: true,
                            )
                          : ImageView(
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

                  ],
                ),
              ),
              AnalyzeDivider(),
              buildRecentHistory(controller)
            ],
          );
        });
  }

  //伤停名单
  buildRecentHistory(AnalyzeMatchDataLogic controller) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.w, left: 5.w, right: 5.w),
              child: AnalyzeMatchHistoryChildHeader4(
              ),
            ),
            AnalyzeDivider(),
            ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              scrollDirection: Axis.vertical,
              itemCount: home.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              //列表项构造器

              itemBuilder: (BuildContext context, int index) {
                return AnalyzeMatchHistoryChildItem4(
                    home[index], "", teamName);
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
