import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../widgets/image_view.dart';
import '../../../constant/detail_constant.dart';
import '../../../controllers/match_detail_controller.dart';

class AnimateFlexibleSpace extends StatelessWidget {
  const AnimateFlexibleSpace({super.key, this.tag});

  final String? tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
      tag: tag,
      id: matchLiveGetBuildId,
      builder: (controller) {
        MatchEntity? match = controller.detailState.match;
        // if(controller.detailState.liveLoading.value) return const CupertinoActivityIndicator().center;
        if (match == null) return Container();
        return Obx(() {
          return SizedBox(
            width: 1.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [

                /// 内容显示在appbar下
                // SizedBox(
                //   height: appbarHeight + Get.mediaQuery.padding.top,
                // ),
                AnimatedOpacity(
                  /// 顶部按钮控制
                  opacity: controller.detailState.videoTopShow.value ? 1.0 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
                    height: 50.h,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      gradient: LinearGradient(
                        begin: const Alignment(0, 1),
                        end: const Alignment(0.00, -1.00),
                        colors: [Colors.black.withOpacity(0), Colors.black],
                      ),
                    ),
                  ),
                ),

                AnimatedOpacity(

                  /// 顶部按钮控制
                  opacity: controller.detailState.videoTopShow.value ? 1.0 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    height: 40.h,
                    padding:
                    EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: const Alignment(0.00, -1.00),
                        end: const Alignment(0, 1),
                        colors: [Colors.black.withOpacity(0), Colors.black],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (match.mms > 1 || match.pmms == 1)
                              InkWell(
                                onTap: () {
                                  controller.changeVideoTopShow(true);
                                  controller.loadVideo(match);
                                },
                                child: Row(
                                  children: [
                                    ImageView(
                                      'assets/images/detail/live-app.svg',
                                      width: 24.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      LocaleKeys.match_info_video.tr,
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
                              ).marginOnly(right: 8.w),

                            /// 动画
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.changeVideoTopShow(true);
                                    controller.loadAnimation(match);
                                  },
                                  child: Row(
                                    children: [
                                      ImageView(
                                        'assets/images/detail/animate-active.svg',
                                        width: 24.w,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        LocaleKeys.match_info_animation.tr,
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
                              ],
                            ),
                          ],
                        ),

                        /// 全屏、声音等按钮
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.changeVideoTopShow(true);
                                controller
                                    .detailState.isOpenVideoInfo.value =
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
                            // ImageView(
                            //   'assets/images/detail/sound.svg',
                            //   width: 24.w,
                            // ),
                            // SizedBox(
                            //   width: 8.w,
                            // ),
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
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
