import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../../services/api/analyze_v_s_info_entity.dart';

class AnalyzeMatchHistoryChildHeader3 extends StatelessWidget {
   AnalyzeMatchHistoryChildHeader3({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child:Container(
              alignment: Alignment.center,
              child:  Text(
                LocaleKeys.analysis_football_matches_date.tr,
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.analysis_football_matches_league.tr,
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.analysis_football_matches_ball_match.tr,
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.analysis_football_matches_score.tr,
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.analysis_football_matches_team_name.tr,

                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Text(
               LocaleKeys.menu_itme_name_results.tr,
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
