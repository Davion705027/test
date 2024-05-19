import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_other_team_item_entity_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';

import '../analyze_match_data_logic.dart';

class AnalyzeMatchHistoryChildItem3 extends StatelessWidget {
  AnalyzeTeamVsOtherTeamItemEntityEntity analyzeVSInfoEntity;
  String headName;
  String teamName;
  AnalyzeMatchHistoryChildItem3(
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
              alignment: Alignment.center,
              child: Text(
                FormatDate.formatDate(
                    int.tryParse(analyzeVSInfoEntity?.beginTime ?? "0") ?? 0),
                style: TextStyle(
                    fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${analyzeVSInfoEntity.tournamentName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Get.theme.tabPanelSelectedColor,
                ),
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
                analyzeVSInfoEntity.homeTeamName ?? "",
                style: TextStyle(
                    fontSize: 11.sp,
                    color: Get.theme.tabPanelSelectedColor,
                    fontWeight: teamName == analyzeVSInfoEntity.homeTeamName
                        ? FontWeight.w700
                        : FontWeight.w300),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${analyzeVSInfoEntity.homeTeamScore}-${analyzeVSInfoEntity.awayTeamScore}",
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
                analyzeVSInfoEntity.awayTeamName ?? "",
                style: TextStyle(
                    fontSize: 11.sp,
                    color: Get.theme.tabPanelSelectedColor,
                    fontWeight: teamName == analyzeVSInfoEntity.homeTeamName
                        ? FontWeight.w300
                        : FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GetBuilder<AnalyzeMatchDataLogic>(
                id: "analyzeMatchHistoryChildItem3${teamName}",
                builder: (controller) {
                  String result = (controller.buildRecentHistoryType == 0
                      ? controller.getWinResultStr(analyzeVSInfoEntity.result)
                      : (controller.buildRecentHistoryType == 1
                          ? controller.getWinResultStr3(
                              analyzeVSInfoEntity.handicapResult)
                          : controller.getWinResultStr2(
                              analyzeVSInfoEntity.overunderResult)));

                  print(
                      "===============>result  ${result}  buildRecentHistoryType   ${controller.buildRecentHistoryType}   result  ${analyzeVSInfoEntity.handicapResult}   awayTeamName  ${analyzeVSInfoEntity.awayTeamName}");

                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      //  2平3输4赢,
                      //  'analysis_football_matches_victory': '胜',
                      //     'analysis_football_matches_win': '赢',
                      // 'analysis_football_matches_flat': '平',

                      result,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: controller.getWinResultTextColor(result),
                      ),
                    ),
                  );
                }),

            // Container(
            //   alignment: Alignment.center,
            //   child: Text(
            //     analyzeVSInfoEntity.result==4?LocaleKeys.analysis_football_matches_victory.tr:(analyzeVSInfoEntity.result==2?LocaleKeys.analysis_football_matches_flat.tr:LocaleKeys.analysis_football_matches_negative.tr),
            //     style: TextStyle(fontSize: 11.sp, color:  analyzeVSInfoEntity.result==4?AppColor.textF53F3F:(analyzeVSInfoEntity.result==2?AppColor.tabSelectColor:AppColor.text00B42A), ),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
