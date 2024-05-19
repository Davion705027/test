import 'dart:collection';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/hourly_task_runner.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';
import 'package:flutter_ty_app/app/modules/home/models/match_group.dart';
import 'package:flutter_ty_app/app/modules/home/models/sport_menu.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/api/base_data_api.dart';
import 'package:flutter_ty_app/app/services/models/res/access_config.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

import '../db/db_config.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/home/models/section_group_enum.dart';
import '../services/models/res/origin_data_entity.dart';
import '../services/models/res/team_entity.dart';
import '../utils/csid_util.dart';

class ConfigController extends GetxController {
  static ConfigController get to =>
      Get.put(ConfigController(), permanent: true);
  Rx<AccessConfig> accessConfig = AccessConfig().obs;

  List<SportConfigInfo> menuInit = [];
  //足球菜单列表
  List<SportConfigInfo> _sportMenuList = [];

  Map<String, dynamic> sportOldNewIdMap = oldNewIdMap;

  ///球种名称
  Map<String, dynamic> nameMap = nameInitMap;

  /// 元数据
  OriginDataEntity originData = OriginDataEntity();
  Map<String, dynamic> tournamentMatchMap = {};

  @override
  void onInit() {
    super.onInit();
    loadCache();

    Bus.getInstance().on(EventType.changeLang, (value) {
      fetchConfig();
    });

    /// 整点拉去元数据
    final taskRunner = HourlyTaskRunner();
    taskRunner.start();
  }

  @override
  void onClose() {
    Bus.getInstance().off(EventType.changeLang);
    super.onClose();
  }

  List<SportConfigInfo> get sportMenuList {
    if (_sportMenuList.isEmpty) {
      for (var item in menuInit) {
        if ((item.mi.toNum() ?? 0) < 200) {
          _sportMenuList.add(item);
        }
      }
    }
    return _sportMenuList;
  }
///显示vr菜单
  bool hasVrMenu() {
    bool hasVR = false;
    if (!menuInit.isEmpty) {
      for (var item in menuInit) {
        if ((item.mi.toNum() ?? 0) == 300) {
          hasVR = true;
        }
      }
    }
    Get.log("hasVR = $hasVR");
    return hasVR;
  }

  List<SportConfigInfo> get gameMenuList {
    List<SportConfigInfo> list = [];
    for (var item in menuInit) {
      var num = (item.mi.toNum() ?? 0);
      if (num > 2000 && num < 3000) {
        list.add(item);
      }
    }
    return list;
  }

  LinkedHashMap<String, SportConfigInfo> menuMap = LinkedHashMap();

  loadCache() {
    // 新旧id映射
    sportOldNewIdMap = oldNewIdMap;
    String? oldNewres = StringKV.OldNewId.get();
    if (!ObjectUtil.isEmptyString(oldNewres)) {
      sportOldNewIdMap = jsonDecode(oldNewres!) as Map<String, dynamic>;
    }

    // 球种国际化name映射
    nameMap = nameInitMap;
    String? nameRes = StringKV.nameMap.get();
    if (!ObjectUtil.isEmptyString(nameRes)) {
      nameMap = jsonDecode(nameRes!) as Map<String, dynamic>;
    }

    /// 菜单初始化
    menuInit = menuInitMap.map((e) => SportConfigInfo.fromJson(e)).toList();
    String? menuRes = StringKV.menuInit.get();
    if (!ObjectUtil.isEmptyString(menuRes)) {
      List<SportConfigInfo> menuList = (jsonDecode(menuRes!) as List)
          .map((e) => SportConfigInfo.fromJson(e))
          .toList();
      menuInit = menuList;
    }
    for (var item in menuInit) {
      menuMap[item.mi] = item;
    }

    /// 联赛数据
    tournamentMatchMap = loadTournameMatch;
    String? tournamentRes = StringKV.tournamentMatchMap.get();
    if (!ObjectUtil.isEmptyString(tournamentRes)) {
      tournamentMatchMap = jsonDecode(tournamentRes!) as Map<String, dynamic>;
    }
  }

