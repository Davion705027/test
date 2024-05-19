import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/analyze_match_data_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_battle_array/widget/analyze_child_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_information/widget/match_analyze_child_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/widget/data/bottom_message_conpoment.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

import '../../../../../../services/models/res/analyze_get_match_analysise_third_odds_entity.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../../match_detail/widgets/container/analysis/item/text_no_data.dart';
import '../../../widget/BoxShadowContaine.dart';
import '../analyze_match_odds_logic.dart';
import '../widget/odds_analyze_child_item.dart';

class OddsChild3ArrayComponent extends StatelessWidget {
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
            padding: EdgeInsets.symmetric(vertical: 0.w),
          margin: EdgeInsets.symmetric(horizontal: 6.w,vertical: 8.w),

            color: Get.theme.tabPanelBackgroundColor,

            child:buildList1()
        ),
        SizedBox(
          height: 20,
        ),
        //BottomMessageConpoment()
      ],
    );
  }

  buildList1() {
    return GetBuilder<AnalyzeMatchOddsLogic>(
        id: "analyzeMatchOddsLogic3",
        builder: (controller) {

      List<dynamic> maps = controller.state
          .analyzeGetMatchAnalysiseDataItemEntity["sThirdMatchHistoryOddsDTOList"]??[];
      List<AnalyzeGetMatchAnalysiseThirdOddsEntity> entitys = maps.map((e) =>AnalyzeGetMatchAnalysiseThirdOddsEntity.fromJson(e) ).toList();
      return Column(
        children: [
          SizedBox(height: 8.w,),
          ItemHeaderWidget(name: LocaleKeys.analysis_football_matches_size.tr),
          AnalyzeDivider(),
          buildListHead(),
          AnalyzeDivider(),
          (entitys.isEmpty)
              ? TextNoData()
              :  ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            scrollDirection: Axis.vertical,
            itemCount: entitys.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            //列表项构造器
            itemBuilder: (BuildContext context, int index) {
              return   OddsAnalyzeItem(entitys[index]);
            },
            //分割器构造器
            separatorBuilder: (BuildContext context, int index) {
              return AnalyzeDivider(

              );
            },
          )
        ],
      );
    });
  }

  buildListHead() {
    return  Container(
      height: 24.w,
      child: Row(
        children: [
          Expanded(
              flex: 5,
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

                  LocaleKeys.analysis_football_matches_big.tr,
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
                  LocaleKeys.analysis_football_matches_handicap.tr,
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
                  LocaleKeys.analysis_football_matches_small.tr,
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
