import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_item_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_match_history_battle_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/api/analyze_v_s_info_entity.dart';

class AnalyzeMatchHistoryBoardItem extends StatelessWidget {
  MatchHistoryBattleDetailDTOList entity;

  AnalyzeMatchHistoryBoardItem(this.entity, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      height: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
                border: Border(
              right:
                  BorderSide(color: Get.theme.betPanelUnderlineColor, width: 1),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${((entity.postionFlag == 1) ? LocaleKeys.analysis_football_matches_total_all.tr : ((entity.postionFlag == 2) ? LocaleKeys.analysis_football_matches_main.tr : LocaleKeys.analysis_football_matches_customer.tr))}",
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Get.theme.tabPanelSelectedColor),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${(entity.handicapResultWin ?? 0) + (entity.handicapResultEqual ?? 0) + (entity.handicapResultLose ?? 0)}",
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Get.theme.tabPanelSelectedColor),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${entity.handicapResultWin ?? 0}",
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Get.theme.tabPanelSelectedColor),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${entity.handicapResultEqual ?? 0}",
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Get.theme.tabPanelSelectedColor),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${entity.handicapResultLose ?? 0}",
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Get.theme.tabPanelSelectedColor),
                  ),
                ),
              ),
              Container(
                width: 55.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          color: Get.theme.betPanelUnderlineColor, width: 1),
                    )),
                child: Text(
                  "${((entity.handicapResultWinRate?.toDouble() ?? 0) * 100).toStringAsFixed(2)}%",
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: Get.theme.tabPanelSelectedColor),
                ),
              )
            ],
          )),
          Expanded(
              flex: 1,
              child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${entity.overunderResultWin}",
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Get.theme.tabPanelSelectedColor),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${((entity.overunderResultWinRate?.toDouble() ?? 0) * 100).toStringAsFixed(2)}%",
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Get.theme.tabPanelSelectedColor),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${entity.overunderResultLose}",
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Get.theme.tabPanelSelectedColor),
                  ),
                ),
              ),
              Expanded(

                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${((entity.overunderResultLoseRate?.toDouble() ?? 0) * 100).toStringAsFixed(2)}%",
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Get.theme.tabPanelSelectedColor),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
