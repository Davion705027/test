import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_odds/widget/triangle_path.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_third_odds_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../../widgets/image_view.dart';

/// 下拉赛事选择项
class OddsAnalyzeItem extends StatelessWidget {
  AnalyzeGetMatchAnalysiseThirdOddsEntity entity;

  OddsAnalyzeItem(this.entity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.w),
      // padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
      width: 1.sw,
      height: 72.w,

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: ScrollController(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 56.w,
              height: 72.w,
              decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5),
                    bottom: BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5)),
              ),
              alignment: Alignment.center,
              child: Text(
                "${entity.bookName}",
                style: TextStyle(
                  color:Get.theme.tabPanelSelectedColor,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5),
                        bottom:
                            BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    LocaleKeys.analysis_football_matches_Initial_offer.tr,
                    style: TextStyle(
                      color:Get.theme.tabPanelSelectedColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5),
                        bottom:
                            BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    LocaleKeys.analysis_football_matches_immediate.tr,
                    style: TextStyle(
                      color:Get.theme.tabPanelSelectedColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 90.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5),
                        bottom:
                            BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${entity.handicapOddsDTOList?[0].value0 ?? ""}",
                        style: TextStyle(
                            color:Get.theme.tabPanelSelectedColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 90.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5),
                        bottom:
                            BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${entity.handicapOddsDTOList?[1].value0 ?? ""}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: getColor(entity
                                  ?.handicapOddsDTOList?[1].directions?.value0
                                  ?.toInt() ??
                              0),
                          fontSize: 12.sp,
                        ),
                      ),
                      Visibility(
                        visible: entity
                                ?.handicapOddsDTOList?[1].directions?.value0 !=
                            0,
                        child: ClipPath(
                          clipper: TrianglePath(
                              up: entity?.handicapOddsDTOList?[1].directions
                                      ?.value0
                                      ?.toInt() ==
                                  1),
                          child: Container(
                            height: 6.w,
                            width: 6.w,
                            color: getColor(entity
                                    ?.handicapOddsDTOList?[1].directions?.value0
                                    ?.toInt() ??
                                0),
                            child: SizedBox(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 90.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5),
                        bottom:
                            BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${entity.handicapOddsDTOList?[0].handicapVal ?? ""}",
                    style: TextStyle(
                        color:Get.theme.tabPanelSelectedColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                    width: 90.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right:
                              BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5),
                          bottom:
                              BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${entity.handicapOddsDTOList?[1].handicapVal ?? ""}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: getColor(entity?.handicapOddsDTOList?[1]
                                    .directions?.handicapVal
                                    ?.toInt() ??
                                0),
                            fontSize: 12.sp,
                          ),
                        ),

                        Visibility(
                          visible: entity?.handicapOddsDTOList?[1].directions
                                  ?.handicapVal !=
                              0,
                          child: ClipPath(
                            clipper: TrianglePath(
                                up: entity?.handicapOddsDTOList?[1].directions
                                        ?.handicapVal
                                        ?.toInt() ==
                                    1),
                            child: Container(
                              height: 6.w,
                              width: 6.w,
                              color: getColor(entity?.handicapOddsDTOList?[1]
                                      .directions?.handicapVal
                                      ?.toInt() ??
                                  0),
                              child: SizedBox(),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 90.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5),
                        bottom:
                            BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${entity.handicapOddsDTOList?[0].value ?? ""}",
                    style: TextStyle(
                        color:Get.theme.tabPanelSelectedColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                    width: 90.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right:
                              BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5),
                          bottom:
                              BorderSide(color: Get.theme.betPanelUnderlineColor, width: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${entity.handicapOddsDTOList?[1].value ?? ""}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: getColor(entity
                                    ?.handicapOddsDTOList?[1].directions?.value
                                    ?.toInt() ??
                                0),
                            fontSize: 12.sp,
                          ),
                        ),
                        Visibility(
                          visible: entity
                                  ?.handicapOddsDTOList?[1].directions?.value !=
                              0,
                          child: ClipPath(
                            clipper: TrianglePath(
                                up: entity?.handicapOddsDTOList?[1].directions
                                        ?.value
                                        ?.toInt() ==
                                    1),
                            child: Container(
                              height: 6.w,
                              width: 6.w,
                              color: getColor(entity?.handicapOddsDTOList?[1]
                                      .directions?.value
                                      ?.toInt() ??
                                  0),
                              child: SizedBox(),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getColor(int? value) {
    Color color = Color(0xFF303442);
    if (value == 1) {
      return Color(0xFFF53F3F);
    } else if (value == -1) {
      return Color(0xFF00B42A);
    }
    return color;
  }
}
