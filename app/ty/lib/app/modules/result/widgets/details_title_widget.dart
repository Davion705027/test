import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:marquee/marquee.dart';
import 'dart:ui';
import '../../../core/format/common/module/format-score.dart';

class DetailsTitleWidget extends StatelessWidget {
  const DetailsTitleWidget({
    super.key,
    required this.isDark,
    required this. headMenu,
    required this.onHeadMenu,
    required this.detailData,
    required this.headMatchList,
    required this.onHeadMatch,
    required this. mid,
    required this.titleIndex,


  });


  final bool isDark;
  final bool headMenu;
  final VoidCallback? onHeadMenu;
  final  MatchEntity? detailData;
  final List<MatchEntity> headMatchList;
  final void Function(dynamic) onHeadMatch;
  final String mid;
  final int titleIndex;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: headMenu,
      maintainAnimation: true,
      maintainState: true,
      child: Column(
        children: [
          Container(
            color:  isDark ? const Color(0xFF1E2029) :  Colors.white,
            child: SafeArea(
              child:  SizedBox(
                height: headMatchList.length  <= 1 ? 150.h :  headMatchList.length  <= 2 ? 250.h :  headMatchList.length  <= 3 ? 360.h : 500.h,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.w, right: 10.w,),
                      height: 35.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            child: ImageView(
                              'assets/images/icon/icon_arrowleft_nor.png',
                              width: 16.w,
                              height: 16.h,
                              color: Colors.grey,
                            ),
                          ),
                          InkWell(
                            onTap: onHeadMenu,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 180.w,
                                  child: Marquee(
                                    text: detailData?.tn ?? ' ',
                                    style: TextStyle(
                                      color: isDark ? Colors.white :Colors.black,
                                      fontSize: 16.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    velocity: 30.0,
                                    blankSpace: 10.w,
                                  ),
                                ),

                                Container(
                                  width: 5.w,
                                ),
                                ImageView(
                                  'assets/images/icon/t_down.png',
                                  width: 10.w,
                                  height: 10.h,
                                  color: isDark ? Colors.white : Colors.black,
                                )
                              ],
                            ),
                          ),

                          Container(width: 20.w,),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: headMatchList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            MatchEntity  matchItem = headMatchList[index];
                            return InkWell(
                              onTap: ()=> onHeadMatch(matchItem),
                              child: Container(
                                margin: EdgeInsets.all(10.h),
                                color: mid == matchItem.mid ?  isDark ? const Color(0xFF272931) :  const Color(0xFFe8f5ff) : null,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.h,bottom: 10.h),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                         mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          titleIndex == 1 ?
                                          ImageView(
                                            matchItem.mhlu[0] ?? '',
                                            width: 33.w,
                                            height: 33.h,
                                            dj: true,
                                          ):
                                          ImageView(
                                            ObjectUtil.isNotEmpty((matchItem.mhlu as List).safe(0)) ?
                                            (matchItem.mhlu as List).safe(0):
                                                'assets/images/home/home_team_logo.svg',
                                            cdn: true,
                                            width: 33.w,
                                            height: 33.h,
                                          ) ,
                                          Container(height: 10.w,),
                                          Container(
                                            width: 115.w,
                                            height: 30.h,
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              matchItem.mhn ?? '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: isDark ? Colors.white : const Color(0xFF303442),
                                                fontSize: 12.sp,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )

                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LocaleKeys.match_info_match_end.tr,
                                            style: TextStyle(
                                              color: isDark ? Colors.white : const Color(0xFF303442),
                                              fontSize: 12.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Container(height: 10.w,),
                                          Text(
                                            TYFormatScore.formatTotalScore(matchItem).text,
                                            style: TextStyle(
                                              color: isDark ? Colors.white : const Color(0xFF303442),
                                              fontSize: 22.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          titleIndex == 1 ?
                                          ImageView(
                                            matchItem.malu[0] ?? '',
                                            width: 33.w,
                                            height: 33.h,
                                            dj: true,
                                          ):
                                          ImageView(
                                            ObjectUtil.isNotEmpty((matchItem.malu as List).safe(0)) ?
                                            (matchItem.malu as List).safe(0) :
                                            'assets/images/home/home_team_logo.svg',
                                            cdn: true,
                                            width: 33.w,
                                            height: 33.h,
                                          ),
                                          Container(height: 10.w,),
                                          Container(
                                            width: 115.w,
                                            height: 30.h,
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              matchItem.man,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: isDark ? Colors.white : const Color(0xFF303442),
                                                fontSize: 12.sp,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )

                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )



                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: onHeadMenu,
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