  fetchConfig() async {
    try {
      loadMenuInit();
      loadMenuMapping();
      loadNameList();
      loadTournamentMatch();
      getAccessConfig();
      loadOriginData();
    } catch (e) {
      Get.log('error in fetchConfig: $e');
    }
  }

  LinkedHashMap<String, List<SportMenu>> sportMenuMap = LinkedHashMap();

  /// 根据menuId补充收藏和全部的euid
  List<SportMenu> getSportMenuListByMenuMi(MainMenu menu) {
    List<SportMenu> sportMenus = sportMenuMap[menu.mi.toString()] ?? [];
    if (sportMenus.isNotEmpty) {
      return sportMenus;
    }
    List<SportConfigInfo> sportConfigList = getSportConfigListByMenuId(menu);
    for (var item in sportConfigList) {
      /// 串关和早盘不支持电子足球和电子篮球
      if ((menu.isMatchBet || menu.isEarly) &&
          ['190', '191'].contains(item.mi)) {
        continue;
      }
      String mi = item.mi;
      String euid = getOldSportId(item.mi, menu.mi);
      /// 对应球类图标
      int iconIndex = SpriteImagesPosition.getPosition(item.mi, menu);
      ///对应球类名称
      String title = getName(item.mi);
      int? count = getCount(item.mi, menu.mi.toString());

      /// 全部：euid是将所有的id拼接，count所有的count累加
      if (item.mi == '100') {
        int sum = 0;
        List<String> euids = [];
        for (var item in sportMenuList) {
          sum += getCount(item.mi, menu.mi.toString()) ?? 0;
          String temp = getOldSportId(item.mi, menu.mi);
          if (!ObjectUtil.isEmptyString(temp)) {
            euids.add(temp);
          }
        }
        count = sum;
        euid = euids.join(',');
      }

      /// 收藏：euid是所有count非空的id拼接，count是接口获取
      if (item.mi == '50000') {
        List<String> euids = [];
        if (menu.isChampion) {
          sportConfigList.forEach((element) {
            String tempEuid = getOldSportId(element.mi, menu.mi);
            if (!ObjectUtil.isEmptyString(tempEuid)) {
              euids.add(tempEuid);
            }
          });
        } else {
          int total = 0;
          for (var sportMenuItem in sportMenuList) {
            int? tempCount = getCount(sportMenuItem.mi, menu.mi.toString());
            // Get.log('tempCount = $tempCount');
            if ((tempCount != null && tempCount > 0) /* || menu.isEarly*/) {
              total += tempCount!;
              String tempEuid = getOldSportId(sportMenuItem.mi, menu.mi);
              if (!ObjectUtil.isEmptyString(tempEuid)) {
                euids.add(tempEuid);
              }
            }
          }
          Get.log("total = $total");
        }
        euid = euids.join(',');
      }
      // 2000-电竞,300-vr,3000-真人,4000-彩票
      if (euid.isEmpty &&
          !['50000', '300', '2000', '3000', '4000'].contains(mi)) continue;
      SportMenu sportMenu = SportMenu(
          mi: mi, euid: euid, iconIndex: iconIndex, title: title, count: count);

      sportMenus.add(sportMenu);
    }
    sportMenuMap[menu.mi.toString()] = sportMenus;
    return sportMenus;
  }

  String getFirstSportId(MainMenu menu) {
    if (menu.isChampion) {
      SportConfigInfo? sportConfigInfo = menuMap[menu.mi.toString()];
      return sportConfigInfo?.sl?.safeFirst?.mi ?? '';
    } else {
      return sportMenuList.safeFirst?.mi ?? '';
    }
  }

