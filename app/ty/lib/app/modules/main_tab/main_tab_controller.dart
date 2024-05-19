import 'package:flutter_ty_app/app/global/app_life_cycle_state_change_util.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_view.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/settled_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/settled_bets_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/unsettled_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/unsettled_bets_view.dart';

import '../dj/controllers/dj_controller.dart';
import '../setting_menu/setting_menu_controller.dart';
import 'main_tab_logic.dart';

class MainTabController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  static MainTabController get to => Get.find();
  final MainTablogic logic = MainTablogic();
  int currentIndex = 0;
  late AnimationController animationController;
  late Animation animation;

  late bool dailyActivities = false;

  @override
  void onInit() {
    iconRefresh();
    super.onInit();
    initWebsocket();
    initActivity();
    Future.delayed(const Duration(seconds: 20), () {
      WidgetsBinding.instance.addObserver(this);
      AppLifecycleStateChangeUtil.instance().onNetworkChanged();
    });
  }

  @override
  void onReady() {
    super.onReady();
    initData();
  }

  @override
  void onClose() {
    animationController.dispose();
    AppWebSocket.closeSocket();
    super.onClose();
  }

  initActivity() {
    dailyActivities = UserController.to.isHaveActivity() &&
        BoolKV.dailyActivities.get() == true;
  }

  setShowActivity() {
    initActivity();
    update(['dailyActivities']);
  }

  void refreshMenu() {
    dailyActivities = BoolKV.dailyActivities.get() ?? false;
    if (dailyActivities == true) {
      Get.toNamed(Routes.dailyActivities);
    } else {
      animationController.forward();
      if (Get.currentRoute == Routes.DJView) {
        DJController.to.getDateList();
      } else if (Get.currentRoute == Routes.vrHomePage) {
      } else {
        HomeController.to.fetchData(isWsFetch: true);
      }
    }
  }

  void initData() {
    dailyActivities = BoolKV.dailyActivities.get() ?? false;
    update(['dailyActivities']);
  }

  void iconRefresh() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  }

  void logicToTargetPage(int index) {
    switch (index) {
      case 0:
        Get.toNamed(Routes.matchResults);
        break;
      case 1:
        openSettingsMenu();
        break;
      case 2:
        openOngoingBetsPage();
        break;
      case 3:
        openClosedBetsPage();
        break;
      case 4:
        refreshMenu();
        break;
    }
  }

  //打开设置
  openSettingsMenu() {
    Get.lazyPut(() => SettingMenuController());
    Get.bottomSheet(
      const SettingMenuPage(),
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
    );
  }

  //未结注单
  openOngoingBetsPage() {
    Get.lazyPut(() => UnsettledBetsLogic());
    Get.dialog(
      const UnsettledBetsPage(),
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  //已结注单
  openClosedBetsPage() {
    Get.lazyPut(() => SettledBetsLogic());
    Get.dialog(
      const SettledBetsPage(),
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  ///app状态监控
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:

        /// 应用程序前台
        if (kDebugMode) {
          print('App应用程序前台');
        }
        AppLifecycleStateChangeUtil.instance().resumed();

        break;
      case AppLifecycleState.inactive:

        /// 应用程序在前台不活跃
        AppLifecycleStateChangeUtil.instance().inactive();
        break;
      case AppLifecycleState.paused:
        appStorage.save();

        /// 应用程序后台
        if (kDebugMode) {
          print('App应用程序后台');
        }
        AppLifecycleStateChangeUtil.instance().paused();
        break;
      case AppLifecycleState.detached:
        appStorage.save();

        /// 应用程序未被挂载
        break;
      case AppLifecycleState.hidden:

        /// 应用程序隐藏
        AppLifecycleStateChangeUtil.instance().hidden();
        break;
    }
  }

  ///初始化长连接 和 数据仓库
  void initWebsocket() {
    DataStoreController.to.initObj();
    AppWebSocket.connect();
  }
}
