import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../services/models/res/analyze_favorite_article_entity.dart';
import '../../../../../services/models/res/analyze_news_entity.dart';
import '../../../../../widgets/image_view.dart';

/// 下拉赛事选择项
class MatchNewsItem extends StatelessWidget {
  AnalyzeNewsEntity entity;

  MatchNewsItem(this.entity, {super.key});

  @override
  Widget build(BuildContext context) {


    Color color= Color(0xFFFF6800);
    try{
      color= AppColor.hexToColor(
          entity.tagColor ?? "#FFFF6800");
    }catch(e){
      print("=========tagColor${entity.tagColor}");
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.w),

      // padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.w),
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.w))),
                        child: Text(
                          entity?.tagName ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      Text(
                        entity.articleTittle ?? "",
                        style: TextStyle(
                            fontSize: 12.sp, color: Get.theme.secondFontColor),
                      )
                      // HtmlWidget(entity?.summary ?? "")
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 12.w,
              ),
              buildSecondTitile()
            ],
          )),
          Container(
            width: 60.w,
            height: 60.w,
            child: ImageView(
              entity.thumbnails ?? "",
              cdn: true,
              boxFit: BoxFit.fitHeight,
              width: 100.w,
              height: 80.w,
            ),
          )
        ],
      ),
    );
  }

  buildSecondTitile() {
    return Container(
      height: 18.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text(
                "${entity?.authorName ?? ""}     ",
                style: TextStyle(
                    fontSize: 12.sp, color: Get.theme.secondFontColor),
              ),
              Text(
                "       ${entity?.readCounts}${LocaleKeys.ouzhou_detail_read.tr}",
                style: TextStyle(
                    fontSize: 12.sp, color: Get.theme.secondFontColor),
              ),
            ],
          ),
          Text(
            entity?.showTime ?? "",
            style: TextStyle(fontSize: 12.sp, color: Get.theme.secondFontColor),
          ),
        ],
      ),
    );
  }
}
