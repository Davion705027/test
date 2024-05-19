import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/tab_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import '../../../generated/locales.g.dart';
import '../home/views/home_view.dart';
import '../login/login_head_import.dart';
import 'main_tab_controller.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({Key? key}) : super(key: key);

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  final controller = Get.find<MainTabController>();
  final logic = Get.find<MainTabController>().logic;

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
        child: Scaffold(
          body: const HomeView(),
          bottomNavigationBar: Container(
            height: 75.h,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? const Color(0xE5181A21)
                  : const Color(0xffFFFAFA),
              boxShadow: [
                BoxShadow(
                  color: context.isDarkMode ? Colors.black.withAlpha(90) : Colors.grey.withAlpha(90),
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
                    onTap: () => controller.logicToTargetPage(0),
                    title: LocaleKeys.menu_itme_name_results.tr,
                    imageUrl: context.isDarkMode ? 'assets/images/icon/main_tab1_night.svg':'assets/images/icon/main_tab1.png',
                    dailyActivities: false,
                  ),
                  //设置菜单
                  TabWidget(
                    onTap: (){
                    controller.logicToTargetPage(1);
                  },
                    title: LocaleKeys.footer_menu_set_menu.tr,
                    imageUrl: context.isDarkMode ? 'assets/images/icon/main_tab2_night.svg':'assets/images/icon/main_tab2.png',
                    dailyActivities: false,
                  ),
                  //未结注单
                  TabWidget(
                    onTap: () => controller.logicToTargetPage(2),
                    title: LocaleKeys.app_h5_cathectic_open_bets.tr,
                    imageUrl: context.isDarkMode ? 'assets/images/icon/main_tab3_night.svg':'assets/images/icon/main_tab3.png',
                    dailyActivities: false,
                  ),
                  //已结注单
                  TabWidget(
                    onTap: () => controller.logicToTargetPage(3),
                    title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
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
                        imageUrl: 'assets/images/icon/main_tab4.png',
                        animation: true,
                        dailyActivities: controller.dailyActivities,
                        animate: controller.animationController,
                      );
                    },
                  ),
                ]),
          ),
        )
    )
    );
  }

  @override
  void dispose() {
    Get.delete<MainTabController>();
    super.dispose();
  }
}
