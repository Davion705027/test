import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_news/match_new_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/widget/data/bottom_message_conpoment.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/widget/data/nodata_view.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/widget/BoxShadowContaine.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/text_no_data.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../../../../services/models/res/analyze_news_entity.dart';
import '../../../../../utils/oss_util.dart';
import '../../../../../widgets/no_data.dart';
import '../../../../match_detail/widgets/container/analysis/item/analyze_divider.dart';
import 'analyze_news_logic.dart';

class AnalyzeNewsComponent extends StatelessWidget {
  AnalyzeNewsComponent({super.key}) ;

  final logic = Get.put(AnalyzeNewsLogic());
  final state = Get.find<AnalyzeNewsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeNewsLogic>(
        id: "analyzeNewsComponentBuilder",
        builder: (controller) {
          return (logic.noData)
              ? NoData(
                  content: LocaleKeys.analysis_football_matches_no_data.tr,
                  top: 30.h,
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                  width: 1.sw,
                  height: 1.sh,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: ScrollController(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildMeassgeBody(),
                        SizedBox(
                          height: 8.w,
                        ),
                        buildMessageFoot(),
                      ],
                    ),
                  ),
                );
        });
  }

  buildMeassgeBody() {
    return GetBuilder<AnalyzeNewsLogic>(
        id: "buildMeassgeBody",
        builder: (controller) {
          print("======>analyzeNewsEntity  ${ logic.state.analyzeNewsEntity.value}");
          return BoxShadowContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  logic.state.analyzeNewsEntity.value?.articleTittle ?? "",
                  style: TextStyle(
                      color: Get.theme.oddsButtonValueFontColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                ),
                SizedBox(
                  height: 6.w,
                ),
                buildSecondTitile(),
                SizedBox(
                  height: 8.w,
                ),
                buildMessageContent()
              ],
            ),
          );
        });
  }



  buildMessageFoot() {
    return GetBuilder<AnalyzeNewsLogic>(
        id: "buildMessageFoot",
        builder: (controller) {
          List<AnalyzeNewsEntity>  list=controller
              .state.analyzeFavoriteArticleList.map((element) => element).toList();
          list.removeWhere((element) => element.id==controller
              .state.analyzeNewsEntity.value.id);
          return controller.state.analyzeFavoriteArticleList.isEmpty
              ? TextNoData()
              : BoxShadowContainer(
                  padding: EdgeInsets.zero,
                  color: Get.theme.tabPanelBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 3.w,
                            height: 12.w,
                            decoration: BoxDecoration(
                                color: Color(0xFF189CFF),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4.w),
                                    bottomRight: Radius.circular(4.w))),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Text(
                            LocaleKeys.home_popular_you_may_also_like.tr,
                            style: TextStyle(
                                color: Get.theme.oddsButtonValueFontColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              controller.loadNewArticle(list[index]);
                            },
                            child: MatchNewsItem(list[index]),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return AnalyzeDivider();
                        },
                        itemCount:
                        list.length,

                      )
                    ],
                  ));
        });
  }

  buildSecondTitile() {
    return Container(
      height: 18.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(12.w))),
                alignment: Alignment.center,
                child: Icon(
                  Icons.person,
                  size: 12.w,
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                "${logic.state.analyzeNewsEntity.value?.categoryName ?? ""}     ",
                style: TextStyle(
                    fontSize: 12.sp, color: Get.theme.secondFontColor),
              ),
              Text(
                "       ${logic.state.analyzeNewsEntity.value?.readCounts ?? 0}${LocaleKeys.ouzhou_detail_read.tr}",
                style: TextStyle(
                    fontSize: 12.sp, color: Get.theme.secondFontColor),
              ),
            ],
          ),
          Text(
            logic.state.analyzeNewsEntity.value?.showTime ?? "",
            style: TextStyle(fontSize: 12.sp, color: Get.theme.secondFontColor),
          ),
        ],
      ),
    );
  }

  buildMessageContent() {
    return GetBuilder<AnalyzeNewsLogic>(
        id: "buildMeassgeBody",
        builder: (controller) {

          return Container(
              width: 1.sw,
              child: HtmlWidget(logic
                      .state.analyzeNewsEntity.value.articleContent
                      ?.replaceAll("IMAGE_DOMAIN_YUNYING_PLACEHOLDER",
                          "https://image.moof87.com//") ??
                  ""),);
        });
  }
}
