import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_battle_array/analyze_battle_tab.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_battle_array/child/analyze_child2_array_component.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_battle_array/child/analyze_child_array_component.dart';
import 'package:get/get.dart';

import 'analyze_battle_array_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/widget/data/data_tab.dart';
import 'package:get/get.dart';

import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';
import 'analyze_battle_array_logic.dart';
import 'analyze_battle_arrayinfo_logic.dart';
import 'child/analyze_child2_array_component.dart';
import 'child/analyze_child_arrayinfo_component.dart';

class AnalyzeBattleArrayInfoComponent extends StatelessWidget {
  AnalyzeBattleArrayInfoComponent({Key? key}) : super(key: key);
  final logic = Get.put(AnalyzeBattleArrayInfoLogic());
  final state = Get.find<AnalyzeBattleArrayInfoLogic>().state;

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
                AnalyzeChildArrayInfoComponent(),
                AnalyzeChild2ArrayInfoComponent(),
              ],
            ),
          ),

        ],
      ),
    );
  }

  buildTab() {
    List<String> _tabs = logic.state.teamsNames.value;


    return AnalyzeTabbar(_tabs,(page){},logic.tabController,widgetWidth: 200.w,);

  }

}

