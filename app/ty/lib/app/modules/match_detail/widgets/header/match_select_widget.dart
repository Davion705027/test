import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../constant/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import 'match_select_appbar.dart';
import 'match_select_item.dart';

/// 头部联赛选择组件
class MatchSelectWidget extends StatefulWidget {
  const MatchSelectWidget({super.key, this.tag});

  final String? tag;

  @override
  State<MatchSelectWidget> createState() => _MatchSelectWidgetState();
}

class _MatchSelectWidgetState extends State<MatchSelectWidget> {
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<MatchDetailController>(tag: widget.tag)
            .detailState
            .isMatchSelectExpand
            .value = false;
        Get.back();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                color: Get.theme.matchSelectBackgroundColor,
                // padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
                child: SafeArea(
                  bottom: false,
                  child: MatchSelectAppbar(
                    tag: widget.tag,
                  ),
                )),
            GetBuilder<MatchDetailController>(
                tag: widget.tag,
                id: matchSelectGetBuildId,
                initState: (_) {
                  MatchDetailController controller =
                      Get.find<MatchDetailController>(tag: widget.tag);

                  /// 下拉联赛获取数据
                  controller.fetchMatchListData();
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    controller.detailState.isMatchSelectExpand.value = true;
                  });
                  // 定时5秒请求
                  timer?.cancel();
                  timer =
                      Timer.periodic(const Duration(seconds: 5), (Timer timer) {
                    if (mounted &&
                        controller.detailState.isMatchSelectExpand.value) {
                      /// 下拉联赛获取数据
                      controller.fetchMatchListData();
                    }
                  });
                },
                builder: (controller) {
                  return Container(
                    /// 最小高度单个item的高度
                    constraints:
                        BoxConstraints(maxHeight: 520.h, minHeight: 100.h),
                    color: Get.theme.matchSelectBackgroundColor,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      scrollDirection: Axis.vertical,
                      itemCount: controller.detailState.matchListData.length,
                      shrinkWrap: true,
                      //列表项构造器
                      itemBuilder: (BuildContext context, int index) {
                        /// 赛事阶段
                        return MatchSelectItem(
                          match:
                              controller.detailState.matchListData[index],
                          index: index,
                          controller: controller,
                        );
                      },
                      //分割器构造器
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Get.theme.betPanelUnderlineColor,
                          height: 0.5,
                        );
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
