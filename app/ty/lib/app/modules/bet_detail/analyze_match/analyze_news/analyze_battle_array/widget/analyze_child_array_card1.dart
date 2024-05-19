import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_battle_array/widget/analyze_child_item.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/text_no_data.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/models/res/analyze_array_person_entity.dart';
import '../../../../../login/login_head_import.dart';
import '../analyze_battle_array_logic.dart';
import '../widget/analyze_battle_array_head.dart';

class AnalyzeChildArrayCard1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeBattleArrayLogic>(
        id: "analyzeChildArrayComponent",
        builder: (controller) {
          return  Card(
            color: Get.theme.tabPanelBackgroundColor,
            child: Container(
              color: Get.theme.tabPanelBackgroundColor,
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ItemHeaderWidget(
                    name:
                    '${LocaleKeys.analysis_football_matches_starting_lineup.tr}${controller.showBasketBall == true ? "" : controller.state.analyzeArrayPersonEntity.value.homeFormation ?? ""}',
                  ),
                  AnalyzeDivider(),
                  buildBody(),
                ],
              ),
            ),
          );
        });
  }

  buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildHead(),

        AnalyzeDivider(),
        buildList(),
        SizedBox(
          height: 14.w,
        ),

        ItemHeaderWidget(
          name: LocaleKeys.analysis_football_matches_bench_lineup.tr,
        ),
        AnalyzeDivider(),
        buildHead(),
        AnalyzeDivider(),
        buildList1()
        //BottomMessageConpoment()
      ],
    );
  }

  buildHead() {
    return Container(
      height: 24.w,
      child: Row(
        children: [
          SizedBox(
            width: 60.w,
          ),
          Container(
            width: 60.w,
            alignment: Alignment.center,
            child: Text(
              LocaleKeys.analysis_football_matches_position.tr,
              style: TextStyle(color: Color(0xFF949AB6), fontSize: 10.sp),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.analysis_football_matches_name.tr,
                style: TextStyle(color: Color(0xFF949AB6), fontSize: 10.sp),
              ),
            ),
          ),
          Container(
            width: 60.w,
            alignment: Alignment.center,
            child: Text(
              LocaleKeys.analysis_football_matches_number.tr,
              style: TextStyle(color: Color(0xFF949AB6), fontSize: 10.sp),
            ),
          ),
        ],
      ),
    );
  }

  buildList1() {
    return GetBuilder<AnalyzeBattleArrayLogic>(
        id: "buildList",
        builder: (controller) {
          return Column(
            children: [
              AnalyzeDivider(),
              controller.isBodyDownEmpty()? TextNoData()
                  : Container(
                      /// 最小高度单个item的高度
                      constraints:
                          BoxConstraints( minHeight: 100.h),
                      color: Get.theme.tabPanelBackgroundColor,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.getBodyDownData()?.length ??
                            0,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),

                        //列表项构造器
                        itemBuilder: (BuildContext context, int index) {
                          return AnalyzeChildItem(controller.getBodyDownData()?[index] ??
                              Up());
                        },
                        //分割器构造器
                        separatorBuilder: (BuildContext context, int index) {
                          return AnalyzeDivider();
                        },
                      ),
                    )
            ],
          );
          ;
        });
  }

  buildList() {
    return GetBuilder<AnalyzeBattleArrayLogic>(
        id: "buildList",
        builder: (controller) {
          return controller.isBodyUpEmpty()
              ? TextNoData()
              : Container(
                  /// 最小高度单个item的高度
                  constraints:
                      BoxConstraints( minHeight: 100.h),
                  color: Get.theme.tabPanelBackgroundColor,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.getBodyUpData()?.length ??
                        0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

                    //列表项构造器
                    itemBuilder: (BuildContext context, int index) {
                      return AnalyzeChildItem(controller.getBodyUpData()?[index] ??
                          Up());
                    },
                    //分割器构造器
                    separatorBuilder: (BuildContext context, int index) {
                      return AnalyzeDivider();
                    },
                  ),
                );
        });
  }
}
