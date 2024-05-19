import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/webview_extension.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../global/user_controller.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../widgets/image_view.dart';
import '../../../constant/detail_constant.dart';
import '../../../controllers/match_detail_controller.dart';

class LiveFlexibleSpace extends StatelessWidget {
  const LiveFlexibleSpace({super.key, this.tag});

  final String? tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
      tag: tag,
      id: matchLiveGetBuildId,
      builder: (controller) {
        MatchEntity? match = controller.detailState.match;
        if (match == null) return Container();
        return SizedBox(
          width: 1.sw,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 内容显示在appbar下
              // SizedBox(
              //   height: appbarHeight + Get.mediaQuery.padding.top,
              // ),

              Obx(() {
                return AnimatedOpacity(
                  /// 顶部按钮控制
                  opacity: controller.detailState.videoTopShow.value ? 1.0 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// 视频、动画
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.changeVideoTopShow(true);
                                controller.loadVideo(match);
                              },
                              child: Row(
                                children: [
                                  ImageView(
                                    'assets/images/detail/live-active.svg',
                                    width: 24.w,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    LocaleKeys.match_info_video.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF179CFF),
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            if (match.mvs > -1 &&
                                UserController.to.userInfo.value?.ommv != 0)
                              InkWell(
                                onTap: () {
                                  controller.changeVideoTopShow(true);
                                  controller.loadAnimation(match);
                                },
                                child: Row(
                                  children: [
                                    ImageView(
                                      'assets/images/detail/animate.svg',
                                      width: 24.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      LocaleKeys.match_info_animation.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 12.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),

                        /// 全屏、声音等按钮
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.changeVideoTopShow(true);
                                controller.detailState.isOpenVideoInfo.value =
                                    !controller.detailState.isOpenVideoInfo.value;
                              },
                              child: ImageView(
                                controller.detailState.isOpenVideoInfo.value
                                    ? 'assets/images/detail/info-active.svg'
                                    : 'assets/images/detail/info.svg',
                                width: 24.w,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            if (!controller.detailState.isDJDetail)
                              GestureDetector(
                                onTap: () {
                                  controller.changeVideoTopShow(true);
                                  controller.switchVideoVolume();
                                },
                                child: ImageView(
                                  controller.detailState.liveMuted.value
                                      ? 'assets/images/detail/mute.svg'
                                      : 'assets/images/detail/sound.svg',
                                  width: 24.w,
                                ),
                              ).marginOnly(right: 8.w),
                            InkWell(
                              onTap: () {
                                controller.fullscreen(true);
                              },
                              child: SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: ImageView(
                                  'assets/images/detail/full-screen.svg',
                                  width: 24.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
