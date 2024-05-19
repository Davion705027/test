import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/result/championship_results/championship_results_controller.dart';
import 'package:flutter_ty_app/app/modules/result/normal_results/normal_results_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/mchampion_match_result_entity.dart';

import '../../../core/format/common/module/format-score.dart';
import '../../../widgets/image_view.dart';
import 'package:intl/intl.dart';

class ChampionshipItemWidget extends StatelessWidget {
  const ChampionshipItemWidget(
      {super.key,
      required this.isDark,
      required this.onExpandItem,
      required this.dataItem,
      required this.index});

  final bool isDark;
  final int index;

  final Function onExpandItem;
  
  final SportItem dataItem;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: isDark ? null : const Color(0xFFF2F2F6),
          child: Container(
            margin: EdgeInsets.only(left: 10.h, top: 5.h),
            alignment: Alignment.centerLeft,
            child: Text(
              '${dataItem.sportName}( ${dataItem.length} )',
              style: TextStyle(
                color: isDark
                    ? Colors.white.withOpacity(0.30000001192092896)
                    : const Color(0xFFAFB3C8),
                fontSize: 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        ...List.generate(dataItem.list.length, (index) {
          GroupItem groupItem = dataItem.list[index];
          return Container(
            color: isDark ? null : const Color(0xFFF2F2F6),
            child: Container(
              margin: EdgeInsets.only(
                  left: 8.w,
                  right: 8.w,
                  top: index == 0 ? 8.h : 0.h,
                  bottom: 8.h),
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
                    onTap: () => onExpandItem(groupItem),
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
                                width: 330.w,
                                child: AutoSizeText(
                                  groupItem.tournamentName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF303442),
                                    fontSize: 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )

                            ],
                          ),
                          Transform.rotate(
                            angle: groupItem.isExpand ? 0 : -pi / 2,
                            child: ImageView(
                              'assets/images/icon/icon_expand_gray_night.png',
                              width: 12.w,
                              height: 12.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                  Visibility(
                    visible: groupItem.isExpand,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: isDark
                                ? Colors.white.withOpacity(0.07999999821186066)
                                : const Color(0xFFE4E6ED),
                            width: 0.5.w,
                          ),
                        ),
                      ),

                      child: Container(
                        margin: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Column(
                          children: List<Widget>.generate(groupItem.list.length,
                                  (index) {
                                MchampionMatchResultData item = groupItem.list[index];
                                return Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10.h,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                               /* ImageView(
                                                  item.picUrl,
                                                  cdn: true,
                                                  width: 22.w,
                                                  height: 22.w,
                                                ),*/
                                                Container(
                                                  width: 130.w,
                                                  margin: EdgeInsets.only(
                                                    left: 0.w,
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    item.tournamentName,
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
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              width: 130.w,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                item.playName,
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
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10.h,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item.scoreResult,
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
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10.h,
                                        bottom: 10.h,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        formatDateTime(int.parse(item.matchTime)),
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white.withOpacity(0.5) :  const Color(0xFFAFB3C8),
                                          fontSize: 12.sp,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    if(index != groupItem.list.length-1)
                                      Container(
                                        height: 0.5.h,
                                        margin: EdgeInsets.only(
                                          top: 10.h,
                                        ),
                                        color: isDark
                                            ? Colors.white.withOpacity(0.07999999821186066)
                                            : const Color(0xFFE4E6ED),

                                      )
                                  ],
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('MM/dd HH:mm');
    return formatter.format(date);
  }
}
