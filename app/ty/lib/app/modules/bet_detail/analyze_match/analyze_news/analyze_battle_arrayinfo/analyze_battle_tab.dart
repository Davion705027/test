import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_battle_array/analyze_battle_array_logic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../config/theme/app_color.dart';

/**
 * @author[xiongwei]
 * @version[创建日期，2024/2/28 15:32]
 * @function[功能简介 ]
 **/
class AnalyzeDataTab extends StatefulWidget {
  const AnalyzeDataTab({Key? key}) : super(key: key);

  @override
  State<AnalyzeDataTab> createState() => _MSTabbarDemo1State();
}

class _MSTabbarDemo1State extends State<AnalyzeDataTab> {
  List<String> _tabs = ["", ""];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeBattleArrayLogic>(
        id: "tabListChange",
        builder: (controller) {
          _tabs = controller.state.teamsNames.value;
          return Container(
            height: 40.w,
            color: AppColor.colorWhite,
            padding: const EdgeInsets.only(top: 8),
            child: TabBar(
              controller: controller.tabController,
              padding: EdgeInsets.zero,
              labelPadding: const EdgeInsets.only(bottom: 6),
              labelColor: '#179CFF'.hexColor,
              labelStyle: const TextStyle(
                fontSize: 12,
                height: 16 / 12,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelColor: '#7981A4'.hexColor,
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                height: 16 / 12,
              ),
              indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(
                  width: 2,
                  color: '#179CFF'.hexColor,
                ),
              ),
              tabs: _tabs.map((e) {
                return Tab(
                  text: e,
                );
              }).toList(),
            ),
          );
        });
  }
}
