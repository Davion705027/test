import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/result/results_details/results_details_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import '../../../core/format/common/module/format-date.dart';
import '../../../services/models/res/playback_video_url_entity.dart';
import '../../../utils/oss_util.dart';
import '../../../widgets/image_view.dart';
import 'package:intl/intl.dart';

import 'HeaderModel.dart';

class MatchReplayWidget extends StatelessWidget {
  const MatchReplayWidget({
    super.key,
    required this.isDark,
    required this.videoHead,
    required this.videoIndex,
    required this.onSelectVideo,
    required this.detailData,
    required this.headerMap,
    required this.eventList,
    required this.onPlayVideo,
  });

  final bool isDark;
  final List<String> videoHead;
  final int videoIndex;
  final void Function(dynamic) onSelectVideo;
  final MatchEntity? detailData;
  final HeaderModel headerMap;
  final  List<PlaybackVideoUrlDataEventList> eventList ;
  final void Function(dynamic) onPlayVideo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color:isDark ? null : const Color(0xFFF2F2F6),
        child: Container(
          margin:  EdgeInsets.only(top: 10,left: 10.w,right: 10.w,),
          decoration: isDark ?
          ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            image:  DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    'assets/images/detail/bg-dark.png',
                  ),
                ),

                fit: BoxFit.cover,),
            shadows: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          )
              : ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10.h,bottom: 16.h,),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Container(
                      decoration: ShapeDecoration(
                        color: isDark ? Colors.white.withOpacity(0.07999999821186066) : const Color(0xFFF2F2F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(3.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List<Widget>.generate(videoHead.length, (index) {
                            return Container(
                              decoration:
                              videoIndex == index ?
                              ShapeDecoration(
                                color: isDark ? Colors.white.withOpacity(0.07999999821186066): Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ):null,
                              child: InkWell(
                                onTap: ()=> onSelectVideo(index),
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.w,right: 10.w,top: 2.w,bottom: 2.w),
                                  child: AutoSizeText(
                                    videoHead[index],
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: isDark ? videoIndex == index ? Colors.white.withOpacity(0.8999999761581421) : Colors.white.withOpacity(0.30000001192092896) : videoIndex == index ? const Color(0xFF303442) : const Color(0xFFAFB3C8),
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child:Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageView(
                              'assets/images/icon/jchf.png',
                              width: 18.w,
                              height: 18.w,
                            ),
                            Container(width: 10.w,),
                            Text(
                                detailData!.mststr.isNotEmpty ?  TYFormatDate.formatMgtTime(detailData!.mststr) : '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark ? Colors.white : const Color(0xFF303442),
                                fontSize: 12.sp,
                                fontFamily: 'DIN Alternate',
                              ),
                            ),


                            Container(width: 10.w,),
                            Text(
                              '[${headerMap.score}]',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF179CFF),
                                fontSize: 12.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(width: 10.w,),
                            // todo
                            Text(
                            LocaleKeys.match_info_match_over.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark ? Colors.white : const Color(0xFF303442),
                                fontSize: 12.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
///精彩回放列表
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: eventList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            PlaybackVideoUrlDataEventList eventItem = eventList[index];
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                eventItem.isHomeOrAway == 'home' ?
                                  InkWell(
                                    onTap: ()=>onPlayVideo(eventItem),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10.h,left: 5.w,right: 5.w),
                                          decoration: ShapeDecoration(
                                            color:  isDark ? Colors.white.withOpacity(0.03999999910593033) : const Color(0xFFF2F2F6),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                          child:Container(
                                            margin: EdgeInsets.all(5.h),
                                            child: Row(

                                              children: [
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(8.r), // 设置圆角半径
                                                      child: ImageView(
                                                        eventItem.fragmentPic,
                                                        width: 77.w,
                                                        height: 50.h,
                                                      ),
                                                    ),
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(8.r), // 设置圆角半径
                                                      child: Container(
                                                        width: 77.w,
                                                        height: 45.h,
                                                        color: Colors.black.withOpacity(0.3),
                                                      ),
                                                    ),

                                                    ImageView(
                                                      'assets/images/icon/hzh.png',
                                                      width: 16.w,
                                                      height: 16.h,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 5.w),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [

                                                          Text(
                                                            TYFormatDate.formatMgtTime(eventItem.secondsFromStart),
                                                            textAlign: TextAlign.right,
                                                            style: TextStyle(
                                                              color: isDark ? Colors.white : const Color(0xFF303442),
                                                              fontSize: 12.sp,
                                                              fontFamily: 'DIN Alternate',
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                          Container(width: 5.w,),
                                                          Text(
                                                            '['+eventItem.t1.toString()+'-'+eventItem.t2.toString()+"]",
                                                            style: TextStyle(
                                                              color: const Color(0xFF179CFF),
                                                              fontSize: 12.sp,
                                                              fontFamily: 'DIN Alternate',
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),


                                                        ],
                                                      ),
                                                      Container(height: 2.h,),
                                                      Container(
                                                         width: 80.w,
                                                        alignment: Alignment.centerLeft,
                                                        child: AutoSizeText(
                                                          eventItem.homeAway,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            color: isDark ? Colors.white.withOpacity(0.5) : const Color(0xFF7981A3),
                                                            fontSize: 11.sp,
                                                            fontFamily: 'PingFang SC',
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(height: 2.h,),
                                                      Container(
                                                        width: 80.w,
                                                        child: AutoSizeText(
                                                          maxLines: 1,
                                                          getFlagMap(eventItem.eventCode).name.toString().replaceAll('{X}', eventItem.firstNum.toString()),
                                                          style: TextStyle(
                                                            color: isDark ? Colors.white.withOpacity(0.5) : const Color(0xFF7981A3),
                                                            fontSize: 11.sp,
                                                            fontFamily: 'PingFang SC',
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      )

                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        const Expanded(child: SizedBox()),
                                      ],
                                    ),
                                  ):
                                InkWell(
                                  onTap: ()=>onPlayVideo(eventItem),
                                  child: Row(
                                    children: [
                                      const Expanded(child: SizedBox()),
                                      Container(
                                        margin: EdgeInsets.only(top: 10.h,left: 5.w,right: 5.w),
                                        decoration: ShapeDecoration(
                                          color: isDark ? Colors.white.withOpacity(0.03999999910593033) : const Color(0xFFF2F2F6),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        child:Container(
                                          margin: EdgeInsets.all(5.h),
                                          child: Row(

                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(8.r), // 设置圆角半径
                                                    child: ImageView(
                                                      eventItem.fragmentPic,
                                                      width: 77.w,
                                                      height: 50.h,
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(8.r), // 设置圆角半径
                                                    child: Container(
                                                      width: 77.w,
                                                      height: 45.h,
                                                      color: Colors.black.withOpacity(0.3),
                                                    ),
                                                  ),

                                                  ImageView(
                                                    'assets/images/icon/hzh.png',
                                                    width: 16.w,
                                                    height: 16.h,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(left: 5.w),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          TYFormatDate.formatMgtTime(eventItem.secondsFromStart),
                                                          textAlign: TextAlign.right,
                                                          style: TextStyle(

                                                            color:isDark ? Colors.white : const Color(0xFF303442),
                                                            fontSize: 12.sp,
                                                            fontFamily: 'DIN Alternate',
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                        Container(width: 5.w,),
                                                        Text(
                                                          '['+eventItem.t1.toString()+'-'+eventItem.t2.toString()+"]",
                                                          style: TextStyle(
                                                            color: const Color(0xFF179CFF),
                                                            fontSize: 12.sp,
                                                            fontFamily: 'DIN Alternate',
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                    Container(height: 2.h,),
                                                    Container(
                                                      width: 80.w,
                                                      alignment: Alignment.centerLeft,
                                                      child: AutoSizeText(
                                                        eventItem.homeAway,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: isDark ? Colors.white.withOpacity(0.5) : const Color(0xFF7981A3),
                                                          fontSize: 11.sp,
                                                          fontFamily: 'PingFang SC',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),

                                                    Container(height: 2.h,),
                                                    Container(
                                                      width: 80.w,
                                                      child:   AutoSizeText(
                                                        maxLines: 1,
                                                        getFlagMap(eventItem.eventCode).name.toString().replaceAll('{X}', eventItem.firstNum.toString()),
                                                        style: TextStyle(
                                                          color: isDark ? Colors.white.withOpacity(0.5) : const Color(0xFF7981A3),
                                                          fontSize: 11.sp,
                                                          fontFamily: 'PingFang SC',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    )

                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 5.h,),
                                      child: ImageView(
                                       getFlagMap(eventItem.eventCode).icon,
                                        width: 15.w,
                                        height: 15.h,
                                      ),
                                    ),
                                    Container(
                                      margin:  EdgeInsets.only(top: 5.h,),
                                      width: 2,
                                      height: 40.h,
                                      color: const Color(0xFF179CFF),
                                    ),

                                  ],
                                )
                              ],
                            );
                          }),



                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageView(
                              'assets/images/icon/jchf.png',
                              width: 18.w,
                              height: 18.w,
                            ),
                            Container(width: 10.w,),
                            Text(
                              '00:00',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark ? Colors.white : const Color(0xFF303442),
                                fontSize: 12.sp,
                                fontFamily: 'DIN Alternate',
                              ),
                            ),


                            Container(width: 10.w,),
                            Text(
                              '[0-0]',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF179CFF),
                                fontSize: 12.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(width: 10.w,),
                            Text(
                              // todo
                              LocaleKeys.game_start.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark ? Colors.white :  const Color(0xFF303442),
                                fontSize: 12.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(height: 30.h,)
                    ],
                  ),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('MM/dd HH:mm');
    return formatter.format(date);
  }

  // 精彩回放列表显示'的图标
  getFlagMap(type){
    FLagModel res = FLagModel();
    switch (type) {
    // 进球
      case 'goal':
        res.icon = 'assets/images/icon/goal.svg';
        // todo
        res.name = LocaleKeys.highlights_event_type_goal.tr;
        break;
    // 角球
      case 'corner':
        // 角球图标与头部一致
        res.icon = 'assets/images/detail/corner_kick_red.svg';
        res.name =  LocaleKeys.highlights_event_type_corner.tr;
        break;
    // 红牌
      case "red_card":
        res.icon = 'assets/images/icon/icon_rule3.png';
        res.name =  LocaleKeys.highlights_event_type_red_card.tr;
        break;
    // 黄牌
      case "yellow_card":
        res.icon = 'assets/images/icon/icon_rule2.png';
        res.name = LocaleKeys.highlights_event_type_yellow_card.tr;
        break;
    // 黄红牌
      case "yellow_red_card":
        res.icon = 'icon-flag-card-red';
        res.name =  LocaleKeys.highlights_event_type_yellow_red_card.tr;
        break;
      default:
        res.icon = '';
        break;
    }
    return res;
  }
}
