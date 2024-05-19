import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/league_filter_view.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/utils/toast_util.dart';
import 'package:get/get.dart';

import '../../global/assets/webview_cache.dart';
import '../../routes/app_pages.dart';
import '../../services/api/menu_api.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_enum.dart';
import '../../utils/systemchrome.dart';
import '../main_tab/main_tab_controller.dart';
import 'league_filter/league_filter_controller.dart';
import 'league_filter/manager/league_manager.dart';
import 'setting_menu_logic.dart';

class SettingMenuController extends GetxController {
  static SettingMenuController get to => Get.put(SettingMenuController());
  final SettingMenulogic logic = SettingMenulogic();

  //投注模式 1新手 2专业
  int bettingMode = 2;

  //排序规则 1热门 2时间
  int sortingRules = 1;

  //盘口设置 1欧洲盘 2香港盘口
  int handicapSettings = 1;

  //主题风格 1日间 2夜间
  int themeStyle = 1;

  //每日活动 1开启 2关闭
  int dailyActivities = 1;

  bool isDarkMode = false;

  // 是否显示活动
  late bool showActivity = false;
  // 是否冠军
  late bool isChampion = false;

  // 是否显示联赛筛选
  late bool showMatchFilter = true;
  @override
  void onInit() {
    initData();
    initState();
    super.onInit();

    handicapSettings = UserController.to.curOdds == 'EU' ? 1 : 2;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  initState() {
    //直接使用DJController.to会覆盖showMatchIdList
    isChampion = HomeController.to.homeState.menu.isChampion ||
        HomeController.to.homeState.menu.isMatchBet ||
        (Get.isRegistered<DJController>() && DJController.to.isGuanjun());
    initActivity();
  }

  initActivity() {
    bool hasActivity = UserController.to.isHaveActivity();
    if (hasActivity) {
      showActivity = true;
    } else {
      showActivity = false;
    }
  }

  setShowActivity() {
    initActivity();
    update(['SettingMenuShowActivity']);
  }

  onBettingMode(int i) {
    bettingMode = i;
    HomeController.to.changeNew(i == 2 ? true : false);
    // Get.lazyPut(() => DJController());
    // DJController.to.update();
    update();
  }

  onSortingRules(int i) async {
    sortingRules = i;
    HomeController.to.changeHot(i == 1 ? true : false);
    update();
  }

  onHandicapSettings(int i) async {
    if (isChampion) {
      // 冠军默认欧洲盘
      return;
    }
    final res = await MenuApi.instance().setUserPersonalise(i == 1 ? 0 : 1);
    if (res.data.contains('SUCCESS')) {
      handicapSettings = i;

      UserController.to.setCur(i == 1 ? 'EU' : 'HK');
      update();
      Bus.getInstance().emit(EventType.changeOddType);

      //清除购物车数据
      ShopCartController.to.clearData();
    } else {
      ToastUtils.show(res.msg);
    }
  }

  onThemeStyle(int theme) {
    themeStyle = theme;
    Get.changeThemeMode(theme == 1 ? ThemeMode.light : ThemeMode.dark);
    BoolKV.theme.save(Get.isDarkMode);
    HomeController.to.homeState.isLight = theme == 2 ? false : true;
    HomeController.to.update();
    isDarkMode = theme == 2 ? true : false;
    SystemUtils.isDarkMode(theme == 2 ? true : false);
    update();
    // Get.lazyPut(() => DJController());
    // Get.log("DJController.to ${DJController.to}");
    // DJController.to.update();
    // update();
  }

  void initData() {
    bettingMode = HomeController.to.homeState.isProfess ? 2 : 1;
    sortingRules = HomeController.to.homeState.isHot ? 1 : 2;
    Get.isDarkMode ? themeStyle = 1 : themeStyle = 0;
    themeStyle = Get.isDarkMode ? 2 : 1;
    isDarkMode = Get.isDarkMode ? true : false;
    bool da = BoolKV.dailyActivities.get() ?? false;
    dailyActivities = da == true ? 1 : 2;
    update();

    // 预加载webview
    // RuleDescriptionController.to.initData();
    WebviewCacheController.to.getRule();
    // WebviewCacheController.to.initRule();
  }

  void initThemeTheme() {
    update();
  }

  void toRuleDescription() {
    Get.toNamed(Routes.ruleDescription);
  }

  void toNoticeCenter() {
    Get.toNamed(Routes.noticeCenter);
  }

  onTutorial() {
    Get.back();
    Get.toNamed(Routes.tutorial);
  }

  toLanguage() {
    Get.toNamed(Routes.language);
  }

  onLeagueFilter() {
    // 获取到列表的参数
/*    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    LeagueManager.md = startOfDay.millisecondsSinceEpoch.toString();*/
    var type = HomeController.to.homeState.matchListReq.type;
    String euid = HomeController.to.homeState.matchListReq.euid;
    LeagueManager.type.value = type;
    LeagueManager.euid = euid;

    // 做判断删除 已选择联赛数据
    // 如果从赛果页面过来 则删除tid缓存
    if (LeagueManager.entryName != 'home') {
      LeagueManager.tid.clear();
      LeagueManager.entryName = 'home';
    }
    Get.back();
    Get.lazyPut(() => LeagueFilterController(finishCb: (str) {
          // 联赛塞选 数据
          HomeController.to.homeState.matchListReq.tid = str;
          HomeController.to.fetchData();
        }));
    Get.bottomSheet(
      const LeagueFilterPage(),
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
    );
  }

  toSignOut() {
    ShopCartController.to.clearData();
    dbClear();
    Get.offNamed(Routes.splash);
  }

  onDailyActivities(int i) {
    dailyActivities = i;
    BoolKV.dailyActivities.save(i == 1 ? true : false);

    final mainTabController = Get.find<MainTabController>();
    mainTabController.initData();
    update();
  }

  onCustomBetAmount() {
    Get.toNamed(Routes.quickBetAmount);
  }

  onOneClickBetting() {
    Get.toNamed(Routes.oneClickBetting);
  }

  ///关闭
  steShutDown() {
    Get.back();
  }

  toAppLogger() {
    Get.toNamed(Routes.appLogger);
  }
}
