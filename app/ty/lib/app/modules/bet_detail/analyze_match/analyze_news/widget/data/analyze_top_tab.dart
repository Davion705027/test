import 'package:flutter/widgets.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../../login/login_head_import.dart';
import '../../../../../match_detail/controllers/analyze_tab_controller.dart';
import '../../amalyze_match_data/analyze_match_data_logic.dart';

/**
 * @author[xiongwei]
 * @version[创建日期，2024/2/28 15:32]
 * @function[功能简介 ]
 **/
typedef AnalyzeTopTabbarListener = Function(int page);

class AnalyzeTopTabbar extends StatelessWidget {
  AnalyzeTopTabbarListener analyzeTabbarListener;
  double? widgetWidth = 200.w;
  AnalyzeTopTabbar(this.analyzeTabbarListener,
      {Key? key, this.widgetWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeTabController>(
        id: "tableListTitle",
        builder: (controller) {
          return controller.result.isEmpty?SizedBox():
          Container(
            height: 44.w,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            // decoration: BoxDecoration(
            //   color: detailState.fullscreen.value
            //       ? Colors.transparent
            //       : Get.theme.secondTabPanelBackgroundColor,
            // ),
            decoration: BoxDecoration(
                color:  Get.theme.secondTabPanelBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(8.w))),
            child:SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(

                children:[TabBar(
                  tabAlignment:TabAlignment.center,
                  controller: controller.tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding:  EdgeInsets.symmetric(horizontal:2.w,vertical: 6.w),
                  indicator: BoxDecoration(
                      color:Get.theme.secondTabPanelSelectedColor,
                      borderRadius: BorderRadius.all(Radius.circular(50.w))
                  ),
                  labelPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.w),
                  labelColor: Get.theme.tabIndicatorColor,
                  labelStyle: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                  unselectedLabelColor: Get.theme.secondTabPanelUnSelectedFontColor,
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),

                  onTap: (index) {
                    analyzeTabbarListener(index);

                  },
                  tabs: controller.categoryList.map((e) {
                    return Tab(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        height: 25.w,
                        child: Text(e,maxLines: 1,overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color:controller.tabController.index==controller.categoryList.indexOf(e)
                                  ? Get.theme.tabIndicatorColor
                                : Get.theme.secondTabPanelUnSelectedFontColor,
                              fontSize: 12.sp,
                              fontWeight:controller.tabController.index==controller.categoryList.indexOf(e)? FontWeight.w600 : FontWeight.w400),),
                      ),
                    );
                  }).toList(),
                )],
              ),
            ),
          );
        });
  }
}
