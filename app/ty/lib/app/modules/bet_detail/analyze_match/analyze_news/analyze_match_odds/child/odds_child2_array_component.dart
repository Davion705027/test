import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/widget/BoxShadowContaine.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../../../services/models/res/analyze_get_match_analysise_third_odds_entity.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../../match_detail/widgets/container/analysis/item/text_no_data.dart';
import '../analyze_match_odds_logic.dart';
import '../widget/odds_analyze_child2_item.dart';

class OddsChild2ArrayComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.w),
            padding: EdgeInsets.symmetric(vertical: 0.w),
            color: Get.theme.tabPanelBackgroundColor,
            child: buildList1()),
      ],
    );
  }

  buildList1() {
    return GetBuilder<AnalyzeMatchOddsLogic>(
        id: "analyzeMatchOddsLogic2",
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
              SizedBox(height: 8.w),
              ItemHeaderWidget(name: LocaleKeys.footer_menu_win_alone.tr),
              AnalyzeDivider(),
              buildListHead(),
              AnalyzeDivider(),
              (entitys.isEmpty)
                  ? TextNoData()
                  : ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: entitys.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 30.w),
                      physics: const NeverScrollableScrollPhysics(),
                      //列表项构造器
                      itemBuilder: (BuildContext context, int index) {
                        print(
                            "==========================>toJson  ${jsonEncode(entitys[index].toJson())}");
                        return OddsAnalyzeChild2Item(entitys[index]);
                      },
                      //分割器构造器
                      separatorBuilder: (BuildContext context, int index) {
                        return AnalyzeDivider();
                      },
                    )
            ],
          );
        });
  }

  buildListHead() {
    return Container(
      height: 24.w,
      child: Row(
        children: [
          Expanded(
              flex: 6,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_company.tr,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949AB6)),
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_home_win1.tr,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949AB6)),
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_flat.tr,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949AB6)),
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_away_win.tr,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949AB6)),
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_Main_win_rate.tr,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949AB6)),
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_Customer_win_rate.tr,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949AB6)),
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_Return_rate.tr,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949AB6)),
                ),
              ))
        ],
      ),
    );
  }
}
