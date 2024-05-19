import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../utils/oss_util.dart';
import 'big_and_small_ball_strategy/big_and_small_ball_strategy_view.dart';
import 'handicap_strategy/handicap_strategy_view.dart';
import 'tutorial_controller.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final controller = Get.find<TutorialController>();
  final logic = Get.find<TutorialController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TutorialController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            decoration: context.isDarkMode
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        OssUtil.getServerPath(
                          'assets/images/icon/tutorial_background_darks.png',
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  )
                : const BoxDecoration(
                    color: Color(0xFFF2F2F6),
                  ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  //头部
                  _title(),
                  Expanded(
                    child: controller.tutorial == 0
                        ? const HandicapStrategyPage()
                        : const BigAndSmallBallStrategyPage(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //头部
  Widget _title() {
    return SizedBox(
      height: 48.h,
      child: Container(
        margin: EdgeInsets.only(left: 14.w, right: 14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20.w,
                color:
                    context.isDarkMode ? Colors.white : const Color(0xFF303442),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => controller.onTutorial(0),
                  child: SizedBox(
                    width: 130.w,
                    child: AutoSizeText(
                      LocaleKeys.footer_menu_rangqiu.tr +
                          LocaleKeys.app_h5_handicap_tutorial_introdution.tr,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        color: context.isDarkMode
                            ? controller.tutorial == 0
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Colors.white.withOpacity(0.5)
                            : controller.tutorial == 0
                                ? const Color(0xFF333333)
                                : const Color(0xFF8D8D8D),
                        fontSize: controller.tutorial == 0 ? 18.sp : 16.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => controller.onTutorial(1),
                  child: SizedBox(
                    width: 130.w,
                    child: AutoSizeText(
                      LocaleKeys.app_h5_handicap_tutorial_big_small_ball.tr +
                          LocaleKeys.app_h5_handicap_tutorial_introdution.tr,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        color: context.isDarkMode
                            ? controller.tutorial == 1
                                ? Colors.white.withOpacity(0.8999999761581421)
                                : Colors.white.withOpacity(0.5)
                            : controller.tutorial == 1
                                ? const Color(0xFF333333)
                                : const Color(0xFF8D8D8D),
                        fontSize: controller.tutorial == 1 ? 18.sp : 16.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<TutorialController>();
    super.dispose();
  }
}
