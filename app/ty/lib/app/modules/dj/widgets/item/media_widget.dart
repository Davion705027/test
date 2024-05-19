import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../widgets/image_view.dart';

class MediaWidget extends StatelessWidget {
  final MatchEntity matchEntity;
  const MediaWidget({super.key,required this.matchEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18.w,
      child: Row(
        children: [
          // 正常的 优先级 ： lvs 直播   muUrl 视频  animationUrl 动画
          if (UserController.to.userInfo.value?.ommv == 1)
            matchEntity.mvs > -1
                ? ImageView(
              'assets/images/sport/ico_footerball.svg',
              width: 18.w,
              height: 18.w,
            ).marginOnly(right: 4.w)
                : ColorFiltered(
              colorFilter:
              const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              child: ImageView(
                'assets/images/sport/ico_footerball.svg',
                width: 18.w,
                height: 18.w,
              ).marginOnly(right: 4.w),
            ),

          ///  muUrl  视频
          (matchEntity.mms > 1 && [1, 2, 7, 10, 110].contains(matchEntity.ms))
              ? ImageView(
            'assets/images/sport/ico_video.svg',
            width: 18.w,
            height: 18.w,
          ).marginOnly(right: 4.w)
              : ColorFiltered(
            colorFilter:
            const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            child: ImageView(
              'assets/images/sport/ico_video.svg',
              width: 18.w,
              height: 18.w,
            ).marginOnly(right: 4.w),
          ),

          // ImageView(
          //   'assets/images/sport/ico_footerball.svg',
          //   width: 18.w,
          //   height: 18.w,
          //   svgColor:Colors.grey
          // ).marginOnly(right: 4.w),
          // ImageView(
          //   'assets/images/sport/ico_video.svg',
          //   width: 18.w,
          //   height: 18.w,
          //   svgColor: matchEntity.mms<=0?Colors.grey:null,
          // ).marginOnly(right: 4.w),

        ],
      ),
    );
  }
}
