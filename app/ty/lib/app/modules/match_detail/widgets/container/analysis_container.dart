import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_history/analyze_match_history_component.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/analyze_tab_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/analyze_divider.dart';
import 'package:get/get.dart';

import '../../../bet_detail/analyze_match/analyze_news/amalyze_match_data/analyze_match_data_component.dart';
import '../../../bet_detail/analyze_match/analyze_news/analyze_battle_array/analyze_battle_array_component.dart';
import '../../../bet_detail/analyze_match/analyze_news/analyze_match_information/analyze_match_information_component.dart';
import '../../../bet_detail/analyze_match/analyze_news/analyze_match_odds/analyze_match_odds_component.dart';
import '../../../bet_detail/analyze_match/analyze_news/analyze_match_result/analyze_match_result_component.dart';
import '../../../bet_detail/analyze_match/analyze_news/analyze_news/analyze_news_component.dart';
import '../../../bet_detail/analyze_match/analyze_news/widget/data/analyze_top_tab.dart';
import '../../controllers/match_detail_controller.dart';
import '../tab/analysis_tab_widget.dart';

/// 底部赛事分析区域
class AnalysisContainer extends StatelessWidget {
  AnalysisContainer({super.key, this.tag});

  final String? tag;
  // @override
  // State<StatefulWidget> createState() {
  //   return AnalysisContainerState();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget E =  GetBuilder<AnalyzeTabController>(
        id: "tableList",
        init: AnalyzeTabController.to,
        initState: (_) {
          AnalyzeTabController.to.tag = tag;
        },
        builder: (controller) {
          return controller.result.isEmpty
              ? const SizedBox()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnalyzeDivider(),
              AnalyzeTopTabbar( (int page) {

                controller.jumpPage(page);
              },
              ),
              Expanded(
                child: TabBarView(
                  controller: controller!.tabController,
                  children: controller.getBodyWidget(),
                ),
              )
            ],
          );
        });
    Get.log("E = $E");
    return E;
  }
}
/*

class AnalysisContainerState extends State<AnalysisContainer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  bool get wantKeepAlive => true;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeTabController>(
        id: "tableList",
        builder: (controller) {
          return controller.result.isEmpty
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnalyzeTopTabbar(
                      (int page) {
                        _pageController.jumpToPage(page);

                      },

                    ),
                    Expanded(
                      child: PageView.builder(
                          itemCount: controller.getBodyWidget().length,
                          onPageChanged: (index) {
                            controller.tabController.animateTo(index);
                          },
                          controller: _pageController,
                          itemBuilder: (_, int index) =>
                              controller.getBodyWidget()[index]),
                    )
                  ],
                );
        });
  }

  void initData() {}
}
*/
