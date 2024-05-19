import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/match_stage.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/show_start_time.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import '../../../../services/models/res/match_entity.dart';
import '../../../../utils/format_score_util.dart';
import '../../../../widgets/image_view.dart';
import '../../controllers/match_detail_controller.dart';

/// 下拉赛事选择项 tag对应不同的注入
class MatchSelectItem extends StatelessWidget {
  const MatchSelectItem(
      {super.key,
      required this.match,
      required this.index,
      required this.controller});

  final MatchEntity match;
  final int index;
  final MatchDetailController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.selectChangeMatch(match.mid);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: match.mid == controller.detailState.mId
              ? Get.theme.matchSelectedBgColor
              : Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        constraints: BoxConstraints(maxHeight: 110.h, minHeight: 100.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 121.5.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 队徽 type 0表示主队 mhlu主队的url
                      // 双打情况
                      match.mhlu.length > 1
                          ? SizedBox(
                              width: 74.w,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: 44.w,
                                      height: 44.w,
                                      alignment: Alignment.center,
                                      child: ImageView(
                                        ObjectUtil.isNotEmpty(
                                                (match.mhlu as List).safeFirst)
                                            ? (match.mhlu as List).safeFirst
                                            : 'assets/images/home/home_team_logo.svg',
                                        width: 40.w,
                                        height: 40.w,
                                        cdn: true,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 30.w,
                                    child: Container(
                                      width: 44.w,
                                      height: 44.w,
                                      alignment: Alignment.center,
                                      child: ImageView(
                                        ObjectUtil.isNotEmpty(
                                                (match.mhlu as List).safe(1))
                                            ? (match.mhlu as List).safe(1)
                                            : 'assets/images/home/home_team_logo.svg',
                                        width: 40.w,
                                        height: 40.w,
                                        cdn: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : // 单打
                          Container(
                              width: 44.w,
                              height: 44.w,
                              alignment: Alignment.center,
                              child: controller.detailState.isDJDetail
                                  ? ImageView(
                                      (match.mhlu as List).safe(0),
                                      width: 40.w,
                                      height: 40.w,
                                      dj: true,
                                    )
                                  : ImageView(
                                      ObjectUtil.isNotEmpty(
                                              (match.mhlu as List).safe(0))
                                          ? (match.mhlu as List).safe(0)
                                          : 'assets/images/home/home_team_logo.svg',
                                      width: 40.w,
                                      height: 40.w,
                                      cdn: true,
                                      // cdn: true,
                                    ),
                            ),

                      SizedBox(height: 4.h),
                      Container(
                        alignment: Alignment.center,
                        width: 100.w,
                        child: Text(
                          controller.getTeamName(type: 1, match: match),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: !Get.isDarkMode
                                ? Get.theme.matchSelectTitleColor
                                : Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 121.5.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 双打情况
                      match.malu.length > 1
                          ? SizedBox(
                              width: 74.w,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: 44.w,
                                      height: 44.w,
                                      alignment: Alignment.center,
                                      child: ImageView(
                                        ObjectUtil.isNotEmpty(
                                                (match.malu as List).safe(0))
                                            ? (match.malu as List).safe(0)
                                            : 'assets/images/home/home_team_logo.svg',
                                        width: 40.w,
                                        height: 40.w,
                                        cdn: true,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 30.w,
                                    child: Container(
                                      width: 44.w,
                                      height: 44.w,
                                      alignment: Alignment.center,
                                      child: ImageView(
                                        ObjectUtil.isNotEmpty(
                                                (match.malu as List).safe(1))
                                            ? (match.malu as List).safe(1)
                                            : 'assets/images/home/home_team_logo.svg',
                                        width: 40.w,
                                        height: 40.w,
                                        cdn: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : // 单打
                          Container(
                              width: 44.w,
                              height: 44.w,
                              alignment: Alignment.center,
                              child: controller.detailState.isDJDetail
                                  ? ImageView(
                                      (match.malu as List).safe(0),
                                      width: 40.w,
                                      height: 40.w,
                                      dj: true,
                                    )
                                  : ImageView(
                                      ObjectUtil.isNotEmpty(
                                              (match.malu as List).safe(0))
                                          ? (match.malu as List).safe(0)
                                          : 'assets/images/home/home_team_logo.svg',
                                      width: 40.w,
                                      height: 40.w,
                                      cdn: true,
                                      // cdn: true,
                                    ),
                            ),
                      SizedBox(height: 4.h),
                      Container(
                        alignment: Alignment.center,
                        width: 100.w,
                        child: Text(
                          controller.getTeamName(type: 2, match: match),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: !Get.isDarkMode
                                ? Get.theme.matchSelectTitleColor
                                : Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 展示赛事阶段，开赛时间以及倒计时等
                /// 赛事阶段展示
                MatchStage(
                  match: match,
                  isMatchSelect: true,
                ),

                /// 时间展示、比分、即将开赛时间
                SizedBox(height: 2.h),
                if (match.ms == 0)
                  ShowStartTime(
                    match: match,
                    isPinnedAppbar: false,
                    isMatchSelect: true,
                  ),
                if ([1, 2, 3, 4].contains(match.ms))
                  AutoSizeText(
                    controller.eSportsScoring(match)
                        ? LocaleKeys.mmp_eports_scoring.tr
                        : "${FormatScore.formatTotalScore(match, 0)} - ${FormatScore.formatTotalScore(match, 1)}",
                    maxLines: 1,
                    style: TextStyle(
                      color: !Get.isDarkMode
                          ? Get.theme.matchSelectTitleColor
                          : Colors.white,
                      fontSize: 32.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
