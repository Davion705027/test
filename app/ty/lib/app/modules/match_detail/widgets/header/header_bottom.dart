import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/match_detail_score.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../global/user_controller.dart';
import '../../../../widgets/image_view.dart';
import '../../controllers/match_detail_controller.dart';

/// 详情页视频区域(视频+动画按钮)+底部(赛事比分或者是足球犯规显示)
class HeaderBottom extends StatelessWidget {
  const HeaderBottom(
      {super.key, required this.match, required this.controller});

  final MatchEntity match;
  final MatchDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      height: 60.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 29.h,
            child: _buildWidget(match),
          ),

          // ms,赛事状态：0未开赛，1进行中，2暂停，3结束，4关闭; (mcg栏目类型：| mcg =1 滚球 | mcg=2 即将开赛| mcg=3 今日赛事| mcg=4 早盘)
          if ([1, 2, 3, 4].contains(match.ms) || match.mo == 1)
            MatchDetailScore(
              match: match,
            )
        ],
      ),
    );
  }

  _buildWidget(MatchEntity match) {
    /// 动画 + 视频按钮 显示逻辑
    /// <!-- mvs状态：-1：没有配置源 | 0 ：已配置，但是不可用 | 1：已配置，可用，播放中 | 2：已配置，可用，播放中 -->
    if (match.mvs > -1 ||
        (match.mms > 1 && [1, 2, 7, 10, 110].contains(match.ms))) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (match.mms > 1 || match.pmms == 1)
            InkWell(
              onTap: () => controller.loadVideo(match),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w),
                decoration: ShapeDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageView(
                      'assets/images/detail/live-app.svg',
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    AutoSizeText(
                      LocaleKeys.match_info_video_live.tr,
                      textAlign: TextAlign.center,
                      minFontSize: 6,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
          SizedBox(
            width: 4.w,
          ),
          if (match.mvs > -1 && UserController.to.userInfo.value?.ommv != 0)
            InkWell(
              onTap: () => controller.loadAnimation(match),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w),
                decoration: ShapeDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageView(
                      'assets/images/detail/animate-app2.svg',
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    AutoSizeText(
                      LocaleKeys.match_info_animation_live.tr,
                      textAlign: TextAlign.center,
                      minFontSize: 6,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      );
    } else {
      return Container();
    }
  }
}
