import 'package:common_utils/common_utils.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/widgets/no_data.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/data_store_controller.dart';
import '../../../utils/oss_util.dart';
import '../../../widgets/hit_test_blocker.dart';
import '../../../widgets/loading.dart';
import '../../shop_cart/shop_cart_controller.dart';
import '../constant/detail_constant.dart';
import '../controllers/match_detail_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/container/odds_info_container.dart';
import '../widgets/header/header_background.dart';
import '../widgets/header/common_header.dart';
import '../widgets/container/analysis_container.dart';
import '../widgets/header/header_video_info.dart';
import '../widgets/tab/bet_mode_tab_widget.dart';
import '../widgets/tab/main_tab_widget.dart';

class MatchDetailView extends StatelessWidget {
  const MatchDetailView({super.key, this.tag});

  /// tag 使用mid或者null 主要作用用于详情打开详情
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>PopScope(
      //关闭购物车之后再退出
        canPop:!ShopCartController.to.state.showShopCart.value,
        onPopInvoked:(didPop) {
          if(ShopCartController.to.state.showShopCart.value) {
            ShopCartController.to.currentBetController?.closeBet();
          }
        },
        child:  GetBuilder<MatchDetailController>(
            tag: tag,
            builder: (controller) {
              MatchEntity? match = controller.detailState.match;
              // 数据仓库没有match 并且路由没有传csid
              if (match == null &&
                  ObjectUtil.isEmpty(controller.detailState.csid)) {
                if (controller.detailState.detailLoading) {
                  // return const CupertinoActivityIndicator().center;
                  return const Loading();
                } else {
                  return NoData(
                    content: LocaleKeys.analysis_football_matches_no_data.tr,
                    backHeader: true,
                  );
                }
              }
              return OrientationBuilder(builder: (context, orientation) {
                if (orientation == Orientation.landscape) {
                  // 全屏状态栏不显示
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                      overlays: []);
                  controller.detailState.fullscreen.value = true;
                } else if (orientation == Orientation.portrait) {
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                      overlays: SystemUiOverlay.values);
                  controller.detailState.fullscreen.value = false;
                }
                return Stack(
                  children: [
                    /// 背景图、动画、视频组件
                    HitTestBlocker(
                      child: HeaderBackground(
                        match: match,
                        controller: controller,
                        tag: tag,
                        // fullscreen: controller.detailState.fullscreen.value,
                      ),
                    ),

                    HitTestBlocker(
                      child: Visibility(
                        visible: !controller.detailState.fullscreen.value,
                        // 保持动画、状态、不占空间
                        maintainAnimation: true,
                        maintainSize: false,
                        maintainState: true,
                        child: _buildPlayingBody(match, controller),
                      ),
                    ),
                  ],
                );
              });
            })
    ));
  }

  Widget _buildPlayingBody(
      MatchEntity? match, MatchDetailController controller) {
    //状态栏 height
    final double statusBarHeight = Get.mediaQuery.padding.top;
    final double pinnedHeaderHeight = statusBarHeight + appbarHeight;
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification value) {
        // 顶部悬停时 获取悬停标志

        double offset =
            controller.detailState.scrollController.offset.roundToDouble() -
                (headerHeight - pinnedHeaderHeight).roundToDouble();
        if (controller.detailState.scrollController.hasClients &&
            offset >= 0 &&
            !controller.detailState.appbarPinned.value) {
          controller.detailState.appbarPinned.value = true;
        }

        if (controller.detailState.scrollController.hasClients &&
            offset < 0 &&
            controller.detailState.appbarPinned.value) {
          controller.detailState.appbarPinned.value = false;
        }

        // controller.calcScroll(value);

        return false;
      },
      child: ExtendedNestedScrollView(
        controller: controller.detailState.scrollController,
        headerSliverBuilder: (BuildContext c, bool f) {
          return [
            /// 头部 展示比分、视频、动画等
            CommonHeader(
              controller: controller,
              tag: tag,
            ),
          ];
        },

        /// 悬停高度
        pinnedHeaderSliverHeightBuilder: () {
          return pinnedHeaderHeight;
        },

        /// AutomaticKeepAliveClientMixin	ScrollPosition 不会被释放
        onlyOneScrollInBody: true,
        physics: const ClampingScrollPhysics(),
        body: Container(
          decoration: BoxDecoration(
            color: Get.theme.detailBackgroundColor,
            image: Get.isDarkMode
                ? DecorationImage(
                    image: NetworkImage(
                      OssUtil.getServerPath(
                        'assets/images/detail/bg-dark.png',
                      ),
                    ),
                    fit: BoxFit.cover)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              /// 视频说明
              HeaderVideoInfo(
                controller: controller,
              ),

              ///悬停内容 tab组件
              MainTabWidget(
                controller: controller,
                tag: tag,
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    /// 数据仓库没有获取到match 走这
                    if (match == null) _buildNoDataWidget(controller),

                    if (match != null)
                      ExtendedVisibilityDetector(
                        uniqueKey: const Key('Tab0'),
                        child: GetBuilder<DataStoreController>(
                          id: DataStoreController.to.getMatchId(match.mid),
                          builder: (dataStoreController) {
                            MatchEntity matchEntity =
                                dataStoreController.getMatchById(match.mid) ??
                                    match;
                            String mmp = matchEntity.mmp;

                            /// 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断   ms=110时:显示即将开赛
                            List<int> arrMs = [0, 1, 2, 7, 10, 110];
                            if (mmp == "999" ||
                                !arrMs.contains(matchEntity.ms)) {
                              //切换赛事
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                controller.eventSwitch();
                              });
                            }

                            // ms 为0 未开始 1进行 110 即将开赛
                            if ([0, 1, 110].contains(matchEntity.ms)) {
                              return Column(
                                children: [
                                  // 玩法集
                                  BetModeTab(
                                    tag: tag,
                                  ),
                                  Expanded(
                                    child: OddsInfoContainer(
                                      tag: tag,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return NoData(
                                content: LocaleKeys
                                    .analysis_football_matches_no_data.tr,
                                top: 30.h,
                              );
                            }
                          },
                        ),
                      ),

                    /// 赛事分析、首发展示内容
                    if (match != null && controller.showMatchAnalysisTab())
                      ExtendedVisibilityDetector(
                          uniqueKey: const Key('Tab1'),
                          child: AnalysisContainer(
                            tag: tag,
                          ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoDataWidget(MatchDetailController controller) {
    if (controller.detailState.detailLoading) {
      // 接口请求loading
      return const Loading();
    } else {
      1.delay(() {
        // 没有数据 说明赛事结束？异常？ 进行赛事切换
        controller.eventSwitch();
      });
      return NoData(
        content: LocaleKeys.analysis_football_matches_no_data.tr,
      );
    }
  }
}
