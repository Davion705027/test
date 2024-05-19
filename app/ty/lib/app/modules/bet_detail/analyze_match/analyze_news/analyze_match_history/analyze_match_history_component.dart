import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_history/child/match_history3_array_component.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/widget/BoxShadowContaine.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../widgets/no_data.dart';
import '../../../../match_detail/controllers/match_detail_controller.dart';
import '../widget/data/data_tab.dart';
import 'child/match_history_child2_array_component.dart';
import 'child/match_history_array_component.dart';
import 'analyze_match_history_logic.dart';
import 'widget/analyze_history_item.dart';

class AnalyzeMatchHistoryComponent extends StatelessWidget {
  AnalyzeMatchHistoryComponent({Key? key}) : super(key: key);

  final logic = Get.put(AnalyzeMatchHistoryLogic());
  final state = Get.find<AnalyzeMatchHistoryLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMatchHistoryLogic>(
        id: 'playbackVideoUrlList',
        builder: (cotroller) {
          return Container(
            // color: Color(0xFFF2F3F4),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.w),
            child: state.analyzeList.isEmpty
                ? Column(children: [
                    ItemHeaderWidget(name: LocaleKeys.app_h5_detail_highlights.tr,bgColor: Get.theme.oddsButtonBackgroundColor,showDivider: true,),
                    buildTab(),
                    NoData(
                      content: LocaleKeys.analysis_football_matches_no_data.tr,
                      top: 30.h,
                    )
                  ])
                : Column(
                    children: [
                      BoxShadowContainer(
                        color:Get.theme.oddsButtonBackgroundColor,
                        padding: EdgeInsets.symmetric(vertical: 20.w),
                        width: 380.w,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ItemHeaderWidget(name: LocaleKeys.app_h5_detail_highlights.tr,bgColor: Get.theme.oddsButtonBackgroundColor,showDivider: true,),
                            buildTab(),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 142.w,
                              margin: EdgeInsets.only(top: 8.w),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  controller: ScrollController(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: cotroller.state.analyzeList.value
                                        .map((element) =>
                                            AnalyzeHistoryItem(element))
                                        .toList(),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                    ],
                  ),
          );
        });
  }
  buildTab() {
    List<String> _tabs = [LocaleKeys.highlights_type_all.tr,LocaleKeys.match_result_goal.tr,LocaleKeys.highlights_type_corner.tr,LocaleKeys.highlights_type_penalty.tr ];
    return AnalyzeTabbar(_tabs, (page) {}, logic.tabController);
  }
}
