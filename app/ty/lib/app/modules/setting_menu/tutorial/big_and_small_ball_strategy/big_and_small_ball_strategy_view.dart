import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../widgets/image_view.dart';
import '../widgets/ball_tab_bar_widget.dart';
import '../widgets/bigAndSmallBall_widget.dart';
import '../widgets/handicap_widget.dart';
import 'big_and_small_ball_strategy_controller.dart';

class BigAndSmallBallStrategyPage extends StatefulWidget {
  const BigAndSmallBallStrategyPage({Key? key}) : super(key: key);

  @override
  State<BigAndSmallBallStrategyPage> createState() =>
      _BigAndSmallBallStrategyPageState();
}

class _BigAndSmallBallStrategyPageState
    extends State<BigAndSmallBallStrategyPage> {
  final controller = Get.find<BigAndSmallBallStrategyController>();
  final logic = Get.find<BigAndSmallBallStrategyController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BigAndSmallBallStrategyController>(
      builder: (controller) {
        return Container(
          margin: EdgeInsets.only(top: 20.h),
          child: Column(
            children: [
              _title(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: ListViewObserver(
                    controller: controller.listObserverController,
                    child: ListView.builder(
                        controller: controller.autoScrollController,
                        padding: EdgeInsets.zero,
                        itemCount: controller.tabList.length,
                        shrinkWrap: false,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _bigAndSmallBallStrategy(
                            context.isDarkMode,
                            index,
                          );
                        }),
                    onObserve: (resultModel) =>
                        controller.onObserves(resultModel.firstChild?.index),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  //头部
  Widget _title() {
    return Column(
      children: [
        TabBar(
          indicatorColor: Colors.transparent,
          indicator: const BoxDecoration(),
          isScrollable: true,
          dividerHeight: 0,
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          labelPadding: EdgeInsets.zero,
          controller: controller.tabController,
          onTap: (index) => controller.changeIndex(index),
          tabs: List<BallTabBarWidget>.generate(controller.tabList.length,
              (index) {
            return BallTabBarWidget(
              title: controller.tabList[index],
              isSelected: controller.currentIndex == index ? true : false,
              isDark: context.isDarkMode,
            );
          }).toList(),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 35.w, right: 35.w, top: 10.h),
          child: Text(
            LocaleKeys.app_h5_handicap_tutorial_big_small_ball_tip.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.isDarkMode
                  ? const Color.fromRGBO(255, 255, 255, 0.5)
                  : const Color(0xFF8D8D8D),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  Widget _bigAndSmallBallStrategy(bool isDark, int index) {
    if (index == 0) {
      return BigAndSmallBallWidget(
        isDark: context.isDarkMode,
        title:
            LocaleKeys.app_h5_handicap_tutorial_ball.tr.replaceAll('%s', '2.5'),
        subTitle: LocaleKeys.app_h5_handicap_tutorial_note_14.tr,
        lTitle:
            LocaleKeys.app_h5_handicap_tutorial_big.tr.replaceAll('%s', '2.5'),
        lSubTitle: LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
        lSubTitleColor: const Color(0x19F53F3F),
        lSubTitleTextColor: const Color(0xFFF53F3F),
        cTitle: '3',
        cSubTitle: LocaleKeys.app_h5_handicap_tutorial_enter_ball.tr,
        rTitle: LocaleKeys.app_h5_handicap_tutorial_small.tr
            .replaceAll('%s', '2.5'),
        rSubTitle: LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
        rSubTitleColor: const Color(0x1900B42A),
        rSubTitleTextColor: const Color(0xFF00B42A),
      );
    } else if (index == 1) {
      return BigAndSmallBallWidget(
        isDark: context.isDarkMode,
        title: LocaleKeys.app_h5_handicap_tutorial_ball.tr
            .replaceAll('%s', '2.5/3'),
        subTitle: LocaleKeys.app_h5_handicap_tutorial_note_15.tr,
        lTitle: LocaleKeys.app_h5_handicap_tutorial_big.tr
            .replaceAll('%s', '2.5/3'),
        lSubTitle: LocaleKeys.app_h5_handicap_tutorial_win_half.tr,
        lSubTitleColor: const Color(0x19F53F3F),
        lSubTitleTextColor: const Color(0xFFF53F3F),
        cTitle: '3',
        cSubTitle: LocaleKeys.app_h5_handicap_tutorial_enter_ball.tr,
        rTitle: LocaleKeys.app_h5_handicap_tutorial_small.tr
            .replaceAll('%s', '2.5/3'),
        rSubTitle: LocaleKeys.app_h5_handicap_tutorial_lose_half.tr,
        rSubTitleColor: const Color(0x1900B42A),
        rSubTitleTextColor: const Color(0xFF00B42A),
      );
    } else if (index == 2) {
      return BigAndSmallBallWidget(
        isDark: context.isDarkMode,
        title:
            LocaleKeys.app_h5_handicap_tutorial_ball.tr.replaceAll('%s', '3'),
        subTitle: LocaleKeys.app_h5_handicap_tutorial_note_17.tr,
        lTitle:
            LocaleKeys.app_h5_handicap_tutorial_big.tr.replaceAll('%s', '3'),
        lSubTitle: LocaleKeys.app_h5_handicap_tutorial_return_principal.tr,
        lSubTitleColor: const Color(0x19AFAFAF),
        lSubTitleTextColor: const Color(0xFFAFAFAF),
        cTitle: '3',
        cSubTitle:
            LocaleKeys.app_h5_handicap_tutorial_handicapData_condition_1.tr,
        rTitle:
            LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '3'),
        rSubTitle: LocaleKeys.app_h5_handicap_tutorial_return_principal.tr,
        rSubTitleColor: const Color(0x19AFAFAF),
        rSubTitleTextColor: const Color(0xFFAFAFAF),
      );
    } else if (index == 3) {
      return Column(
        children: [
          BigAndSmallBallWidget(
            isDark: context.isDarkMode,
            title: LocaleKeys.app_h5_handicap_tutorial_ball.tr
                .replaceAll('%s', '3/3.5'),
            subTitle: LocaleKeys.app_h5_handicap_tutorial_note_16.tr,
            lTitle: LocaleKeys.app_h5_handicap_tutorial_big.tr
                .replaceAll('%s', '3/3.5'),
            lSubTitle: LocaleKeys.app_h5_handicap_tutorial_win_half.tr,
            lSubTitleColor: const Color(0x1900B42A),
            lSubTitleTextColor: const Color(0xFF00B42A),
            cTitle: '3',
            cSubTitle: LocaleKeys.app_h5_handicap_tutorial_enter_ball.tr,
            rTitle: LocaleKeys.app_h5_handicap_tutorial_small.tr
                .replaceAll('%s', '3/3.5'),
            rSubTitle: LocaleKeys.app_h5_handicap_tutorial_lose_half.tr,
            rSubTitleColor: const Color(0x19F53F3F),
            rSubTitleTextColor: const Color(0xFFF53F3F),
          ),
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              height: 44.h,
              width: 240.w,
              margin: EdgeInsets.only(top: 40.h),
              decoration: context.isDarkMode
                  ? ShapeDecoration(
                      color: Colors.white.withOpacity(0.07999999821186066),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.white.withOpacity(0.11999999731779099),
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    )
                  : ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.app_h5_handicap_tutorial_actual_combat.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => controller.onSimulationTraining(),
            child: Container(
              height: 22.h,
              margin: EdgeInsets.only(top: 23.h,bottom: 400.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.app_h5_handicap_tutorial_practise.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white
                          : const Color(0xFF333333),
                      fontSize: 16.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  ImageView(
                    context.isDarkMode
                        ? 'assets/images/icon/icon_arrow_dark.png'
                        : 'assets/images/icon/icon_arrow_light.png',
                    width: 15.w,
                    height: 15.w,
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Container();
  }

  @override
  void dispose() {
    Get.delete<BigAndSmallBallStrategyController>();
    super.dispose();
  }
}
