import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../../generated/locales.g.dart';
import '../../controllers/match_detail_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 详情tab组件
class MainTabWidget extends StatelessWidget {
  const MainTabWidget({super.key, required this.controller, this.tag});

  final MatchDetailController controller;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 85.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 投注/赛事分析 切换tab
          if (controller.showMatchAnalysisTab())
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Get.theme.tabPanelBackgroundColor,
                  // boxShadow: [
                  //   // 底部阴影
                  //   BoxShadow(
                  //       color: Get.theme.tabPanelBoxShadowColor,
                  //       blurRadius: 8,
                  //       offset: const Offset(0, 2),
                  //       spreadRadius: 0,
                  //       blurStyle: BlurStyle.outer),
                  // ],
                ),
                child: TabBar(
                  // padding: EdgeInsets.symmetric(horizontal: 0),
                  controller: controller.tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: const EdgeInsets.only(bottom: 7),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 4,
                      color: Get.theme.tabIndicatorColor,
                    ),
                  ),
                  labelColor: Get.theme.tabPanelSelectedColor,
                  labelStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                  unselectedLabelColor: Get.theme.tabPanelUnSelectedColor,
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400,),
                  tabs: <Widget>[
                    Tab(child: Text( LocaleKeys.app_betting.tr.toUpperCase(), overflow: TextOverflow.ellipsis),),
                    Tab(child: Text( LocaleKeys.app_match_analysis.tr.toUpperCase(), overflow: TextOverflow.ellipsis),),
                  ],
                ),
              ),
            ),
          // if (Get.isDarkMode)
          //   Container(
          //     height: 1,
          //     decoration: BoxDecoration(
          //       color: Colors.white.withOpacity(0.04),
          //       boxShadow: [
          //         // 底部阴影
          //         BoxShadow(
          //             color: Colors.black.withOpacity(0.3),
          //             blurRadius: 2,
          //             offset: const Offset(0, 2),
          //             spreadRadius: 0,
          //             blurStyle: BlurStyle.outer),
          //       ],
          //     ),
          //   ),
        ],
      ),
    );
  }
}
