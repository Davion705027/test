import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../widgets/ball_tab_bar_widget.dart';
import '../widgets/handicap_widget.dart';
import 'handicap_strategy_controller.dart';

class HandicapStrategyPage extends StatefulWidget {
  const HandicapStrategyPage({Key? key}) : super(key: key);

  @override
  State<HandicapStrategyPage> createState() => _HandicapStrategyPageState();
}

class _HandicapStrategyPageState extends State<HandicapStrategyPage> {
  final controller = Get.find<HandicapStrategyController>();
  final logic = Get.find<HandicapStrategyController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HandicapStrategyController>(
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
                          return HandicapWidget(
                            isDark: context.isDarkMode,
                            index: index,
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
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: TabBar(
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
    );
  }

  @override
  void dispose() {
    Get.delete<HandicapStrategyController>();
    super.dispose();
  }
}
