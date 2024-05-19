import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';
import 'package:flutter_ty_app/app/modules/home/models/refresh_status.dart';
import 'package:flutter_ty_app/app/modules/home/views/champion_match_list_view.dart';
import 'package:flutter_ty_app/app/modules/home/views/common_match_list_view.dart';
import 'package:flutter_ty_app/app/modules/home/views/skeleton_match_listView.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/date_time_menu_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/league_search_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/main_menu_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/widgets/no_data.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../utils/oss_util.dart';
import '../../../widgets/no_data_collection.dart';
import '../controllers/home_controller.dart';
import '../controllers/secondary_expand_controller.dart';
import '../models/league.dart';
import '../widgets/menu/sport_menu_widget.dart';
import '../widgets/menu/switch_container_widget.dart';
import '../widgets/search_no_data.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return VisibilityDetector(
          key: const ValueKey("homeView"),
          onVisibilityChanged: (VisibilityInfo info) {
            controller.visiable = info.visibleFraction == 1;
          },
          child: Scaffold(
            body: Container(
              decoration: context.isDarkMode
                  ? BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          OssUtil.getServerPath(
                            'assets/images/home/color_background_skin.png',
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    )
                  : const BoxDecoration(
                      color: Colors.white,
                    ),
              child: Column(
                children: [
                  ///顶部菜单切换
                  _buildTopBar(controller),
                  Expanded(child: _buildBody(controller)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(HomeController controller) {

    if (controller.homeState.isSearch) {
      if (controller.homeState.combineList.isEmpty) {
        ///搜索无数据
        return const SearchNoData();
      } else {
        ///搜索列表数据
        return CommonMatchListView(
          key: ObjectKey(controller.homeState.matchListReq),
        );
      }
    } else {

      switch (controller.homeState.refreshStatus) {
        case RefreshStatus.isLoading:
        ///刷新loading 骨架图
          return SkeletonMatchListView(isNews: !controller.homeState.isProfess);
        case RefreshStatus.loadSuccess:
          ///刷新成功 冠军和足球基本列表
          return controller.homeState.menu.isChampion
              ? const ChampionMatchListView()
              : const CommonMatchListView();
        case RefreshStatus.loadNoData:

          /// 收藏列表无数据填充
          if (controller.homeState.sportId == '50000') {
            return NoDataCollect(content: LocaleKeys.msg_msg_nodata_08.tr);
          }
          ///列表无数据填充
          return NoData(
            content: LocaleKeys.common_no_data.tr,
            top: 80.h,
          );

        case RefreshStatus.loadFailed:
          return NoData(content: LocaleKeys.common_no_network.tr);
      }
    }
  }

  Widget _buildTopBar(HomeController controller) {
    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          Get.mediaQuery.viewPadding.top.verticalSpace,
          ///主菜单切换
          MainMenuWidget(
            onValueChanged: (MainMenu menu) {
              controller.changeMenu(menu);
              SecondaryController.clearMap();
            },
          ),
          ///日期时间切换
          DateTimeMenuWidget(
            menu: controller.homeState.menu,
            onDateTimeChanged: (int? value) {
              controller.changeDateTime(value);
            },
          ),
          ///球类列表切换
          SportMenuWidget(
            scrollController: controller.sportMenuController,
            menu: controller.homeState.menu,
            sportId: controller.homeState.sportId,
          ),
          /// 排序 黑夜白天 切换
          if (!controller.homeState.menu.isChampion)
            SwitchContainerWidget(
              onNewChange: (bool value) {
                controller.changeNew(value);
              },
              onHotChange: (bool value) {
                controller.changeHot(value);
              },
            ),
          ///球队联赛菜单切换 搜索数据
          if (!controller.homeState.menu.isChampion &&
              (['101'].contains(controller.homeState.sportId)))

            LeagueSearchWidget(
              onSearch: (String value) {
                controller.search(value);
              },
              onLeagueChanged: (League league) {
                controller.changeLeague(league);
              },
              currentLeague: controller.homeState.league,
            ),
          4.verticalSpace,
        ],
      ),
    );
  }
}
