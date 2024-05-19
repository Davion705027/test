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

class AnalyzeNewsDialog extends StatefulWidget {
  AnalyzeNewsEntity analyzeNewsEntity;

  AnalyzeNewsDialog(this.analyzeNewsEntity, {super.key});

  @override
  State<StatefulWidget> createState() {
    return AnalyzeNewsDialogState(analyzeNewsEntity);
  }
}

class AnalyzeNewsDialogState extends State<AnalyzeNewsDialog> {
  AnalyzeNewsEntity analyzeNewsEntity;

  AnalyzeNewsDialogState(this.analyzeNewsEntity);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeNewsLogic>(
        id: "AnalyzeNewsDialogBuilder",
        builder: (controller) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.w),
                      topRight: Radius.circular(12.w))),
              padding: EdgeInsets.symmetric(vertical: 5.w),
              width: 1.sw,
              height: 0.83.sh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: buildHead(context),
                  ),
                  Container(
                    width: 1.sw,
                    height: 0.7.sh,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      controller: ScrollController(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          noData? NoData(
                            content: LocaleKeys.analysis_football_matches_no_data.tr,
                            top: 30.h,
                          ):buildMeassgeBody(),
                          SizedBox(
                            height: 8.w,
                          ),
                          if(!noData)
                          buildMessageFoot(),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  buildMeassgeBody() {
    return BoxShadowContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildMessageContent()],
      ),
    );
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
                "${analyzeNewsEntity?.categoryName ?? ""}     ",
                style: TextStyle(
                    fontSize: 12.sp, color: Get.theme.secondFontColor),
              ),
              Text(
                "       ${analyzeNewsEntity?.readCounts ?? 0}${LocaleKeys.ouzhou_detail_read.tr}",
                style: TextStyle(
                    fontSize: 12.sp, color: Get.theme.secondFontColor),
              ),
            ],
          ),
          Text(
            analyzeNewsEntity?.showTime ?? "",
            style: TextStyle(fontSize: 12.sp, color: Get.theme.secondFontColor),
          ),
        ],
      ),
    );
  }

  buildMessageContent() {
    print("=========>数据  ${analyzeNewsEntity.articleContent}");
    return Container(
      width: 1.sw,
      child: HtmlWidget(analyzeNewsEntity.articleContent?.replaceAll(
              "IMAGE_DOMAIN_YUNYING_PLACEHOLDER",
              "https://image.moof87.com//") ??
          ""),
    );
  }

  buildHead(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
              child: Text(
                LocaleKeys.ouzhou_setting_menu_back.tr,
                style: TextStyle(
                    fontSize: 16.sp, color: Get.theme.secondFontColor),
              ),
            ),
          ),
          SizedBox(
            height: 20.w,
          ),
          Text(
            analyzeNewsEntity.articleTittle ?? "",
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
        ],
      ),
    );
  }

  buildMessageFoot() {
    return BoxShadowContainer(
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
                    AnalyzeNewsLogic.to.loadNewArticle(list[index]);
                  },
                  child: MatchNewsItem(list[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return AnalyzeDivider();
              },
              itemCount: list.length,
            )
          ],
        ));
  }

  List<AnalyzeNewsEntity> list = [];
bool noData=true;
  void getData() {
    list = AnalyzeNewsLogic.to.state.analyzeFavoriteArticleList
        .map((element) => element)
        .toList();
    list.removeWhere((element) =>
        element.id ==this.analyzeNewsEntity.id);

    AnalyzeNewsLogic.to.requestGetArticle(
        mid: analyzeNewsEntity.id ?? "",
        type: "2",
        analyzeNewListener: (AnalyzeNewsEntity entity) {
          print("===========>${entity.toJson()}");
          if(entity.articleContent?.isEmpty==true) {
            noData=true;
          }else{
            noData=false;
          }
          this.analyzeNewsEntity = entity;

          setState(() {});
        });
  }
}
