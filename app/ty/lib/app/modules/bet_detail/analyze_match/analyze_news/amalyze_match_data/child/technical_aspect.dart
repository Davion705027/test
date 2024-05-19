import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/analyze_match_data_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_technical_card.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/widget/BoxShadowContaine.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/text_no_data.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_match_history_battle_dto_map_entity.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../widgets/no_data.dart';
import '../../../../../login/login_head_import.dart';

import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';

import '../../../../../match_detail/widgets/container/analysis/item/analyze_divider.dart';

/**
 * @author[xiongwei]
 * @version[创建日期，2024/2/29 14:06]
 * @function[功能简介 ]
 **/
class technical_aspect extends StatelessWidget {

  technical_aspect({super.key}){

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "technical_aspect",
        builder: (controller) {
      List<List<AnalyzeMatchHistoryBattleDTOMapEntity>> maps = [];
      Map<String, dynamic> map1 = controller.state
              .analyzeGetMatchAnalysiseDataItemEntity["homeAwayGoalAndCoachMap"]??{};
      Map<String, dynamic> map =map1["sThirdMatchCoachDTOMap"]??{};
      map.forEach((key, value) {
        List<AnalyzeMatchHistoryBattleDTOMapEntity> list= (value as List).map((e) => AnalyzeMatchHistoryBattleDTOMapEntity.fromJson(e)).toList()??[];
        maps.add(list);
      });
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
          controller: ScrollController(),
          child: Column(children: [
        BoxShadowContainer(
            padding:EdgeInsets.zero,
            color: Get.theme.tabPanelBackgroundColor,
            margin: EdgeInsets.only(top: 10.w,left: 6.w,right: 6.w),
            child: Container(
              color: Get.theme.tabPanelBackgroundColor,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  SizedBox(height: 8.w,),
                  ItemHeaderWidget(
                    name: LocaleKeys.analysis_football_matches_Coach_data.tr,
                    showDivider: true,
                  ),
                  maps.isEmpty?TextNoData():Column(
                    children: maps
                        .map((e) => AnalyzeMatchHistoryTechnicalCard(e,maps.indexOf(e)==0))
                        .toList(),
                  )
                ],
              ),
            ))
      ]));
    });
  }
}
