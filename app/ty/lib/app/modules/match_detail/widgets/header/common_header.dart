import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import '../../models/header_type_enum.dart';
import 'flexible/animate.dart';
import 'flexible/common.dart';
import 'flexible/live.dart';
import 'header_appbar.dart';

/// 详情头部组件 包含title 对决信息 比分 等
class CommonHeader extends StatelessWidget {
  const CommonHeader({super.key, required this.controller, this.tag});

  final MatchDetailController controller;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    double fixedHeaderHeight =
        controller.detailState.headerType.value == HeaderType.animate
            ? controller.detailState.animateHeaderHeight.value
            : headerHeight;
    return SliverAppBar(
      /// 头部置顶、滚动悬浮条、返回按钮
      title: HeaderAppbar(
        tag: tag,
      ),
      titleSpacing: 0,

      ///导航中间对齐
      centerTitle: true,

      /// 去掉自带返回按钮
      automaticallyImplyLeading: false,

      ///悬停的标志
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: fixedHeaderHeight - Get.mediaQuery.padding.top,

      /// 自定义appbar高度
      toolbarHeight: appbarHeight,
      flexibleSpace: FlexibleSpaceBar(
        // 不随滚动
        collapseMode: CollapseMode.none,
        background: _flexibleWidget(fixedHeaderHeight),
      ),
    );
  }

  Widget _flexibleWidget(double fixedHeaderHeight) {
    return Obx(() {
      final detailState = controller.detailState;
      return Stack(
        children: [
          Visibility(
            visible: detailState.headerType.value == HeaderType.normal,
            maintainState: true,
            maintainAnimation: true,
            child: CommonFlexibleSpace(
              tag: tag,
            ),
          ),
          if (detailState.headerType.value == HeaderType.live)
            Positioned(
              bottom: 0,
              child: LiveFlexibleSpace(
                tag: tag,
              ),
            ),

          // 动画
          if (detailState.headerType.value == HeaderType.animate)
            Positioned(
              top: 0,
              height: fixedHeaderHeight,
              child: AnimateFlexibleSpace(
                tag: tag,
              ),
            ),

          // 精彩回放
          if (detailState.headerType.value == HeaderType.replay) Container(),
        ],
      );
    });
  }
}
