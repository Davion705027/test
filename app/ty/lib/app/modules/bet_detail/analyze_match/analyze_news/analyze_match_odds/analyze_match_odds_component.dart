import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_odds/child/odds_child3_array_component.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_odds/widget/odds_match_tab.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/widget/data/data_tab.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:get/get.dart';

import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';
import 'child/odds_child2_array_component.dart';
import 'child/odds_child_array_component.dart';
import 'analyze_match_odds_logic.dart';

class AnalyzeMatchOddsComponent extends StatelessWidget {
  AnalyzeMatchOddsComponent({Key? key}) : super(key: key);

  final logic = Get.put(AnalyzeMatchOddsLogic());
  final state = Get.find<AnalyzeMatchOddsLogic>().state;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
          child: buildTab(),),
          Expanded(
            child: TabBarView(
              controller: logic.tabController,
              children: [
                OddsChildArrayComponent(),
                OddsChild2ArrayComponent(),
                OddsChild3ArrayComponent(),

              ],
            ),
          ),

        ],
      ),
    );

  }

  buildTab() {
    List<String> _tabs = [LocaleKeys.footer_menu_rangqiu.tr,LocaleKeys.footer_menu_win_alone.tr,LocaleKeys.analysis_football_matches_size.tr];
    return AnalyzeTabbar(_tabs,(page){},logic.tabController,widgetWidth:370.w);
  }

}


