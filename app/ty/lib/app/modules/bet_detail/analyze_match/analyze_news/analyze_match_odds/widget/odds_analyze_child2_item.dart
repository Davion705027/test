import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_odds/widget/triangle_path.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_third_odds_entity.dart';

/// 下拉赛事选择项
class OddsAnalyzeChild2Item extends StatelessWidget {
  AnalyzeGetMatchAnalysiseThirdOddsEntity entity;

  OddsAnalyzeChild2Item(this.entity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.w),
      // padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
      width: 1.sw,
      height: 73.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Text(
                  "${entity.bookName}",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Get.theme.tabPanelSelectedColor,
                    fontSize: 12.sp,
                  ),
                ).marginSymmetric(horizontal: 2.w).expanded(flex: 2),
                Container(
                  height: 73.w,
                  decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            color: Get.theme.betPanelUnderlineColor,
                            width: 0.5),
                        bottom: BorderSide(
                            color: Get.theme.betPanelUnderlineColor,
                            width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        height: 36.w,
                        decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Get.theme.betPanelUnderlineColor,
                                  width: 0.5),
                              bottom: BorderSide(
                                  color: Get.theme.betPanelUnderlineColor,
                                  width: 0.5)),
                        ),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          LocaleKeys.analysis_football_matches_Initial_offer.tr,
                          minFontSize: 8,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Get.theme.tabPanelSelectedColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      Container(
                        height: 36.w,
                        decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Get.theme.betPanelUnderlineColor,
                                  width: 0.5),
                              bottom: BorderSide(
                                  color: Get.theme.betPanelUnderlineColor,
                                  width: 0.5)),
                        ),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          LocaleKeys.analysis_football_matches_immediate.tr,
                          minFontSize: 8,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Get.theme.tabPanelSelectedColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).expanded(),
              ],
            ),
          ),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5),
                          bottom: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${entity.handicapOddsDTOList?[0].value0 ?? ""}",
                      style: TextStyle(
                          color: Get.theme.tabPanelSelectedColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5),
                          bottom: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5)),
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
                          visible: entity?.handicapOddsDTOList?[1].directions
                                  ?.value0 !=
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
                              color: getColor(entity?.handicapOddsDTOList?[1]
                                      .directions?.value0
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
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5),
                          bottom: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${entity.handicapOddsDTOList?[0].handicapVal ?? ""}",
                      style: TextStyle(
                          color: Get.theme.tabPanelSelectedColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                      height: 36.w,
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                color: Get.theme.betPanelUnderlineColor,
                                width: 0.5),
                            bottom: BorderSide(
                                color: Get.theme.betPanelUnderlineColor,
                                width: 0.5)),
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
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5),
                          bottom: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${entity.handicapOddsDTOList?[1].value ?? ""}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Get.theme.tabPanelSelectedColor,
                            fontSize: 12.sp,
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5),
                          bottom: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(
                        "${entity.handicapOddsDTOList?[1].value ?? ""}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: getColor(entity
                              .handicapOddsDTOList?[1].directions?.value
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
                        )],
                    )
                  ),
                ],
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5),
                          bottom: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${entity.handicapOddsDTOList?[0].value0WinRate ?? "-"}%",
                      style: TextStyle(
                          color: Get.theme.tabPanelSelectedColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5),
                          bottom: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${entity.handicapOddsDTOList?[1].value0WinRate ?? "-"}%",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: getColor(entity.handicapOddsDTOList?[1]
                                .directions?.value0WinRate
                                ?.toInt() ??
                            0),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5),
                          bottom: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${entity.handicapOddsDTOList?[0].valueWinRate ?? "-"}%",
                      style: TextStyle(
                          color: Get.theme.tabPanelSelectedColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5),
                          bottom: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${entity.handicapOddsDTOList?[1].valueWinRate ?? "-"}%",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: getColor(entity.handicapOddsDTOList?[1]
                                .directions?.valueWinRate
                                ?.toInt() ??
                            0),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5),
                          bottom: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${entity.handicapOddsDTOList?[0].returnRate ?? "-"}%",
                      style: TextStyle(
                          color: Get.theme.tabPanelSelectedColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    height: 36.w,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5),
                          bottom: BorderSide(
                              color: Get.theme.betPanelUnderlineColor,
                              width: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${entity.handicapOddsDTOList?[1].returnRate ?? "-"}%",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: getColor(entity
                                .handicapOddsDTOList?[1].directions?.returnRate
                                ?.toInt() ??
                            0),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  getColor(int? value) {
    Color color = Color.fromRGBO(48, 52, 66, 1); // Color(0xFF303442);
    if (value == 1) {
      return Color.fromRGBO(255, 68, 0, 1); //Color(0xFFF53F3F);
    } else if (value == -1) {
      return Color.fromRGBO(113, 200, 102, 1); //Color(0xFF00B42A);
    }
    return color;
  }
}
