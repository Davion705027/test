import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../../services/api/analyze_v_s_info_entity.dart';
import '../analyze_match_data_logic.dart';
import 'analyze_switch_button.dart';

class AnalyzeMatchHistoryChildHeader4 extends StatefulWidget {
  ValueChanged<int>? onChanged;

  // 1 历史交战  2  近期战绩   3
  String? type;

  AnalyzeMatchHistoryChildHeader4({this.type,this.onChanged, super.key});

  @override
  State<StatefulWidget> createState() {
    return AnalyzeMatchHistoryHead4State();
  }
}

class AnalyzeMatchHistoryHead4State
    extends State<AnalyzeMatchHistoryChildHeader4> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "buildRecentHistory",
        builder: (controller) {
          return Container(
            height: 40.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.analysis_football_matches_player.tr,
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
                      LocaleKeys.analysis_football_matches_position.tr,
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
                      LocaleKeys.analysis_football_matches_reason.tr,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Get.theme.tabPanelSelectedColor),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                    },
                    child: SizedBox(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
