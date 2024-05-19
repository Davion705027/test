import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_board_header.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_board_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_item3.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_match_history_battle_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_match_history_battle_dto_map_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_other_team_item_entity_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../match_detail/widgets/container/analysis/item/item_headertwo_widget.dart';
import '../analyze_match_data_logic.dart';
import 'analyze_match_history_child_header2.dart';

class AnalyzeMatchHistoryTechnicalItem extends StatelessWidget {
  AnalyzeMatchHistoryBattleDTOMapEntity entity;
  AnalyzeMatchHistoryTechnicalItem(this.entity, {super.key});

  @override
  Widget build(BuildContext context) {
    String year="-";
    try{
      DateTime oldDate = DateTime.parse(entity.coachBirthdate??"");
      DateTime newDate= DateTime.now();
      int age= newDate.year-oldDate.year;
      year="$age";
    }catch(e){
      print("=======>${entity.coachBirthdate}");
    }

    return Container(
      height: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child:Container(
              alignment: Alignment.center,
              child:  Text(
                // "${(2024-(int.tryParse((entity.coachBirthdate??"2024").substring(0,4))??0))}",
                  "${year}",
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(

              alignment: Alignment.center,
              child: Text(
                "${entity.coachStyle}",
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${entity.score}",
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${(entity.coachGameCount=="null"||entity.coachGameCount==null)?LocaleKeys.common_no_data.tr:"${entity.coachGameCount}"}",
                style: TextStyle(fontSize: 11.sp, color:Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),

        ],
      ),
    );
  }

}
