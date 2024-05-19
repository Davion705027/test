import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/result/normal_results/normal_results_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/format/common/module/format-score.dart';
import '../../../widgets/image_view.dart';
import 'package:intl/intl.dart';

import '../gaming_results/gaming_results_controller.dart';

class ResultsItemWidget extends StatelessWidget {
  const ResultsItemWidget({
    super.key,
    required this.isDark,
     required this.dataItem,
    this.onExpandItem,
    required this.index,
    required this.onGoToDetails,
  });

  final bool isDark;
  final TidDataList dataItem;
  final VoidCallback? onExpandItem;
  final int index;
  final void Function(dynamic) onGoToDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark ? null : const Color(0xFFF2F2F6),
      child: Container(
        margin: EdgeInsets.only(left: 8.w, right: 8.w, top:8.h),
          decoration: isDark
              ? ShapeDecoration(
              color: Colors.white.withOpacity(0.03999999910593033),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.w,
                  color: Colors.white.withOpacity(0.03999999910593033),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ])
              : ShapeDecoration(
            color: const Color(0xFFF8F9FA),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.w, color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
        child: Column(
          children: [
            InkWell(
              onTap: onExpandItem,
              child: Container(
                margin: EdgeInsets.only(right: 5.w),
                height: 30.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ImageView(
                          'assets/images/icon/title_tag.png',
                          width: 2.w,
                          height: 15.w,
                        ),
                        Container(
                          width: 8.w,
                        ),
                        SizedBox(
                          width: 300.w,
                          child: AutoSizeText(
                            dataItem.tn,
                            style: TextStyle(
                              color:
                              isDark ? Colors.white : const Color(0xFF303442),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )

                      ],
                    ),
                    Transform.rotate(
                      angle: dataItem.isExpand ? 0 : -pi / 2,
                      child: ImageView(
                        context.isDarkMode ? 'assets/images/icon/results_folding_dark.png' : 'assets/images/icon/results_folding_light.png',
                        width: 13.w,
                        height: 13.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            dataItem.isExpand
                ? Container(
              color: isDark
                  ? Colors.white.withOpacity(0.07999999821186066)
                  : const Color(0xFFE4E6ED),
              height: 0.5.h,
            )
                : Container(),

            Visibility(
              visible: dataItem.isExpand,
              maintainAnimation: true,
              maintainState: true,
              child: Container(
          /*      decoration: index > 0 && index <= dataItem.list.length
                    ? BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 0.5.w,
                    ),
                  ),
                )
                    : null,*/
                margin: EdgeInsets.only(
                  left: 8.w,
                  right: 8.w,
                ),
                child: Column(
                  children: List<Widget>.generate(dataItem.list.length, (index) {
                    return InkWell(
                      onTap: () => onGoToDetails(dataItem.list[index]),
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 3.h,
                        ),
                        decoration:
                        index != dataItem.list.length-1 ?
                        BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isDark
                                  ? Colors.white.withOpacity(0.07999999821186066)
                                  : const Color(0xFFE4E6ED),
                              width: 0.6.w,
                            ),
                          ),
                        ):null,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                formatDateTime(int.parse(dataItem.list[index].mgt)),
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      .withOpacity(0.30000001192092896)
                                      : const Color(0xFFAFB3C8),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: 20.w,
                                        ),
                                        height: 34.h,
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                dataItem.list[index].mhn,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: isDark
                                                      ? Colors.white
                                                      : const Color(0xFF303442),
                                                  fontSize: 12.sp,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 0,
                                              child: Text(
                                                TYFormatScore.formatTotalScore(
                                                    dataItem.list[index])
                                                    .home,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: isDark
                                                      ? Colors.white
                                                      : const Color(0xFF303442),
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Akrobat',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 34.h,
                                        margin: EdgeInsets.only(
                                          right: 20.w,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                dataItem.list[index].man,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: isDark
                                                      ? Colors.white
                                                      : const Color(0xFF303442),
                                                  fontSize: 12.sp,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 0,
                                              child: Text(
                                                TYFormatScore.formatTotalScore(
                                                    dataItem.list[index])
                                                    .away,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: isDark
                                                      ? Colors.white
                                                      : const Color(0xFF303442),
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Akrobat',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 0.50.w,
                                        height: 50.h,
                                        color: isDark
                                            ? const Color(0x14E4E6ED)
                                            :const Color(0xFFE4E6ED),
                                      ),
                                      Container(
                                        width: 20.w,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () =>
                                                onGoToDetails(dataItem.list[index]),
                                            child: Text(
                                              LocaleKeys.list_go_to_details.tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: isDark
                                                    ? Colors.white
                                                    : const Color(0xFF303442),
                                                fontSize: 10.sp,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 5.w,
                                          ),
                                          ImageView(
                                          context.isDarkMode ? 'assets/images/icon/results_details_dark.png' :'assets/images/icon/results_details_light.png',
                                            width: 12.w,
                                            height: 12.w,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('MM/dd HH:mm');
    return formatter.format(date);
  }
}
