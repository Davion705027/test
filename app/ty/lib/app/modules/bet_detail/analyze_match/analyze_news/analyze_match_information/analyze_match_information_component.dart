import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_information/child/match_child2_array_component.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_information/child/match_child_array_component.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/widget/data/data_tab_new.dart';
import 'package:get/get.dart';

import '../analyze_battle_array/analyze_battle_array_logic.dart';
import 'analyze_match_information_logic.dart';

class AnalyzeMatchInformationComponent extends StatelessWidget {
  AnalyzeMatchInformationComponent({Key? key}) : super(key: key);

  final logic = Get.put(AnalyzeMatchInformationLogic());
  final state = Get.find<AnalyzeMatchInformationLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildTab(),
          Expanded(
            child: TabBarView(
              controller: logic.tabController,
              children: [
                MatchChildArrayComponent(),
                MatchChildArrayComponent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildTab() {
    AnalyzeBattleArrayLogic analyzeBattleArrayLogic =
        Get.find<AnalyzeBattleArrayLogic>();

    List<String> _tabs = analyzeBattleArrayLogic.state.teamsNames.value;
    return AnalyzeTabbarNew(
      _tabs,
      (page) {},
      logic.tabController,
      widgetWidth: 290.w,
    );
  }
}
