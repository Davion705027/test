import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../../../services/api/analyze_v_s_info_entity.dart';

class AnalyzeMatchHistoryPoint extends StatelessWidget {
   AnalyzeMatchHistoryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 40.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,

            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                LocaleKeys.analysis_football_matches_rank.tr,
                style: TextStyle(fontSize: 11.sp, color: Get.theme.resultTextColor),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              LocaleKeys.ouzhou_search_team.tr,
              style: TextStyle(fontSize: 11.sp, color: Get.theme.resultTextColor),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              LocaleKeys.analysis_football_matches_game.tr,
              style: TextStyle(fontSize: 11.sp, color: Get.theme.resultTextColor),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              LocaleKeys.analysis_football_matches_victory.tr,
              style: TextStyle(fontSize: 11.sp, color: Get.theme.resultTextColor),
            ),
          ),


          Expanded(
            flex: 2,
            child: Text(
              LocaleKeys.analysis_football_matches_negative.tr,
              style: TextStyle(fontSize: 11.sp, color: Get.theme.resultTextColor),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              LocaleKeys.analysis_football_matches_flat.tr,
              style: TextStyle(fontSize: 11.sp, color: Get.theme.resultTextColor),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              LocaleKeys.analysis_football_matches_gain_loss.tr,
              style: TextStyle(fontSize: 11.sp, color: Get.theme.resultTextColor),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              LocaleKeys.analysis_football_matches_net_win.tr,
              style: TextStyle(fontSize: 11.sp, color: Get.theme.resultTextColor),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              LocaleKeys.virtual_sports_integral.tr,
              style: TextStyle(fontSize: 11.sp, color: Get.theme.resultTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
