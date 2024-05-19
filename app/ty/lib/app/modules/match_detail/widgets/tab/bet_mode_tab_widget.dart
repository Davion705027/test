import 'dart:math';

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
import '../../models/request_status.dart';
import 'second_tab_item.dart';

/// 玩法集tab 第一个玩法集固定 不随滚动 以及 折叠全部打开关闭按钮
class BetModeTab extends StatefulWidget {
  const BetModeTab({super.key, this.tag, this.fullscreen = false});

  final String? tag;
  final bool fullscreen;

  @override
  State<BetModeTab> createState() => _BetModeTabState();
}

class _BetModeTabState extends State<BetModeTab> {
  final ScrollController _controller = ScrollController();
  final GlobalKey _listKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
      tag: widget.tag,
      id: matchBetModeTabGetBuildId,
      builder: (controller) {
        final detailState = controller.detailState;
        // 投注列表数据有则显示
        if (detailState.oddsInfoIsNoData ||
            detailState.oddsInfoRequestStatus == RequestStatus.loading) {
          return Container();
        }
        List<CategoryListData> categoryList = detailState.categoryList;
        return Stack(
          children: [
            Container(
              height: widget.fullscreen ? 43 : 44.h,
              decoration: BoxDecoration(
                color: widget.fullscreen
                    ? Colors.transparent
                    : Get.theme.secondTabPanelBackgroundColor,
              ),
              padding: widget.fullscreen
                  ? const EdgeInsets.symmetric(vertical: 8)
                  : EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 第一个玩法集不随滚动
                  SecondTabItem(
                    fullscreen: widget.fullscreen,
                    categoryList[0].marketName,
                    active: detailState.curCategoryTabId == categoryList[0].id,
                    onTap: () {
                      controller.changeCategoryTab(categoryList[0].id);
                    },
                  ),
                  categoryList.length > 1
                      ? Expanded(
                          child: ListView.builder(
                            key: _listKey,
                            controller: _controller,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryList.length - 1,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (BuildContext buildContext, int index) {
                              // 从第二项开始
                              int tempIndex = index + 1;
                              return SecondTabItem(
                                fullscreen: widget.fullscreen,
                                categoryList[tempIndex].marketName,
                                onTap: () {
                                  controller.changeCategoryTab(
                                      categoryList[tempIndex].id);
                                },
                                active: detailState.curCategoryTabId ==
                                    categoryList[tempIndex].id,
                                centerBack: (Point<num> center) {
                                  // 获取ListView在屏幕上的位置和大小
                                  RenderBox listViewBox = _listKey.currentContext
                                      ?.findRenderObject() as RenderBox;
                                  final listViewPosition =
                                      listViewBox.localToGlobal(Offset.zero);
                                  final listViewSize = listViewBox.size;
                                  // 计算ListView的中心点坐标
                                  final centerX =
                                      listViewPosition.dx + listViewSize.width / 2;
                                  final centerY =
                                      listViewPosition.dy + listViewSize.height / 2;

                                  var offset = _controller.offset;
                                  // 偏移量计算
                                  offset += (center.x - centerX);
                                  if (offset < 0) {
                                    offset = 0;
                                  } else if (offset >
                                      _controller.position.maxScrollExtent) {
                                    offset = _controller.position.maxScrollExtent;
                                  }
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    _controller.animateTo(
                                      offset,
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                },
                              ).marginOnly(left: 2.w);
                            },
                          ),
                        )
                      : Expanded(child: Container()),
                  // 虚拟体育没有全部折叠
                  if (Get.currentRoute != Routes.vrSportDetail)

                    /// 全部折叠、展开按钮
                    InkWell(
                      onTap: controller.changeBtn,
                      child: Obx(() {
                        return Container(
                          margin:
                              EdgeInsets.only(left: widget.fullscreen ? 10 : 10.w),
                          child: AnimatedRotation(
                            duration: const Duration(milliseconds: 200),
                            turns: detailState.getFewer.value != 2 ? 0 : -0.25,
                            child: Container(
                              width: widget.fullscreen ? 20 : 20.w,
                              height: widget.fullscreen ? 16 : 16.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: widget.fullscreen ? 2 : 2.w),
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: widget.fullscreen
                                    ? Colors.white.withOpacity(0.04)
                                    : Get.theme.foldColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      widget.fullscreen ? 20 : 20.r),
                                ),
                              ),
                              child: ImageView(
                                  widget.fullscreen
                                      ? 'assets/images/detail/expand-arrow-night.svg'
                                      : Get.isDarkMode
                                          ? 'assets/images/detail/expand-arrow-night.svg'
                                          : 'assets/images/detail/expand-arrow.svg',
                                  width: widget.fullscreen ? 16 : 16.w,
                                  height: widget.fullscreen ? 16 : 16.h),
                            ),
                          ),
                        );
                      }),
                    )
                ],
              ),
            ),
            // 阴影
            if(Get.currentRoute == Routes.matchDetail)
              Positioned(
                top: 0,
                child: _buildShadow(),
              ),
          ],
        );
      },
    );
  }

  Widget _buildShadow() {
    return Container(
      height: 1,
      width: 1.sw,
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          // 底部阴影
          BoxShadow(
            color: Get.theme.tabPanelBoxShadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
    );
  }
}
