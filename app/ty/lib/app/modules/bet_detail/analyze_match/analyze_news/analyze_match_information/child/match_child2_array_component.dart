import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_battle_array/widget/analyze_child_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_information/widget/match_analyze_child_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/widget/data/bottom_message_conpoment.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/models/res/match_intelligence_entity.dart';
import '../../../../../../widgets/no_data.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../../match_detail/widgets/container/analysis/item/analyze_divider.dart';
import '../../../../../match_detail/widgets/container/analysis/item/text_no_data.dart';
import '../analyze_match_information_logic.dart';

class MatchChild2ArrayComponent extends StatelessWidget {
  MatchIntelligenceData? matchIntelligenceEntity;

  MatchChild2ArrayComponent({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMatchInformationLogic>(
        id: "buildList1",
        builder: (controller) {
          return SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                buildBody(),
              ],
            ),
          );
          ;
        });
  }

  buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildList1(),
        //BottomMessageConpoment()
      ],
    );
  }

  buildList1() {
    return GetBuilder<AnalyzeMatchInformationLogic>(
        id: "buildList1",
        builder: (controller) {
          return controller.state.datalist.isEmpty
              ? TextNoData()
              : Container(
                  /// 最小高度单个item的高度
                  color: Get.theme.tabPanelBackgroundColor,
                  child: Column(
                    children: controller.state.lineupInfo
                        .map((e) => ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              scrollDirection: Axis.vertical,
                              itemCount: e.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              //列表项构造器
                              itemBuilder: (BuildContext context, int index) {
                                return MatchAnalyzeItem(
                                    controller.state.lineupInfo.indexOf(e),
                                    e[index]);
                              },
                              //分割器构造器
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return AnalyzeDivider();
                              },
                            ))
                        .toList(),
                  ),
                );
        });
  }
}
