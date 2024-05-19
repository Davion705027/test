import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_board_header.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_board_item.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_match_history_battle_entity.dart';

import '../../../../../match_detail/controllers/match_detail_controller.dart';
import '../../../../../match_detail/widgets/container/analysis/item/analyze_divider.dart';
import '../analyze_match_data_logic.dart';

class AnalyzeMatchHistoryBoardCard extends StatelessWidget {
  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleEntity entity;
  bool isFirst = true;

  AnalyzeMatchHistoryBoardCard(this.entity, this.isFirst, {super.key});

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
                padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                      child: (controller.teamsNames.isEmpty ||
                              controller.teamsNames.length < 2)
                          ? SizedBox()
                          : Text(
                              controller.teamsNames[isFirst ? 0 : 1],
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
              if (entity.matchHistoryBattleDetailDTOList?.isNotEmpty == true)
                Column(
                  children: [
                    AnalyzeMatchHistoryBoardHeader(),
                    buildRecentHistory(controller),
                    Container(
                      height: 40.w,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(
                              right: BorderSide(
                                  color: Get.theme.betPanelUnderlineColor,
                                  width: 1),
                            )),
                            child: Text(
                                LocaleKeys.analysis_football_matches_field.tr
                                    .replaceAll('{0}',
                                        '${entity.handicapResultList?.length ?? 0}'),
                                // "${LocaleKeys.analysis_football_matches_near.tr}${entity.handicapResultList?.length ?? 0}${LocaleKeys.analysis_football_matches_near.tr}",
                                style: TextStyle(
                                    color: Get.theme.tabPanelSelectedColor,
                                    fontSize: 10.sp,
                                    height: 1,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  controller: ScrollController(),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children:
                                          (entity.handicapResultList ?? [])
                                              .map((e) => breakColor(e, true))
                                              .toList()),
                                ),
                              ),
                              Container(
                                child: SingleChildScrollView(
                                  controller: ScrollController(),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children:
                                          (entity.overunderResultList ?? [])
                                              .map((e) => breakColor(e, false))
                                              .toList()),
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ],
                )
            ],
          );
        });
  }

  //近期战绩
  buildRecentHistory(AnalyzeMatchDataLogic controller) {
    return Container(
        margin: EdgeInsets.only(top: 5.w),
        child: Column(
          children: [
            AnalyzeDivider(),
            ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              scrollDirection: Axis.vertical,

              itemCount: entity.matchHistoryBattleDetailDTOList?.length ?? 0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              //列表项构造器
              itemBuilder: (BuildContext context, int index) {
                return AnalyzeMatchHistoryBoardItem(
                    entity.matchHistoryBattleDetailDTOList?[index] ??
                        MatchHistoryBattleDetailDTOList());
              },
              //分割器构造器
              separatorBuilder: (BuildContext context, int index) {
                return AnalyzeDivider();
              },
            ),
            AnalyzeDivider(),
          ],
        ));
    ;
  }

  Container breakColor(num e, bool type) {
    String data = "";

    if (type) {
      data = switchOverunderLabelCode(e);
    } else {
      data = switchResultLabelCode(e);
    }
    Color color = Color(0xFFF53F3F);
    Text widget = Text(LocaleKeys.analysis_football_matches_level.tr);
    if (e == 2) {
      color = Color(0xFF71C0F7);
    } else if (e == 3) {
      color = Color(0xFF00B42A);
    } else if (e == 4) {
      color = Color(0xFFF53F3F);
    } else {
      color = Color(0xFF303442);
    }
    widget = Text(data,
        style: TextStyle(
            color: color,
            fontSize: 10.sp,
            height: 1,
            fontWeight: FontWeight.w500));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: widget,
    );
  }

  String switchResultLabelCode(num value) {
    switch (value) {
      case 2:
        return LocaleKeys.analysis_football_matches_level.tr;
      case 3:
        return LocaleKeys.analysis_football_matches_small.tr;
      case 4:
        return LocaleKeys.analysis_football_matches_big.tr;
      default:
        return LocaleKeys.ouzhou_no_data_no_data.tr;
    }
  }

  String switchOverunderLabelCode(num value) {
    switch (value) {
      case 2:
        return LocaleKeys.analysis_football_matches_level.tr;
      case 3:
        return LocaleKeys.analysis_football_matches_lose.tr;
      case 4:
        return LocaleKeys.analysis_football_matches_win.tr;
      default:
        return "";
    }
  }
}
