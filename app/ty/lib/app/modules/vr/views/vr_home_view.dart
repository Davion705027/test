import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/global/assets/preloadImg.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/tab_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_ball_extensions.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/balance_icon_button.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/basket_going_sport_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/global_expand_toggle_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/going_sport_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/single_expand_toggle_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_sport_menu_tab_bar.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/waiting_sport_widget.dart';
import 'package:flutter_ty_app/app/widgets/common_app_bar.dart';
import 'package:flutter_ty_app/app/widgets/no_data.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

import '../controllers/vr_home_controller.dart';

class VrHomeView extends GetView<VrHomeController> {
  const VrHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreloadImg.preloadOnVrSport(context);
    return GetBuilder<VrHomeController>(
      init: VrHomeController(),
      builder: (_) => Stack(
        children: [
          if (Get.isDarkMode)
            const ImageView(
                'assets/images/detail/bg-dark.png',
                width: double.infinity,
                height: double.infinity,
                boxFit: BoxFit.cover,
              ),
            Container(
              decoration: const BoxDecoration(color: AppColor.vrSportBg),
            ),
          Scaffold(
            backgroundColor:
                !Get.isDarkMode ? '#F2F2F6'.hexColor : Colors.transparent,
            appBar: CommonAppBar.arrowBack(
              context,
              title: LocaleKeys.common_virtual_sports.tr,
              actions: [
                const BalanceIconButton(),
              ],
            ),
            bottomNavigationBar: Container(
              height: 75.h,
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? const Color(0xE5181A21)
                    : const Color(0xffFFFAFA),
                boxShadow: [
                  BoxShadow(
                    color: context.isDarkMode ? Colors.black : Colors.grey,
                    blurRadius: 4.r,
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // 赛果
                  TabWidget(
                    onTap: () => controller.logicToTargetPage(0),
                    title: LocaleKeys.menu_itme_name_results.tr,
                    imageUrl: context.isDarkMode
                        ? 'assets/images/icon/main_tab1_night.svg'
                        : 'assets/images/icon/main_tab1.png',
                    dailyActivities: false,
                  ),
                  // 设置菜单
                  TabWidget(
                    onTap: () {
                      controller.logicToTargetPage(1);
                    },
                    title: LocaleKeys.footer_menu_set_menu.tr,
                    imageUrl: context.isDarkMode
                        ? 'assets/images/icon/main_tab2_night.svg'
                        : 'assets/images/icon/main_tab2.png',
                    dailyActivities: false,
                  ),
                  // 未结注单
                  TabWidget(
                    onTap: () => controller.logicToTargetPage(2),
                    title: LocaleKeys.app_h5_cathectic_open_bets.tr,
                    imageUrl: context.isDarkMode
                        ? 'assets/images/icon/main_tab3_night.svg'
                        : 'assets/images/icon/main_tab3.png',
                    dailyActivities: false,
                  ),
                  // 已结注单
                  TabWidget(
                    onTap: () => controller.logicToTargetPage(3),
                    title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
                    imageUrl: context.isDarkMode
                        ? 'assets/images/icon/main_tab4_night.svg'
                        : 'assets/images/icon/main_tab4.png',
                    dailyActivities: false,
                  ),
                  // 刷新
                  TabWidget(
                    onTap: () => controller.logicToTargetPage(4),
                    title: LocaleKeys.footer_menu_refresh.tr,
                    imageUrl: 'assets/images/icon/main_tab4.png',
                    animation: true,
                    dailyActivities: controller.dailyActivities,
                    animate: controller.animationController,
                  ),
                ],
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     color: context.isDarkMode
            //         ? const Color(0xE5181A21)
            //         : const Color(0xffFFFAFA),
            //     boxShadow: [
            //       BoxShadow(
            //         color: context.isDarkMode ? Colors.black : Colors.grey,
            //         blurRadius: 4.r,
            //       )
            //     ],
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(25.r),
            //       topRight: Radius.circular(25.r),
            //     ),
            //   ),
            //   child: Container(
            //     padding: EdgeInsets.only(
            //       top: 10.h,
            //       left: 25.w,
            //       right: 25.w,
            //     ),
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: <Widget>[
            //             //赛果
            //             TabWidget(
            //               onTap: () => controller.logicToTargetPage(0),
            //               title: LocaleKeys.menu_itme_name_results.tr,
            //               imageUrl: context.isDarkMode
            //                   ? 'assets/images/icon/main_tab1_night.svg'
            //                   : 'assets/images/icon/main_tab1.png',
            //               dailyActivities: false,
            //             ),
            //             //设置菜单
            //             TabWidget(
            //               onTap: () => controller.logicToTargetPage(1),
            //               title: LocaleKeys.footer_menu_set_menu.tr,
            //               imageUrl: context.isDarkMode
            //                   ? 'assets/images/icon/main_tab2_night.svg'
            //                   : 'assets/images/icon/main_tab2.png',
            //               dailyActivities: false,
            //             ),
            //             //未结注单
            //             TabWidget(
            //               onTap: () => controller.logicToTargetPage(2),
            //               title: LocaleKeys.footer_menu_open_bets.tr,
            //               imageUrl: context.isDarkMode
            //                   ? 'assets/images/icon/main_tab3_night.svg'
            //                   : 'assets/images/icon/main_tab3.png',
            //               dailyActivities: false,
            //             ),
            //             //已结注单
            //             TabWidget(
            //               onTap: () => controller.logicToTargetPage(3),
            //               title: LocaleKeys.footer_menu_closed_bets.tr,
            //               imageUrl: context.isDarkMode
            //                   ? 'assets/images/icon/main_tab4_night.svg'
            //                   : 'assets/images/icon/main_tab4.png',
            //               dailyActivities: false,
            //             ),
            //             // 刷新
            //             TabWidget(
            //               onTap: () => controller.logicToTargetPage(4),
            //               title: LocaleKeys.footer_menu_refresh.tr,
            //               imageUrl: context.isDarkMode
            //                   ? 'assets/images/icon/main_tab4_night.svg'
            //                   : 'assets/images/icon/main_tab4.png',
            //               animation: true,
            //               dailyActivities: controller.dailyActivities,
            //               animate: controller.animationController,
            //             ),
            //           ],
            //         ),
            //         SizedBox(height: 30.w),
            //       ],
            //     ),
            //   ),
            // ),
            body: controller.vrSportsMenus.isEmpty
                ? const CupertinoActivityIndicator().center
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<VrHomeController>(
                        id: 'sport_menus',
                        builder: (_) => VrSportMenuTabBar(
                          key: ValueKey(
                              'sport_menus_${controller.vrSportsMenus.length}'),
                          vrSportMenus: controller.vrSportsMenus,
                          onMenuChanged: controller.onMenuChanged,
                        ),
                      ),
                      GetBuilder<VrHomeController>(
                        id: 'all_expand_toggle',
                        builder: (_) => GlobalExpandToggleWidget.all(
                          key: ValueKey(
                              'all_expand_toggle_${controller.isAllExpand}'),
                          isExpand: controller.isAllExpand,
                          onExpandChanged: controller.onAllExpandChanged,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GetBuilder<VrHomeController>(
                        id: 'match_list',
                        builder: (_) {
                          if (controller.isMatchesLoading) {
                            return const CupertinoActivityIndicator().center;
                          }
                          if (controller.isLoadFailed) {
                            return NoData(
                              top: 70.h,
                              content: LocaleKeys.common_no_network.tr,
                              // type: NoDataType.noWifi,
                              // onRefresh: () {
                              //   controller.onNextMatchCountdownEnd();
                              // },
                            ).center;
                          }
                          if (controller.matches.isEmpty) {
                            return NoData(
                              top: 70.h,
                              content: LocaleKeys.common_no_data.tr,
                              // type: NoDataType.noMatch,
                            ).center;
                          }
                          return ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 5.w)
                                .copyWith(bottom: 30),
                            itemCount: controller.matches.length,
                            itemBuilder: (context, index) {
                              if (index > controller.matches.length) {
                                return const SizedBox();
                              }

                              if (index == 0) {
                                final vrMatch = controller.matches[index];

                                // 未开始的第一个和第二个其实是重复的，所以不能用 index + 1
                                final nextVrMatch = controller.matches
                                    .firstWhereOrNull((element) =>
                                        element.batchNo != vrMatch.batchNo);
                                // index + 1 < controller.matches.length
                                //     ? controller.matches[index + 1]
                                //     : null;

                                final isExpand =
                                    controller.isAllExpand || vrMatch.isExpand;
                                return _buildItem(
                                  title: controller.subMenu?.name ?? '',
                                  subtitle: vrMatch.no,
                                  batchNo: vrMatch.batchNo,
                                  time: vrMatch.mgt,
                                  cusTime: controller.curMatchFinished
                                      ? LocaleKeys.list_match_end.tr
                                      : '',
                                  isExpand: isExpand,
                                  index: index,
                                  lod: vrMatch.lod,
                                  child: controller.topMenu?.type == 2
                                      ? BasketGoingSportWidget(
                                          key: ValueKey(
                                              'basket_going_match_${vrMatch.batchNo}_${vrMatch.lod}'),
                                          type: controller.topMenu?.type ?? 1,
                                          vrMatch: vrMatch,
                                          nextVrMatch: nextVrMatch,
                                          getVirtualReplay:
                                              controller.getVirtualReplay,
                                          onNextMatchCountdownEnd: controller
                                              .onNextMatchCountdownEnd,
                                          onVideoPlayFinished:
                                              controller.onVideoPlayFinished,
                                          onGetMatchScore:
                                              controller.getMatchScore,
                                        )
                                      : GoingSportWidget(
                                          key: ValueKey(
                                              'going_match_${vrMatch.batchNo}'),
                                          type: controller.topMenu?.type ?? 1,
                                          vrMatch: vrMatch,
                                          nextVrMatch: nextVrMatch,
                                          getVirtualReplay:
                                              controller.getVirtualReplay,
                                          onNextMatchCountdownEnd: controller
                                              .onNextMatchCountdownEnd,
                                          onVideoPlayFinished:
                                              controller.onVideoPlayFinished,
                                          onGetMatchScore:
                                              controller.getMatchScore,
                                        ),
                                );
                              }

                              final vrMatch = controller.matches[index];

                              final isExpand =
                                  controller.isAllExpand || vrMatch.isExpand;

                              return WaitingSportWidget(
                                key: ValueKey(
                                    'waiting_match_${vrMatch.batchNo}_$isExpand'),
                                title: controller.subMenu?.name ?? '',
                                isExpand: isExpand,
                                type: controller.topMenu?.type ?? 1,
                                vrMatch: vrMatch,
                                onToggleExpand: (isExpand) {
                                  controller.onItemToggleExpand(
                                      isExpand, index);
                                },
                              );
                            },
                          );
                        },
                      ).expanded(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required bool isExpand,
    required int index,
    required String title,
    required String subtitle,
    required String time,
    required String batchNo,
    required String lod,
    String cusTime = '',
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: Get.isDarkMode
              ? Colors.white.withOpacity(0.04)
              : AppColor.colorWhite,
        ),
        color: Get.isDarkMode
            ? Colors.white.withOpacity(0.03999999910593033)
            : const Color(0xffF8F9FA),
      ),
      child: Column(
        children: [
          SingleExpandToggleWidget(
            key: ValueKey('eapand_${batchNo}_$lod'),
            title: title,
            subtitle: subtitle,
            time: time,
            cusTime: cusTime,
            isExpand: isExpand,
            onToggleExpand: (isExpand) {
              controller.onItemToggleExpand(isExpand, index);
            },
          ),
          if (isExpand) child,
        ],
      ),
    );
  }
}
