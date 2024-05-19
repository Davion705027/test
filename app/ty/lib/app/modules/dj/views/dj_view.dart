import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/o_match_list_item_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/menu/dj_header_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/menu/simple_date_menu_widget.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/home/views/skeleton_match_listView.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/seaction_header_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/sport_header_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/tab_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_date_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/widgets/no_data.dart';
import 'package:flutter_ty_app/app/widgets/no_data_collection.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/dj_controller.dart';
import '../models/game.dart';
import '../widgets/menu/game_menu_widget.dart';

class DJView extends StatelessWidget {
  DJView({Key? key}) : super(key: key);

  final bottomController = Get.find<MainTabController>();

  // final logic = Get.find<MainTabController>().logic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DJController>(
        init: DJController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                decoration: context.isDarkMode
                    ? const BoxDecoration(
                        // image: DecorationImage(
                        //   image: NetworkImage(
                        //     OssUtil.getServerPath(
                        //       'assets/images/home/color_background_skin.png',
                        //     ),
                        //   ),
                        //   fit: BoxFit.cover,
                        // ),
                        )
                    : const BoxDecoration(
                        color: const Color(0xfff2f2f6),
                      ),
                child: Column(
                  children: [
                    _buildTopBar(controller),
                    Expanded(
                      child: Container(
                          // color: const Color(0xfff2f2f6),
                          child: dealListLogic(controller)),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 75.h, //
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
              //赛果
              TabWidget(
                onTap: () => bottomController.logicToTargetPage(0),
                title: LocaleKeys.menu_itme_name_results.tr,
                imageUrl: context.isDarkMode ? 'assets/images/icon/main_tab1_night.svg':'assets/images/icon/main_tab1.png',
                dailyActivities: false,
              ),
              //设置菜单
              TabWidget(
                onTap: () {
                  SettingMenuController.to.showMatchFilter = false;
                  bottomController.logicToTargetPage(1);
                },
                title: LocaleKeys.footer_menu_set_menu.tr,
                imageUrl: context.isDarkMode ? 'assets/images/icon/main_tab2_night.svg':'assets/images/icon/main_tab2.png',
                dailyActivities: false,
              ),
              //未结注单
              TabWidget(
                onTap: () => bottomController.logicToTargetPage(2),
                title: LocaleKeys.footer_menu_open_bets.tr,
                imageUrl: context.isDarkMode ? 'assets/images/icon/main_tab3_night.svg':'assets/images/icon/main_tab3.png',
                dailyActivities: false,
              ),
              //已结注单
              TabWidget(
                onTap: () => bottomController.logicToTargetPage(3),
                title: LocaleKeys.footer_menu_closed_bets.tr,
                imageUrl: context.isDarkMode ? 'assets/images/icon/main_tab4_night.svg':'assets/images/icon/main_tab4.png',
                dailyActivities: false,
              ),
              //刷新

              GetBuilder<MainTabController>(
                id: 'dailyActivities',
                builder: (controller) {
                  return TabWidget(
                    onTap: () => controller.logicToTargetPage(4),
                    title: LocaleKeys.footer_menu_refresh.tr,
                    imageUrl: context.isDarkMode ? 'assets/images/icon/main_tab4_night.svg':'assets/images/icon/main_tab4.png',
                    animation: true,
                    dailyActivities: controller.dailyActivities,
                    animate: controller.animationController,
                  );
                },
              ),
            ]),
      ),
    );
  }

  List<Widget> _sliverList(
      DJController controller, SectionGroupEnum sectionGroupEnum) {
    List<Widget> list = [];
    List<MatchEntity?>? data = [];
    switch (sectionGroupEnum) {
      case SectionGroupEnum.IN_PROGRESS:
        controller.DJState.djListEntity?.forEach((e) {
          if (e.ms == 1) {
            data?.add(e);
          }
        });
        break;
      case SectionGroupEnum.NOT_STARTED:
        controller.DJState.djListEntity?.forEach((e) {
          if (e.ms == 0) {
            data?.add(e);
          }
        });
        break;
      case SectionGroupEnum.ALL:
        HomeController.to.homeState.dateTime = 0;
        data = controller.DJState.djListEntity;
        break;
    }
    String? title = '';
    Map<String, int> groupCount = {};
    if (data != null && data!.isNotEmpty) {
      title = "${data?[0]?.csna}(${data?.length})";
      for (int i = 0; i < data.length; i++) {
        String? key = data[i]?.tid.toString();
        if (groupCount.containsKey(key)) {
          int count = groupCount[key!]!;
          count++;
          groupCount[key!] = count;
        } else {
          groupCount[key!] = 1;
        }
      }
      // groupCount

      list.add(SliverToBoxAdapter(
        child: SectionHeaderWidget(
          sectionGroupEnum: sectionGroupEnum,
          isExpand: sectionGroupEnum == SectionGroupEnum.IN_PROGRESS
              ? controller.DJState.isExpandProcess
              : sectionGroupEnum == SectionGroupEnum.ALL
                  ? controller.DJState.isExpandAll
                  : controller.DJState.isExpand,
          onExpand: (isExpand) {
            if (sectionGroupEnum == SectionGroupEnum.IN_PROGRESS) {
              controller.DJState.isExpandProcess = isExpand;
            } else if (sectionGroupEnum == SectionGroupEnum.ALL) {
              controller.DJState.isExpandAll = isExpand;
            } else {
              controller.DJState.isExpand = isExpand;
            }
            data?.forEach((matchEntity) {
              Get.log("clickCollop = ${matchEntity?.mid} ${matchEntity?.man}");
              DJController.to
                  .clickCollop(isExpand, matchEntity, sectionGroupEnum);
            });
          },
        ),
      ));
      if (controller.DJState.selectDate?.menuType != 100) {
        list.add(SliverToBoxAdapter(
          child: SportHeaderWidget(
            title: title ?? '',
          ),
        ));
      }

      list.add(SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            bool showGroupHead = true;
            bool isLast = false;
            if (index > 0 && data![index]?.tid == data![index - 1]?.tid) {
              showGroupHead = false;
            }
            if ((index+1 < data!.length && data![index]?.tid != data![index + 1]?.tid) || data!.length ==1) {
              isLast = true;
            }
            int count = groupCount[data![index]?.tid] ?? 0;
            ///电竞联赛
            return OMatchListItemWidget(
                matchEntity: data![index] ?? MatchEntity(),
                sectionGroupEnum: sectionGroupEnum,
                showGroupHead: showGroupHead,
                isLast: isLast,
                count: count);
          },
          childCount: data?.length,
        ),
      ),
      );
    }

    return list;
  }

  Widget _buildTopBar(DJController controller) {
    Get.log('djDateEntity = length ${controller.DJState.djDateEntity?.length}');
    controller.DJState.djDateEntity?.forEach((element) {
      Get.log('djDateEntity = ${element?.menuName}');
    });
    return Column(
      children: [
        const DJHeaderWidget(),
        SimpleDateMenuWidget(
          djDateEntity: controller.DJState.djDateEntity ?? [],
          onValueChanged: (DjDateEntityEntity date) {
            Get.log('index: ${date.menuName}');
            Get.log('djDateEntity = ${date?.toString()}');
            controller.changeTime(date);
          },
        ),
        GameMenuWidget(
          gameId: controller.DJState.gameId,
          onValueChanged: (mi) {
            controller.DJState.gameId = mi;
            controller.changeGame(mi, ConfigController.to.getDjEuid(mi));
          },
          gameList: Game.leagueList,
        ),
      ],
    );
  }

  dealListLogic(DJController controller) {
    if (controller.DJState.isLoading) {
      return SkeletonMatchListView(
        isNews: !HomeController.to.homeState.isProfess,
      );
    } else if (controller.DJState.djListEntity == null ||
        controller.DJState.djListEntity!.isEmpty) {
      if (controller.isCollect()) {
        return NoDataCollect(content: LocaleKeys.msg_msg_nodata_08.tr);
      } else {
        return NoData(content: LocaleKeys.common_no_data.tr);
      }
    } else {
      if (controller.isGuanjun()) {
        //冠军
        return CustomScrollView(
          slivers: [
            ..._sliverList(controller, SectionGroupEnum.ALL),
          ],
        );
      } else {
        return CustomScrollView(
          slivers: [
            ..._sliverList(controller, SectionGroupEnum.IN_PROGRESS),
            ..._sliverList(controller, SectionGroupEnum.NOT_STARTED),
            // ..._sliverList(controller, SectionGroupEnum.ALL),
          ],
        );
      }
    }
  }
}
