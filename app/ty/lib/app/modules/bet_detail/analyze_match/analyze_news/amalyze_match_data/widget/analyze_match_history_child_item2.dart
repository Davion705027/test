import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/api/analyze_v_s_info_entity.dart';
import '../analyze_match_data_logic.dart';

class AnalyzeMatchHistoryChildItem2 extends StatelessWidget {
  AnalyzeTeamVsHistoryEntity analyzeVSInfoEntity;
   AnalyzeMatchHistoryChildItem2(this.analyzeVSInfoEntity,{super.key});

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
              alignment: Alignment.center,
              child: Text(
                FormatDate.formatDate(int.tryParse(analyzeVSInfoEntity?.beginTime??"0")??0),
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${analyzeVSInfoEntity.tournamentName}",
                overflow: TextOverflow.ellipsis,
                maxLines:1,
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines:1,
                analyzeVSInfoEntity.boldTagName??"",

                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${analyzeVSInfoEntity.homeTeamScore}-${analyzeVSInfoEntity.awayTeamScore}",
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines:1,
                analyzeVSInfoEntity.awayTeamName??"",
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GetBuilder<AnalyzeMatchDataLogic>(
                id: "analyzeMatchHistoryChildItem2",
                builder:(controller){
                  print("==============>buildHistoryType   ${controller.buildHistoryType}   analyzeVSInfoEntity.result  ${analyzeVSInfoEntity.result }   analyzeVSInfoEntity.handicapResult  ${analyzeVSInfoEntity.handicapResult}   analyzeVSInfoEntity.overunderResult  ${analyzeVSInfoEntity.overunderResult}");
                String result= (controller.buildHistoryType==0? controller.getWinResultStr(analyzeVSInfoEntity.result):(controller.buildHistoryType==1? controller.getWinResultStr1(analyzeVSInfoEntity.handicapResult): controller.getWinResultStr2(analyzeVSInfoEntity.overunderResult)));

                

                  return  Container(
                    alignment: Alignment.center,
                    child: Text(
                      //  2平3输4赢,
                      //  'analysis_football_matches_victory': '胜',
                      //     'analysis_football_matches_win': '赢',
                      // 'analysis_football_matches_flat': '平',
                        result,
                       style: TextStyle(fontSize: 11.sp, color: controller.getWinResultTextColor(result)),

                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }



}
