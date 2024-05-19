import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_view.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/settled_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/settled_bets_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/unsettled_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/unsettled_bets_view.dart';
import 'package:flutter_ty_app/app/services/api/vr_sports_api.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sports_menu_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/debounce_util.dart';

class VrHomeController extends GetxController with GetTickerProviderStateMixin {
  List<VrSportsMenuEntity> vrSportsMenus = [];
  final List<VrMatchEntity> matches = [];

  VrSportsMenuEntity? topMenu;
  VrSportsMenuEntity? subMenu;

  bool isAllExpand = true;

  bool isMatchesLoading = false;
  bool isLoadFailed = false;

  bool curMatchFinished = false;

  late AnimationController animationController;
  late Animation animation;

  late bool dailyActivities = false;

  late final DebounceUtil _debounce;

  int _getVirtualMatchesRetry = 3;

  @override
  void onInit() {
    registerBus();
    IconRefresh();
    _debounce = DebounceUtil(milliseconds: 200);
    super.onInit();
  }

  registerBus() {
    Bus.getInstance().on(EventType.changeLang, (wsObj) {
      ///回到首页
      Get.until((route) => route.settings.name == Routes.mainTab);
    });
    // 盘口设置
    Bus.getInstance().on(EventType.changeOddType, (_) {
      update();
    });
  }

  @override
  void onReady() {
    _getVrSportsMenus();
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
    _debounce.cancel();
    Bus.getInstance().off(EventType.changeOddType);
    super.onClose();
  }
}

extension VrHomeControllerAction on VrHomeController {
  void onAllExpandChanged(bool isExpand) {
    isAllExpand = isExpand;
    // 充值 item 的展开情况
    matches.forEach((element) {
      element.isExpand = isAllExpand;
    });
    update(['match_list']);
  }

  void onItemToggleExpand(bool isExpand, int index) {
    matches[index].isExpand = isExpand;
    isAllExpand = !matches.any((element) => element.isExpand == false);
    update(['match_list', 'all_expand_toggle']);
  }
}

extension VrHomeControllerPublicApi on VrHomeController {
  void onMenuChanged(VrSportsMenuEntity? topMenu, VrSportsMenuEntity? subMenu) {
    this.topMenu = topMenu;
    this.subMenu = subMenu;
    isAllExpand = true;
    update(['all_expand_toggle']);
    isMatchesLoading = true;
    _getVirtualMatchesRetry = 3;
    _getVirtualMatches();
  }

  onVideoPlayFinished() {
    if (curMatchFinished) return;
    curMatchFinished = true;
    update(['match_list']);
  }

  onNextMatchCountdownEnd() {
    _getVirtualMatchesRetry = 3;
    _getVirtualMatches();
  }

  Future<VrSportReplayEntity?> getVirtualReplay(VrMatchEntity vrMatch) async {
    return _getVirtualReplay(vrMatch);
  }

  Future<void> getMatchScore(String mids) async {
    return _getMatchScore(mids);
  }
}

extension _VrHomeControllerApi on VrHomeController {
  Future<void> _getVrSportsMenus() async {
    try {
      isLoadFailed = false;
      final res = await VrSportsApi.instance().getVrSportsMenus(
        'V1_H5',
        '${DateTime.now().millisecondsSinceEpoch}',
      );
      vrSportsMenus.assignAll(res.data ?? []);
      // 测试
      // vrSportsMenus
      //     .assignAll((res.data ?? []).where((element) => element.type == 2));
      update();

      topMenu = vrSportsMenus.firstOrNull;
      subMenu = topMenu?.subList.firstOrNull;

      // 内部会主动回调 onMenuChanged
      // _getVirtualMatches();
      //_getVirtualMatchesNew();
    } catch (e) {
      debugPrint('_getVrSportsMenus error: $e');
      if (e is DioException) {
        isMatchesLoading = false;
        isLoadFailed = true;
      } else {
        _debounce.run(() async {
          if (isClosed) return;
          await _getVrSportsMenus();
        });
      }
      update();
    }
  }

  Future<void> _getVirtualMatches() async {
    try {
      // isMatchesLoading = true;
      isLoadFailed = false;
      curMatchFinished = false;
      update(['match_list']);
      final res = await VrSportsApi.instance().getVirtualMatches(
        topMenu?.menuId ?? '',
        subMenu?.menuId ?? '',
        'KY_APP',
        '${DateTime.now().millisecondsSinceEpoch}',
      );
      // {"code":"0401038","data":null,"msg":"当前访问人数过多，请稍后再试","ts":1711699402649}
      if (res.code == '0401038') {
        _getVirtualMatchesRetry = 3;
        _getVirtualMatches();
        return;
      }
      matches.assignAll(res.data ?? []);
      // 第一份重复一份
      if (matches.isNotEmpty) {
        final first = VrMatchEntity.fromJson(matches.first.toJson());
        matches.insert(0, first);
      }
      matches.firstOrNull?.isExpand = true;
      isMatchesLoading = false;
      update(['match_list']);
    } catch (e) {
      debugPrint('_getVirtualMatches error: ${e.runtimeType}');
      if (_getVirtualMatchesRetry > 0) {
        _debounce.run(() async {
          if (isClosed) return;
          _getVirtualMatchesRetry--;
          await _getVirtualMatches();
        });
      } else {
        if (e is DioException) {
          isMatchesLoading = false;
          isLoadFailed = true;
          if (_getVirtualMatchesRetry > 0 && !isClosed) {
            await _getVirtualMatches();
          }
        } else {
          _debounce.run(() async {
            if (isClosed) return;
            _getVirtualMatchesRetry = 3;
            await _getVirtualMatches();
          });
        }
      }
      update(['match_list']);
    }
  }

  Future<VrSportReplayEntity?> _getVirtualReplay(VrMatchEntity vrMatch) async {
    try {
      final res = await VrSportsApi.instance().virtualReplay(
        vrMatch.batchNo,
        topMenu?.menuId ?? '',
        subMenu?.menuId ?? '',
        '${DateTime.now().millisecondsSinceEpoch}',
      );
      if (res.code == '0401038') {
        return await _getVirtualReplay(vrMatch);
      }
      return res.data;
    } catch (e) {
      debugPrint('getVirtualReplay error: $e');
      return await _getVirtualReplay(vrMatch);
    }
  }

  Future<void> _getMatchScore(String mids) async {
    final res = await VrSportsApi.instance().getMatchScore(
      mids,
      '${DateTime.now().millisecondsSinceEpoch}',
    );
    debugPrint('getMatchScore: ${res.data}');
  }

  Future<void> _getVirtualMatchesNew() async {
    isMatchesLoading = true;
    curMatchFinished = false;
    update(['match_list']);
    final res = await VrSportsApi.instance().getVirtualMatches(
      topMenu?.menuId ?? '',
      subMenu?.menuId ?? '',
      'KY_APP',
      '${DateTime.now().millisecondsSinceEpoch}',
    );
    matches.assignAll(res.data ?? []);
    matches.firstOrNull?.isExpand = true;
    isMatchesLoading = false;
    update(['match_list']);
  }
}

extension VrHomeControllerBottomNavigationBar on VrHomeController {
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

  void refreshMenu() {
    dailyActivities = BoolKV.dailyActivities.get() ?? false;
    if (dailyActivities == true) {
    } else {
      animationController.forward();
    }
  }

  void IconRefresh() {
    dailyActivities = BoolKV.dailyActivities.get() ?? false;
    update();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  }




  openMenu() {
    Get.lazyPut(() => SettingMenuController());
    Get.bottomSheet(
      const SettingMenuPage(),
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
    );
  }

}