  List<SportConfigInfo> getSportConfigListByMenuId(MainMenu menu) {
    List<SportConfigInfo> list = [];
    // 收藏
    SportConfigInfo collectSportConfig = SportConfigInfo();
    collectSportConfig.mi = '50000';

    // 全部
    SportConfigInfo allSportConfig = SportConfigInfo();
    allSportConfig.mi = '100';

    /// 今日早盘冠军仅有收藏
    if ([2, 3, 400].contains(menu.mi)) {
      list.add(collectSportConfig);

      /// 滚球收藏和全部
    } else if (menu.isPlay) {
      List<SportConfigInfo> tempList = [];
      tempList.add(collectSportConfig);
      tempList.add(allSportConfig);
      list.addAll(tempList);
    }
    // 如果是冠军的话取冠军的sl
    if (menu.isChampion) {
      SportConfigInfo? sportConfigInfo = menuMap.safe(menu.mi.toString());
      if (!ObjectUtil.isEmptyList(sportConfigInfo?.sl)) {
        list.addAll(sportConfigInfo!.sl!);
      }
    } else {
      // 其他的
      list.addAll(sportMenuList);
      if (sportMenuList.isEmpty) {
        return list;
      }
      //电竞和vr菜单位置
      int djIndex = 3;
      int vrIndex = 6;
      if (menu.isToday) {
        djIndex = 3;
        vrIndex = 6;
      }
      if (menu.isPlay) {
        djIndex = 4;
        vrIndex = 7;
      }
      if (menu.isEarly) {
        djIndex = 3;
        vrIndex = 4;
      }
      if (menu.isMatchBet) {
        djIndex = 2;
        vrIndex = 3;
      }

      // 添加电竞和VR体育  2000-电竞,300-vr,3000-真人,4000-彩票, 用户开关
      if (gameMenuList.isNotEmpty) {
        //后台管理控制电竞显示隐藏
        SportConfigInfo djSportConfigInfo = SportConfigInfo();
        djSportConfigInfo.mi = '2000';
        list.insert(djIndex, djSportConfigInfo);
      }
      ///添加 插入vr菜单
      if (hasVrMenu()) {
        SportConfigInfo vrSportConfigInfo = SportConfigInfo();
        vrSportConfigInfo.mi = '300';
        list.insert(vrIndex, vrSportConfigInfo);
      }
    }

    return list;
  }

  List<SportConfigInfo> getGameMenuListByMenuId() {
    List<SportConfigInfo> list = [];
    list.addAll(gameMenuList);
    ///收藏插入第一个位置
    if (ConfigController.to.accessConfig.value.collectSwitch) {
      SportConfigInfo collectSportConfig = SportConfigInfo();
      collectSportConfig.mi = '50000';
      list.insert(0, collectSportConfig);
    }
    return list;
  }
///更新球种赛事数量
  updateTopCount(int count, String mi) {
    List<SportMenu> sportMenuList = ConfigController.to
        .getSportMenuListByMenuMi(HomeController.to.homeState.menu);
    sportMenuList.forEach((element) {
      if (element.mi == mi) {
        element.count = count;
        CollectionController.to.update([mi]);
      }
    });
  }

  /// 根据sportID和一级菜单id找到对应的count
  int? getCount(String sportMi, String menuId) {
    if (['2000', '300'].contains(sportMi)) {
      return null;
    }
    String targetId = sportMi + menuId;
    // 冠军特殊处理
    if (menuId == '400') {
      targetId = sportMi;
      SportConfigInfo? sportConfigInfo = menuMap.safe(menuId);
      if (!ObjectUtil.isEmptyList(sportConfigInfo?.sl)) {
        for (var item in sportConfigInfo!.sl!) {
          if (item.mi == targetId) {
            return item.ct!;
          }
        }
      }
      return null;
    } else if (menuId == '2000') {
      //电竞
      if (sportMi == '50000') {
        //收藏
        return 0;
      }
      targetId = (/*menuId.toNum()! + */ sportMi.toNum()!).toString();
      // Get.log('targetId = $targetId');
      SportConfigInfo? sportConfigInfo = menuMap[targetId];
      List<int> ctList = [];
      if (!ObjectUtil.isEmptyList(sportConfigInfo?.sl)) {
        for (var item in sportConfigInfo!.sl!) {
          if (item.mi == "${targetId}2" || item.mi == "${targetId}3") {
            //电竞为两个之和
            ctList.add(item.ct!);
          }
        }
      }
      return ctList.length == 2 ? ctList[0] + ctList[1] : 0;
    } else {
      if (menuMap[sportMi] != null) {
        List<SportConfigInfo>? sl = menuMap[sportMi]?.sl;
        if (!ObjectUtil.isEmptyList(sl)) {
          for (var item in sl!) {
            if (item.mi == targetId) {
              return item.ct!;
            }
          }
        }
      }
    }
    return null;
  }

