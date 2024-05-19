import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/widgets/scroll_index_widget.dart';
import 'package:flutter_ty_app/app/widgets/sport_icon.dart';

import '../../../../global/user_controller.dart';
import '../../../setting_menu/setting_menu_controller.dart';

///球种菜单
class SportMenuWidget extends StatelessWidget {
  const SportMenuWidget({
    super.key,
    required this.menu,
    required this.sportId,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final MainMenu menu;
  final String sportId;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          Container(
            height: 45.h,
            alignment: Alignment.center,
            child: ScrollIndexWidget(
              isStopCallback: false,
              callBack: (int firstIndex, int lastIndex) {
                ///判断球种滚动和边界 显示最左边或者最右边
                int currentIndex = HomeController
                    .to.homeSportMenuState.sportMenuList
                    .indexWhere((element) => element.mi == sportId);
                if (currentIndex == -1) return;
                if (currentIndex <= firstIndex) {
                  HomeController.to.homeSportMenuState.leftShow.value = true;
                  HomeController.to.homeSportMenuState.rightShow.value = false;
                } else if (currentIndex >= lastIndex) {
                  HomeController.to.homeSportMenuState.leftShow.value = false;
                  HomeController.to.homeSportMenuState.rightShow.value = true;
                } else {
                  HomeController.to.homeSportMenuState.leftShow.value = false;
                  HomeController.to.homeSportMenuState.rightShow.value = false;
                }
              },
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: HomeController.to.homeSportMenuState.sportMenuList.length,
                clipBehavior: Clip.none,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final sportInfo =
                      HomeController.to.homeSportMenuState.sportMenuList[index];
                  if (sportInfo.mi == '50000' &&
                      ConfigController.to.accessConfig.value.collectSwitch ==
                          false) {
                    return const SizedBox();
                  }
                  if (sportInfo.mi == '100' &&
                      ConfigController.to.accessConfig.value.playAllShow ==
                          false) {
                    return const SizedBox();
                  }

                  /// 电子篮球和电子足球用户开关
                  if (UserController
                              .to.userInfo.value?.openElectronicBasketball !=
                          1 &&
                      sportInfo.mi == '191') {
                    return const SizedBox();
                  }
                  if (UserController
                              .to.userInfo.value?.openElectronicFootball !=
                          1 &&
                      sportInfo.mi == '190') {
                    return const SizedBox();
                  }

                  /// 电竞开关
                  if (UserController.to.userInfo.value?.openEsport != 1 &&
                      sportInfo.mi == '2000') {
                    return const SizedBox();
                  }
                  // VR体育开关
                  if (UserController.to.userInfo.value?.openVrSport != 1 &&
                      sportInfo.mi == '300') {
                    return const SizedBox();
                  }
                  return GetBuilder<CollectionController>(
                    init: CollectionController(),
                    id: sportInfo.mi,
                    builder: (collectionCtr) {
                      if (sportInfo.mi == '300' &&
                          !HomeController.to.showVrSportMenu) {
                        return const SizedBox();
                      }
                      return MenuItem(
                        key: ValueKey(sportInfo.mi),
                        title: ConfigController.to.getName(sportInfo.mi),
                        index: sportInfo.iconIndex,
                        count: sportInfo.mi == '50000'
                            ? collectionCtr.collectionCount
                            : sportInfo.count,
                        isSelected: sportInfo.mi == sportId,
                        onTap: () async {
                          ///菜单滑动到居中位置 如果偏移值不够 就不偏移
                          double itemW = 50.w;
                          scrollController.animateTo(
                            (index * itemW) - (Get.width - itemW) * 0.5,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          if (sportInfo.mi == '50000') {
                            SettingMenuController.to.showMatchFilter = false;
                          } else {
                            SettingMenuController.to.showMatchFilter = true;
                          }

                          if (sportInfo.mi == '2000') {
                            await Get.toNamed(Routes.DJView);
                            return;
                          }
                          if (sportInfo.mi == '300') {
                            await Get.toNamed(Routes.vrHomePage);
                            return;
                          }
                          HomeController.to.homeSportMenuState.leftShow.value =
                              false;
                          HomeController.to.homeSportMenuState.rightShow.value =
                              false;
                          HomeController.to
                              .changeSport(sportInfo.mi, sportInfo.euid);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          ///显示左边
          if (HomeController.to.homeSportMenuState.leftShow.value)
            Align(
              alignment: Alignment.centerLeft,
              child: Builder(builder: (context) {
                final sportInfo = HomeController
                    .to.homeSportMenuState.sportMenuList
                    .firstWhere((element) => element.mi == sportId);
                return GetBuilder<CollectionController>(
                    init: CollectionController(),
                    id: sportInfo.mi,
                    builder: (logic) {
                      return MenuItem(
                        title: ConfigController.to.getName(sportInfo.mi),
                        index: sportInfo.iconIndex,
                        count: sportInfo.mi == '50000'
                            ? logic.collectionCount
                            : sportInfo.count,
                        isSelected: true,
                        onTap: () {},
                      );
                    });
              }),
            ),
          ///显示右边
          if (HomeController.to.homeSportMenuState.rightShow.value)
            Align(
              alignment: Alignment.centerRight,
              child: Builder(builder: (context) {
                final sportInfo = HomeController
                    .to.homeSportMenuState.sportMenuList
                    .firstWhere((element) => element.mi == sportId);
                return GetBuilder<CollectionController>(
                    init: CollectionController(),
                    id: sportInfo.mi,
                    builder: (logic) {
                      return MenuItem(
                        title: ConfigController.to.getName(sportInfo.mi),
                        index: sportInfo.iconIndex,
                        count: sportInfo.mi == '50000'
                            ? logic.collectionCount
                            : sportInfo.count,
                        isSelected: true,
                        onTap: () {},
                      );
                    });
              }),
            )
        ],
      );
    });
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.title,
      required this.index,
      required this.count,
      required this.isSelected,
      required this.onTap});

  final String title;
  final int index;
  final int? count;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 3, right: 3),
            width: 50.w,
            height: 45.h,

            /// 悬浮效果需要背景色,这个不要改，改了会影响悬浮效果。改你主界面的背景色就行了
            color: context.theme.scaffoldBackgroundColor,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sportIcon(
                  index: index,
                  width: 22.w,
                  height: 22.w,
                  isSelected: isSelected,
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: isSelected
                        ? context.isDarkMode
                            ? Colors.white.withOpacity(0.9)
                            : const Color(0xff303442)
                        : context.isDarkMode
                            ? Colors.white.withOpacity(0.3)
                            : const Color(0xffAFB3C8),
                    fontSize: title.length > 3 ? 9 : 10.sp,
                  ),
                  // minFontSize: 6,
                ),
                SizedBox(
                  height: 2.w,
                )
              ],
            ),
          ),
          if (count != null)
            Positioned(
              top: 0,
              left: 35.w,
              child: Container(
                width: 17.w,
                child: Text(
                  count.toString(),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Akrobat',
                    color: isSelected
                        ? context.isDarkMode
                            ? Colors.white.withOpacity(0.9)
                            : const Color(0xff303442)
                        : context.isDarkMode
                            ? Colors.white.withOpacity(0.3)
                            : const Color(0xffAFB3C8),
                    fontSize: 9,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
