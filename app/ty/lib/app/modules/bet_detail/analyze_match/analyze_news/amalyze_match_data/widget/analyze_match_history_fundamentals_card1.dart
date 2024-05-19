import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../../../services/api/analyze_v_s_info_entity.dart';

import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/analyze_match_data_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_board_card.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/widget/BoxShadowContaine.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/models/res/analyze_get_match_analysise_data_entity.dart';
import '../../../../../../services/models/res/analyze_get_match_analysise_data_match_history_battle_entity.dart';
import '../../../../../../widgets/no_data.dart';
import '../../../../../login/login_head_import.dart';

import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';

class AnalyzeMatchHistoryFundamentalsCard1 extends StatelessWidget {

  buildPanmian() {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "buildPanmian",
        builder: (controller) {
          Map<String, dynamic> map =
              controller.state.analyzeGetMatchAnalysiseDataItemEntity[
              "matchHistoryBattleDTOMap"] ??
                  {};

          List<AnalyzeGetMatchAnalysiseDataMatchHistoryBattleEntity> entitys =
          [];
          map.forEach((key, value) {
            Map<String, dynamic> childMap = value as Map<String, dynamic>;

            entitys.add(
                AnalyzeGetMatchAnalysiseDataMatchHistoryBattleEntity.fromJson(
                    childMap));
          });

          return entitys.isEmpty
              ? NoData(
            content: LocaleKeys.analysis_football_matches_no_data.tr,
            top: 30.h,
          )
              : Column(
              children: entitys
                  .map((e) =>
                  AnalyzeMatchHistoryBoardCard(e, e == entitys[0]))
                  .toList());
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}