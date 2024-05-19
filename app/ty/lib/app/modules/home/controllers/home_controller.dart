import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_event_bus.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_sport_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/match_expand_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/secondary_expand_controller.dart';
import 'package:flutter_ty_app/app/modules/home/logic/home_controller_logic.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/home/models/league.dart';
import 'package:flutter_ty_app/app/modules/home/models/refresh_status.dart';
import 'package:flutter_ty_app/app/modules/home/models/sport_menu.dart';
import 'package:flutter_ty_app/app/modules/home/states/home_state.dart';
import 'package:flutter_ty_app/app/modules/home/views/common_match_list_view.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/manager/league_manager.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:flutter_ty_app/app/services/api/vr_sports_api.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

import '../../../global/user_controller.dart';
import '../../../services/api/menu_api.dart';
import '../../../services/models/req/match_list_req.dart';
import '../../../services/models/res/event_info_entity.dart';
import '../models/main_menu.dart';
import '../states/home_sport_menu_state.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool visiable = true;

  static HomeController get to => Get.find();
  HomeState homeState = HomeState();
  HomeSportMenuState homeSportMenuState = HomeSportMenuState();

  String globalRequestSessionKey = '';

  late PageController pageController;

  ScrollController commonScrollController = ScrollController();
  ScrollController championScrollController = ScrollController();
  ScrollController sportMenuController = ScrollController();

  // 默认隐藏
  bool showVrSportMenu = true;
  /// 列表item弹出提示数据
  List<EventInfo2Data> EventInfoList = [];

  @override
  void onInit() {
    pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    handleEventBus();
    ///菜单栏目球种数量变化时触发wS
    addListenerC301();
    super.onInit();
  }

  MatchHpsHlOl? firstMap;

  MatchHpsHlOl? lastMap;

  MatchHpsHlOl? setFirstMap(MatchHpsHlOl? firstMap) {
    this.firstMap = firstMap;
    return this.firstMap;
  }

  MatchHpsHlOl? setLastMap(MatchHpsHlOl? lastMap) {
    this.lastMap = lastMap;
    return this.lastMap;
  }

  @override
  void onReady() {
    super.onReady();
    fetchData();
    ///更新收藏数据
    CollectionController.to.fetchCollectionCount();
    ///球种列表
    List<SportMenu> sportMenuList = ConfigController.to.getSportMenuListByMenuMi(homeState.menu);
    homeSportMenuState.sportMenuList.value = sportMenuList;
    getEventInfo();

  }
  getEventInfo() async {
    try {
      final res = await MatchApi.instance().getEventInfo();
      if(ObjectUtil.isNotEmpty(res.data)){
        EventInfoList=res.data;
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void onClose() {
    removeBus();
    removeListenerC301();
    pageController.dispose();
    commonScrollController.dispose();
    championScrollController.dispose();
    super.onClose();
  }

  void search(String value) {
    if (ObjectUtil.isEmptyString(value)) {
      homeState.isSearch = false;
      homeState.combineList.clear();
      homeState.combineList =
          HomeControllerLogic.getMatchHandle(homeState.matchtSet);
      update();
      return;
    }
    homeState.isSearch = true;
    List<MatchEntity> searchMatchList = [];
    List<String> showMatchList = [];
    for (var element in homeState.matchtSet) {
      if (element.tn.contains(value) ||
          element.man.contains(value) ||
          element.mhn.contains(value)) {
        searchMatchList.add(element);
        showMatchList.add(element.mid);
      }
    }
    homeState.combineList.clear();
    homeState.combineList = HomeControllerLogic.getMatchHandle(searchMatchList);
    update();

    ///搜索出联赛结果 需要重新请求相关的联赛
    HomeControllerLogic.preLoadNextMatchBaseInfoList(showMatchList);
  }

  void removeMatch(String mid) {
    if (homeState.sportId == '50000') {
      homeState.matchtSet.removeWhere((element) => element.mid == mid);
      handleData();
    }
  }

  void removeMatchs(String tid) {
    if (homeState.sportId == '50000') {
      homeState.matchtSet.removeWhere((element) => element.tid == tid);
      handleData();
    }
  }

}


///////////////////////////////////////////////////////////////
////////////////          处理交互逻辑      //////////////////
///////////////////////////////////////////////////////////////
extension HomeControllerExtension on HomeController {
  _resetListState() {
    SecondaryController.index = 0;
    homeState.matchtSet.clear();
    homeState.combineList.clear();
    homeState.league = League.leagueList.first;
    update();
  }

  void changeDateTime(int? value) {
    Get.log('value = $value');
    _resetListState();
    homeState.dateTime = value;
    if (value != null) {
      homeState.matchListReq.md = value.toString();
    } else {
      homeState.matchListReq.md = null;
    }
    fetchData();
  }

  void changeMenu(MainMenu menu) {
    // 防止重复点击
    if (homeState.menu == menu) {
      return;
    }
    homeState.dateTime = null;
    if (menu.isMatchBet) {
      homeState.matchListReq.md = '0';
    } else {
      homeState.matchListReq.md = null;
    }
    if (menu.isChampion) {
      homeState.matchListReq.category = null;
      homeState.matchListReq.hpsFlag = null;
    } else {
      homeState.matchListReq.category = 1;
      homeState.matchListReq.hpsFlag = 0;
    }
    List<SportMenu> sportMenuList =
        ConfigController.to.getSportMenuListByMenuMi(menu);
    homeSportMenuState.sportMenuList.value = sportMenuList;
    String mi = homeState.sportId;
    String targetMi = homeState.sportId;

    /// 当前是冠军
    if (homeState.menu.isChampion) {
      targetMi = ((mi.toInt() - 400) + 100).toString();
    } else if (!homeState.menu.isChampion && menu.isChampion) {
      targetMi = ((mi.toInt() - 100) + 400).toString();
    }

    int index = sportMenuList.indexWhere((element) => element.mi == targetMi);
    if (index >= 0) {
      homeState.sportId = targetMi;
    } else {
      homeState.sportId = ConfigController.to.getFirstSportId(menu);
    }

    Get.log('changeMenu sportId = ${homeState.sportId}');
    homeState.menu = menu;
    _resetListState();
    Bus.getInstance().emit(
      EventType.leagueReset,
    );
    String euid = ConfigController.to.getOldSportId(homeState.sportId, menu.mi);

    /// 收藏的数据
    if (homeState.sportId == '50000') {
      List<SportMenu> sportMenus =
          ConfigController.to.getSportMenuListByMenuMi(menu);
      euid = sportMenus.first.euid;
    }

    homeState.matchListReq.euid = euid;
    homeState.matchListReq.type = menu.type;
    changeMenuSportEffect();

    /// 获取收藏的数据
    CollectionController.to.fetchCollectionCount();
    homeSportMenuState.leftShow.value = false;
    homeSportMenuState.rightShow.value = false;
    sportMenuController.animateTo(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
    update();
    fetchData();

    ShopCartController.to.changeMenuIndex(homeState.menu);
  }

  // 处理 切换menu 和 sport 的副作用处理 函数
  changeMenuSportEffect() {
    // 切换菜单 需要清空联赛tid
    homeState.matchListReq.tid = '';
    // 清空选择联赛数组
    LeagueManager.tid.clear();
  }

  Future<void> changeNew(bool value) async {
    homeState.isProfess = value;
    update();
    final res =
        await MenuApi.instance().setUserPersonaliseT(value == true ? 0 : 1);
    if (res.code.contains('0000000')) {
      BoolKV.userVersion.save(value);
    } else {
      ToastUtils.show(res.msg);
    }
  }

  Future<void> changeHot(bool value) async {
    BoolKV.sort.save(value);
    _resetListState();
    homeState.isHot = value;
    homeState.matchListReq.sort = value ? 1 : 2;
    fetchData(isSortChange: true);

    final res = await MenuApi.instance().rememberSelect(value == true ? 1 : 2);
    if (res.code.contains('0000000')) {
    } else {
      ToastUtils.show(res.msg);
    }
  }

  void changeSport(String sportId, String euid) {
    Get.log("changeSport sportId = $sportId euid = $euid");
    // 防止重复点击
    if (sportId == homeState.sportId) {
      return;
    }
    if (sportId == '50000') {
      CollectionController.to.fetchCollectionCount();
    }
    homeState.sportId = sportId;
    _resetListState();

    homeState.matchListReq.euid = euid;
    changeMenuSportEffect();

    fetchData();
  }
///切换联赛
  void changeLeague(League league) {
    homeState.league = league;
    _resetListState();
    if (league.tid == '0') {
      homeState.matchListReq.tid = null;
    } else {
      /// 没有找到匹配的tid，就用默认的
      homeState.matchListReq.tid =
          league.tids.isNotEmpty ? league.tids.join(',') : league.tid;
    }
    fetchData(isLeague: true);
  }

  void changeLanguage() {
    fetchData();
  }

  Future<void> refreshData() async {
    HomeControllerLogic.preLoadNextMatchBaseInfoList(
        DataStoreController.to.showMatchIdList);
  }
}

///////////////////////////////////////////////////////////////
////////////////          加载数据      //////////////////
///////////////////////////////////////////////////////////////
extension HomeControllerExtension1 on HomeController {
  /// 联赛列表请求不走元数据缓存
  fetchData(
      {bool isWsFetch = false,
      bool isLeague = false,
      bool isSortChange = false}) async {
    // vr 彩种数量

    String token = StringKV.token.get() ?? '';
    if(!isWsFetch && token.isNotEmpty) {
      // vr 彩种数量, 暂时屏蔽
      _getVrSportMenus();
    }

    ///  清理上次可视化，折叠的数据
    if (!isWsFetch) {
      DataStoreController.to.showMatchIdList.clear();
      Bus.getInstance().emit(EventType.scrollToTop);
      FoldMatchManager.clearFoldTids();
      FoldMatchManager.clearGroupFold();
    //SecondaryController.clearMap();//子玩法清除
    }
    Get.log('fetchData body ${homeState.matchListReq.toJson()}');
    homeState.isSearch = false;
    Bus.getInstance().emit(EventType.closeSearch, false);
    bool isCollection = homeState.sportId == '50000';
    globalRequestSessionKey =
        homeState.matchListReq.getRequestSessionKey(isCollection);
    String currentRequestSessionKey =
        homeState.matchListReq.getRequestSessionKey(isCollection);
    Get.log(
        "globalRequestSessionKey =1 $globalRequestSessionKey   currentRequestSessionKey = $currentRequestSessionKey");

    ///赛事循环请求列表
    try {
      bool noNeedOriginCache =
          isCollection || isWsFetch || isLeague || isSortChange;
      if (!noNeedOriginCache) {
        /// 从元数据取数据
        List<CombineInfo> combineInfoList = ConfigController.to.getMatchGroup(
            homeState.sportId,
            homeState.menu.mi,
            homeState.matchListReq.sort == 1);

        /// 元数据非空展示
        if (combineInfoList.isNotEmpty) {
          homeState.combineList.clear();
          update();
          Future(() {
            homeState.combineList.addAll(combineInfoList);
            homeState.refreshStatus = RefreshStatus.loadSuccess;
            update();
          });
        } else {
          homeState.refreshStatus = RefreshStatus.isLoading;
          update();
        }
      }

      /// 收藏和联赛和切换sort的请求走骨架屏逻辑
      if (isCollection || isLeague || isSortChange) {
        homeState.refreshStatus = RefreshStatus.isLoading;
        update();
      }

      /// 网络数据
      ApiRes<List<MatchEntity>> res;
      if (isCollection) {
        MatchListReq req = MatchListReq(
          cuid: UserController.to.getUid(),
          euid: homeState.matchListReq.euid,
          type: homeState.matchListReq.type,
          sort: homeState.matchListReq.sort,
          device: homeState.matchListReq.device,
        );
        req.category = null;
        req.hpsFlag = null;
        res = await MatchApi.instance().matchesCollectNewH5(req);
      } else {
        res = await MatchApi.instance().matches(homeState.matchListReq);
      }

      Get.log(
          "${globalRequestSessionKey == currentRequestSessionKey} globalRequestSessionKey =2  $globalRequestSessionKey   currentRequestSessionKey = $currentRequestSessionKey");
      if (globalRequestSessionKey != currentRequestSessionKey) {
        return;
      }

      if (res.data != null) {
        ConfigController.to.updateTopCount(res.data!.length, homeState.sportId);
      }

      if (res.success && ObjectUtil.isNotEmpty(res.data)) {
        homeState.combineList.clear();
        homeState.matchtSet.clear();
        homeState.matchtSet.addAll(res.data ?? []);
        handleData();
      } else if (isWsFetch) {
        /// ws的避免出现无数据的情况
        homeState.refreshStatus = RefreshStatus.loadSuccess;
        update();
      } else {
        homeState.matchtSet.clear();
        homeState.combineList.clear();
        homeState.refreshStatus = RefreshStatus.loadNoData;
        update();
      }
    } catch (e) {
      if (homeState.combineList.isEmpty) {
        homeState.refreshStatus = RefreshStatus.loadFailed;
        update();
      }
      Get.log('fetchData error: $e');
    } finally {}
  }

  handleData([isWs = false]) {
    if (homeState.matchtSet.isEmpty) {
      homeState.refreshStatus = RefreshStatus.loadNoData;
    } else {
      homeState.refreshStatus = RefreshStatus.loadSuccess;

      /// 冠军不用请求详情
      if (homeState.menu.isChampion) {
        for (var element in homeState.matchtSet) {
          DataStoreController.to.injectMatch(element);
        }
      } else {
        /// 数据分组
        homeState.combineList =
            HomeControllerLogic.getMatchHandle(homeState.matchtSet);

        if (!isWs) {
          /// 预加载下10条数据
          int endIndex = min(10, homeState.combineList.length);
          kLastIndex = endIndex;
          List<String> mids = HomeControllerLogic.getNextMatchIds(
              homeState.combineList, 0, endIndex);
          HomeControllerLogic.preLoadNextMatchBaseInfoList(
            mids,
          );
        }

        /// 说明是全部联赛的加载,从全部联赛中匹配到自己的tids
        if (ObjectUtil.isEmptyString(homeState.matchListReq.tid)) {
          League.resetAllTids();

          /// 重新计算联赛的tids
          for (var element in homeState.matchtSet) {
            for (var league in League.leagueList) {
              if (league.tid == '0') continue;
              String key = League.popular_leagues[league.alias]['key'];
              if (element.tn.contains(key)) {
                league.tids.add(element.tid);
              }
            }
          }
        }
      }
    }
    // [homeState.endScroll]
    update();
  }
}

extension HomeControllerVrSportMenus on HomeController {
  _getVrSportMenus() async {
    try {
      final res = await VrSportsApi.instance().getVrSportsMenus(
        'V1_H5',
        '${DateTime.now().millisecondsSinceEpoch}',
      );

      showVrSportMenu = res.data?.isNotEmpty == true;
      //debugPrint('showVrSportMenu: $showVrSportMenu');
      update();
    } catch (e) {
      debugPrint('getVrSportMenus error: $e');
    }
  }
}
