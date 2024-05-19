import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_other_team_item_entity_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/api/analyze_v_s_info_entity.dart';
import '../../../../../../services/models/res/match_analysises_third_match_sidelined_dto_data_bean.dart';
import '../analyze_match_data_logic.dart';

class AnalyzeMatchHistoryChildItem4 extends StatelessWidget {
  MatchAnalysisesThirdMatchSidelinedDTODataBean analyzeVSInfoEntity;
  String headName;
  String teamName;

  AnalyzeMatchHistoryChildItem4(
      this.analyzeVSInfoEntity, this.headName, this.teamName,
      {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,

              child: Text(
                "${analyzeVSInfoEntity.playerName}",
                style: TextStyle(
                    fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                analyzeVSInfoEntity.positionName ?? "",
                style: TextStyle(
                    fontSize: 11.sp,
                    color: Get.theme.tabPanelSelectedColor,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${analyzeVSInfoEntity.reason}",
                style: TextStyle(
                    fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