  /// 根据sportID找到对应的name
  String getName(String sportMi) {
    if (nameMap[sportMi] != null) {
      return nameMap[sportMi];
    }
    if (sportMi == '50000') {
      return LocaleKeys.footer_menu_collect.tr;
    }
    if (sportMi == '100') {
      return LocaleKeys.app_h5_match_all.tr;
    }
    if (sportMi == '2000') {
      return LocaleKeys.menu_itme_name_esports.tr;
    }
    if (sportMi == '300') {
      return LocaleKeys.common_virtual_sports.tr;
    }
    return '';
  }

  /// 新旧id映射
  String getOldSportId(String sportMi, int menuMi) {
    try {
      String targetId = getTargetId(sportMi, menuMi);
      if (sportOldNewIdMap[targetId] != null) {
        return sportOldNewIdMap[targetId]['h'];
      }
      Get.log('sportMi $sportMi menuMi $menuMi');
      return '';
    } catch (e) {
      Get.log('sportOldNewIdMap error: $sportOldNewIdMap');
      return '';
    }
  }

  String getTargetId(String sportMi, int menuMi) {
    String targetId;
    if (menuMi == 400) {
      // Get.log("冠军 sportMi =$sportMi   menuMi =$menuMi  ");
      targetId = sportMi.toString();
    } else {
      targetId = sportMi + menuMi.toString();
    }
    return targetId;
  }

  int? getDjEuid(String mi) {
    // 电竞无旧菜单id处理
    return {
      "2100": 41002,
      "2101": 41001,
      "2102": 41004,
      "2103": 41003,
    }[mi];
  }
}

///////////////////////////////////////////////////////////////
////////////////          菜单元数据      //////////////////
///////////////////////////////////////////////////////////////
extension ConfigControllerMenu on ConfigController {
  Future<void> loadMenuMapping() async {
    try {
      final res = await BaseDataApi.instance().loadMenuMapping({});
      if (res.success && res.data != null) {
        sportOldNewIdMap = res.data!;
        StringKV.OldNewId.save(jsonEncode(sportOldNewIdMap));
      }
    } catch (e) {}
  }

  // 获取球种国际化name映射
  Future loadNameList({bool switchLanguages = false}) async {
    try {
      ApiRes value = await BaseDataApi.instance().loadNameList({});
      if (value.success && value.data != null) {
        nameMap = value.data!;
        StringKV.nameMap.save(jsonEncode(nameMap));
      }
      if (switchLanguages) {
        HomeController.to.update();
      }
    } catch (e) {
      print('获取菜单国际化失败');
      print(e);
    }
  }

