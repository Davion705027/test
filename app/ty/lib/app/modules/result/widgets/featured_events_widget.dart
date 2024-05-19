import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-score.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';

import '../../../services/models/res/match_entity.dart';
import '../../../widgets/image_view.dart';
import 'package:intl/intl.dart';

import '../../home/widgets/item/counting-down/counting-down.dart';
import '../../home/widgets/item/profession/score_list2.dart';
import '../../match_detail/widgets/container/odds_info/odds_button.dart';

class FeaturedEventsWidget extends StatelessWidget {
  const FeaturedEventsWidget({
    super.key,
    required this.isDark,
    this.onExpandItem,
    required this.matcheHandpickData,
    required this.onGoToDetails,
  });

  final bool isDark;
  final VoidCallback? onExpandItem;
  final List<MatchEntity> matcheHandpickData;
  final void Function(dynamic) onGoToDetails;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: matcheHandpickData.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          var matchEntity = matcheHandpickData[index];
           bool showStartCountingDown =
              MatchUtil.showStartCountingDown(matchEntity);
              bool showCountingDown = MatchUtil.showCountingDown(matchEntity);
          return InkWell(
            // 跳转详情
            onTap: () => onGoToDetails(matcheHandpickData[index]),
            child: Container(
              margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
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
              child: Container(
                margin: EdgeInsets.all(10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                children: [
                  // 1 开赛   110 即将开赛
                  //  ms = 1 110 才匹配（已开赛的）其他直接显示时间。
                  
                  //  <!--开赛日期 ms != 110 (不为即将开赛)  subMenuType = 13网球(进行中不显示，赛前需要显示)-->
                  if (matchEntity.ms != 110 &&
                      !showStartCountingDown &&
                      !showCountingDown)
                        Text(
                          DateUtil.formatDateMs(int.parse(matchEntity.mgt),
                              format: isZh() ? LocaleKeys.time11.tr : LocaleKeys.time4.tr),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: context.isDarkMode
                                ? Colors.white.withOpacity(0.30000001192092896)
                                : const Color(0xffAFB3C8),
                          ),
                        ),

                  // <!-- 赛事回合数mfo match.ms != 1(不为开赛)-->
                      if (matchEntity.mfo != null && matchEntity.ms != 1)
                          Text(
                            matchEntity.mfo,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: context.isDarkMode
                                  ? Colors.white.withOpacity(0.30000001192092896)
                                  : const Color(0xffAFB3C8),
                            ),
                          ),

                  //  即将开赛 ms = 110
                  if (matchEntity.ms == 110)
                    Text(
                      'ms_110'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: context.isDarkMode
                            ? Colors.white.withOpacity(0.30000001192092896)
                            : const Color(0xffAFB3C8),
                      ),
                    ).marginOnly(right: 4.w),

                  //  <!-- 一小时内开赛  -->
                  if (matchEntity.ms != 110 && showStartCountingDown)
                        Text(
                          LocaleKeys.list_after_time_start.tr.replaceFirst('{0}',
                              MatchUtil.getStartCountTime(matchEntity).toString()),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: context.isDarkMode
                                ? Colors.white.withOpacity(0.30000001192092896)
                                : const Color(0xffAFB3C8),
                          ),
                        ),
                  // CountingdownStart(matchEntity,matchEntity.mgt),

                  //  <!--倒计时或正计时-->
                  if (matchEntity.ms != 110 && showCountingDown)
                        Countingdown(matchEntity),
                  
                        Text(
                              '${matcheHandpickData[index].mc}+',
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.30000001192092896)
                                : const Color(0xFFAFB3C8),
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                            ).marginOnly(left: 8.w),
                ],
              ),
                      
                  
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    if (!['5', '10', '7', '8']
                                        .contains(matcheHandpickData[index].csid))
                                      ImageView(
                                        matcheHandpickData[index].mhlu[0],
                                        cdn: true,
                                        width: 20.w,
                                        height: 20.w,
                                      ).marginOnly(right: 8.w),
                                    SizedBox(
                                      width: 135.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[
                                          SizedBox(
                                            width: 110.w,
                                            child:Text(
                                              matcheHandpickData[index].mhn,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: MatchUtil.getHandicapIndexBy(
                                                    matcheHandpickData[index]) ==
                                                    1
                                                    ? const Color(0xFF74C4FF)
                                                    : isDark
                                                    ? Colors.white
                                                    : const Color(0xFF303442),
                                                fontSize: 12.sp,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ) ,
                                          ),
                                          if(matcheHandpickData[index].ms != 0)
                                            Text(TYFormatScore.formatTotalScore(matcheHandpickData[index]).home) 
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 15.h,
                                ),


                                Row(
                                  children: [
                                    if (!['5', '10', '7', '8']
                                        .contains(matcheHandpickData[index].csid))
                                      ImageView(
                                        matcheHandpickData[index].malu[0],
                                        cdn: true,
                                        width: 20.w,
                                        height: 20.w,
                                      ).marginOnly(right: 8.w),

                                    SizedBox(
                                      width: 135.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            matcheHandpickData[index].man,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: MatchUtil.getHandicapIndexBy(
                                                  matcheHandpickData[index]) ==
                                                  2
                                                  ? const Color(0xFF74C4FF)
                                                  : isDark
                                                  ? Colors.white
                                                  : const Color(0xFF303442),
                                              fontSize: 12.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        if(matcheHandpickData[index].ms != 0)
                                          Text(TYFormatScore.formatTotalScore(matcheHandpickData[index]).away)
                                        ],
                                      ),
                                    )

                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child:Row(
                                children: matcheHandpickData[index]
                                    .hps[0]
                                    .hl[0]
                                    .ol
                                    .isNotEmpty
                                    ? List<Widget>.generate(
                                    matcheHandpickData[index]
                                        .hps[0]
                                        .hl[0]
                                        .ol
                                        .length, (item) {
                                  MatchEntity match =
                                  matcheHandpickData[index];
                                  return Container(
                                    width: 80.w,
                                    height: 55.h,
                                    margin: EdgeInsets.only(left: 4.w),
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x0A000000),
                                          blurRadius: 6,
                                          offset: Offset(0, 2),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: OddsButton(
                                      name: match.hps[0].hl[0].ol[item].on,
                                      match: match,
                                      hps: match.hps[0],
                                      ol: match.hps[0].hl[0].ol[item],
                                      hl: match.hps[0].hl[0],
                                    ),
                                  );
                                }).toList()
                                    :
                                // 空 显示 “-”
                                List<Widget>.generate(2, (item) {
                                  return OddsButton(
                                    width: 80.w,
                                    height: 55.h,
                                  ).marginOnly(left: 4.w);
                                }).toList()),
                          ),
                        ],
                      ),
                    ),

                    if(matcheHandpickData[index].ms == 1)
                      ScoreList2(
                        match: matcheHandpickData[index]
                      )
                  ],
                ),
              ),
            ),
          );
        });
  }

  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('MM/dd HH:mm');
    return formatter.format(date);
  }
}
