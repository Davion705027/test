import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/analyze_match_data_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/widget/data/data_tab.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:get/get.dart';


import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';
import '../analyze_match_odds/child/odds_child2_array_component.dart';
import '../analyze_match_odds/child/odds_child3_array_component.dart';
import 'child/disk_surface.dart';
import 'child/fundamentals_view.dart';
import 'child/technical_aspect.dart';

class AnalyzeMatchDataComponent extends StatelessWidget {
  AnalyzeMatchDataComponent({Key? key}) : super(key: key);

  final logic = Get.put(AnalyzeMatchDataLogic());
  final state = Get.find<AnalyzeMatchDataLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id:"analyzeMatchDataComponent",
        builder: (controller){
      return controller.showBasketBall?  fundamentals_view(): Container(
        child: Column(
          children: [
            buildTab(),
            Expanded(
              child: TabBarView(
                controller: logic.tabController,
                children: [
                  fundamentals_view(),
                  disk_surface(),
                  technical_aspect(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  buildTab() {
    return AnalyzeTabbar([LocaleKeys.analysis_football_matches_Fundamentals.tr, LocaleKeys.analysis_football_matches_Disk.tr, LocaleKeys.analysis_football_matches_Technical_side.tr],(page){},logic.tabController,widgetWidth:410.w);
  }

}