  Future<void> getAccessConfig() async {
    try {
      final res = await BaseDataApi.instance().getAccessConfig();
      if (res.success && res.data != null) {
        accessConfig.value = res.data!;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadMenuInit() async {
    try {
      ApiRes<List<SportConfigInfo>> ret =
          await BaseDataApi.instance().getMenuInit();
      if (ret.success && ret.data != null) {
        List<SportConfigInfo> menuList = ret.data!;
        for (var item in menuList) {
          menuMap[item.mi] = item;
        }
        menuInit = menuList;

        /// 存到本地
        List<Map<String, dynamic>> res =
            ret.data!.map((e) => e.toJson()).toList();
        StringKV.menuInit.save(jsonEncode(res));
      }
    } catch (e) {}
  }

  Future<void> loadOriginData() async {
    try {
      final res = await BaseDataApi.instance().getOriginalData();
      if (res.success) {
        originData = res.data!;

        /// 缓存本地
        StringKV.originData.save(jsonEncode(originData.toJson()));
      }
    } catch (e) {
      Get.log('error in fetchOriginData: $e');
    }
  }

  Future<void> loadTournamentMatch() async {
    try {
      final res = await BaseDataApi.instance().loadTournamentMatch({});
      if (res.success) {
        tournamentMatchMap = res.data!;

        /// 缓存本地
        StringKV.tournamentMatchMap.save(jsonEncode(tournamentMatchMap));
      }
    } catch (e) {
      Get.log('error in fetchOriginData: $e');
    }
  }
}

///////////////////////////////////////////////////////////////
////////////////          根据sportID和菜单menuid获取列表元数据      //////////////////
///////////////////////////////////////////////////////////////
extension ConfigControllerX on ConfigController {
  List<CombineInfo> getMatchGroup(String sportId, int menuId, bool isTidGroup) {
    try {
      String targetId = getTargetId(sportId, menuId);
      Map<String, dynamic> map = tournamentMatchMap[targetId] ?? {};
      if (map.isEmpty) {
        targetId = targetId + '01';
        map = tournamentMatchMap[targetId] ?? {};
      }
      if (ObjectUtil.isEmpty(map)) return [];

      List<MatchGroup> matchGroupList = [];
      if (!map.containsKey('nd') && !map.containsKey('ld')) {
        List mapList = map.values.toList().safeFirst ?? [];
        List<Map<String, dynamic>> list = [];
        for (var element in mapList) {
          list.add(element as Map<String, dynamic>);
        }
        matchGroupList = _handleList(list, SectionGroupEnum.ALL, isTidGroup);
        matchGroupList.safeFirst?.isSectionHeader = true;
        matchGroupList.safeFirst?.isSportHeader = true;
      } else {
        List<Map<String, dynamic>> nd = JsonUtil.getObjectList(
                map['nd'], (v) => v as Map<String, dynamic>) ??
            [];
        List<Map<String, dynamic>> ld = JsonUtil.getObjectList(
                map['ld'], (v) => v as Map<String, dynamic>) ??
            [];
        List<MatchGroup> ndList =
            _handleList(nd, SectionGroupEnum.IN_PROGRESS, isTidGroup);
        ndList.safeFirst?.isSectionHeader = true;
        ndList.safeFirst?.isSportHeader = true;
        List<MatchGroup> ldList =
            _handleList(ld, SectionGroupEnum.NOT_STARTED, isTidGroup);
        ldList.safeFirst?.isSectionHeader = true;
        ldList.safeFirst?.isSportHeader = true;
        matchGroupList.addAll(ndList);
        matchGroupList.addAll(ldList);
      }
      return CombineInfo.generateFromList(matchGroupList);
    } catch (e) {
      Get.log('getMatchGroup error: $e');
      return [];
    }
  }

  List<MatchGroup> _handleList(List<Map<String, dynamic>> list,
      SectionGroupEnum sectionGroupEnum, bool isTidGroup) {
    try {
      List<MatchGroup> matchGroupList = [];
      int totalNum = 0;
      for (var item in list) {
        String tid = item['tid'];
        TeamEntity? teamEntity = originData.tidsObj
            .firstWhereOrNull((element) => element.tid == tid);
        List<String> mids = item['mids'].cast<String>();
        List<MatchEntity> matchList = originData.matchsList
            .where((element) => mids.contains(element.mid))
            .toList();
        if (matchList.isEmpty) continue;
        String csna = originData.spList
                .firstWhereOrNull((element) =>
                    element.csid == (matchList.safeFirst?.csid ?? ''))
                ?.csna ??
            '';
        totalNum += matchList.length;
        if (isTidGroup) {
          MatchGroup matchGroup = MatchGroup(
              tn: teamEntity?.tn ?? '',
              tid: tid,
              matches: matchList,
              isSectionHeader: false,
              sectionGroupEnum: sectionGroupEnum,
              isSportHeader: false,
              sportTitle: csna,
              sportCount: matchList.length,
              csid: matchList.safeFirst?.csid ?? '');
          matchGroupList.add(matchGroup);
        } else {
          matchGroupList.addAll(
            matchList
                .map(
                  (e) => MatchGroup(
                      tn: teamEntity?.tn ?? '',
                      tid: tid,
                      matches: [e],
                      isSectionHeader: false,
                      sectionGroupEnum: sectionGroupEnum,
                      isSportHeader: false,
                      sportTitle: csna,
                      sportCount: matchList.length,
                      csid: e.csid ?? ''),
                )
                .toList(),
          );
        }
      }
      matchGroupList.safeFirst?.sportCount = totalNum;
      return matchGroupList;
    } catch (e) {
      Get.log('handleList error: $e');
      return [];
    }
  }
}
