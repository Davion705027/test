import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_odds/widget/odds_analyze_child_head.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/widget/BoxShadowContaine.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/models/res/analyze_get_match_analysise_third_odds_entity.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../../match_detail/widgets/container/analysis/item/analyze_divider.dart';
import '../../../../../match_detail/widgets/container/analysis/item/text_no_data.dart';
import '../analyze_match_odds_logic.dart';
import '../widget/odds_analyze_child_item.dart';

class OddsChildArrayComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildBody();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: ScrollController(),
      child: Column(
        children: [
          buildBody(),
        ],
      ),
    );
  }

  buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BoxShadowContainer(
          color: Get.theme.tabPanelBackgroundColor,
          margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 8.w),
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: buildList1(),
        ).expanded(),
        //BottomMessageConpoment()
      ],
    );
  }

  buildList1() {
    return GetBuilder<AnalyzeMatchOddsLogic>(
      id: "analyzeMatchOddsLogic1",
      builder: (controller) {
        List<dynamic> maps =
            controller.state.analyzeGetMatchAnalysiseDataItemEntity[
                    "sThirdMatchHistoryOddsDTOList"] ??
                [];
        List<AnalyzeGetMatchAnalysiseThirdOddsEntity> entitys = maps
            .map((e) => AnalyzeGetMatchAnalysiseThirdOddsEntity.fromJson(e))
            .toList();

        return Column(
          children: [
            SizedBox(
              height: 6.w,
            ),
            ItemHeaderWidget(name: LocaleKeys.footer_menu_rangqiu.tr),
            AnalyzeDivider(),
            OddsAnalyzeChildHead(),
            AnalyzeDivider(),
            (entitys.isEmpty)
                ? TextNoData()
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    scrollDirection: Axis.vertical,
                    itemCount: entitys.length,
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    //列表项构造器
                    itemBuilder: (BuildContext context, int index) {
                      return OddsAnalyzeItem(entitys[index]);
                    },
                    //分割器构造器
                    separatorBuilder: (BuildContext context, int index) {
                      return AnalyzeDivider();
                    },
                  ).expanded(),
          ],
        );
      },
    );
  }


}
