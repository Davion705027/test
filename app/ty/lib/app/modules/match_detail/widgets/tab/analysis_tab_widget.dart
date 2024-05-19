import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../controllers/analyze_tab_controller.dart';

import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../routes/app_pages.dart';
import '../../../../services/models/res/category_list_entity.dart';
import '../../../../widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import 'second_tab_item.dart';

/// 玩法集tab 第一个玩法集固定 不随滚动 以及 折叠全部打开关闭按钮
class AnalysisTab extends StatelessWidget {
  AnalysisTab({super.key, this.tag});

  final String? tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeTabController>(
      id: "tableList",

      builder: (controller) {
        return Container(
          height: 44.h,
          decoration: BoxDecoration(
            color: Get.theme.secondTabPanelBackgroundColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child:  controller.getBodyLength()==0?const SizedBox():ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.getBodyLength(),
                  itemBuilder: (BuildContext context, int index) {
                    // 从第二项开始
                    int tempIndex = index;
                    return SecondTabItem(
                      controller.categoryList[tempIndex],
                      onTap: () {
                        controller.changeCategoryTab(index);
                      },
                      active:
                          index == controller.analyzeTabState.curMainTab.value,
                    ).marginOnly(left: 2.w);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
