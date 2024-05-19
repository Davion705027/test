import 'dart:collection';
import 'dart:math';

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/home/models/match_group.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../services/api/match_api.dart';
import '../models/section_group_enum.dart';

class HomeControllerLogic {

  /// 赛事分组,按时间的
  static List<CombineInfo> getTimeMatchHandle(List<MatchEntity> matchList) {
    /// 今日和串关的才分组进行中未开始
    if (HomeController.to.homeState.menu.isToday ||
        (HomeController.to.homeState.menu.isMatchBet &&
            (HomeController.to.homeState.dateTime ?? 0) <= 0)) {
      /// 赛事归类开赛未开赛
      List<MatchEntity> startMatchList = [];
      List<MatchEntity> noStartMatchList = [];
      // 今日/串关下面：开始。未开始 (才分组）
      // 其他显示全部

      for (var element in matchList) {
        element = DataStoreController.to.getMatchById(element.mid) ?? element;

        /// 滚球阶段
        if ([1, 110].contains(element.ms)) {
          element.startFlag = 3;
          startMatchList.add(element);
        } else {
          element.startFlag = 4;
          noStartMatchList.add(element);
        }
      }

      /// 将startMatchList中相邻tid一样的赛事组合成MatchGroup
      List<MatchGroup> startMatchGroup = [];
      String lastTid = '';
      for (var element in startMatchList) {
        element = DataStoreController.to.getMatchById(element.mid) ?? element;
        if (element.tid == lastTid) {
          ///开始中的比赛分组
          startMatchGroup.last.matches.add(element);
        } else {
          MatchGroup matchGroup = MatchGroup(
            tn: element.tn,
            tid: element.tid,
            matches: [element],
            isSectionHeader: false,
            sectionGroupEnum: SectionGroupEnum.IN_PROGRESS,
            isSportHeader: false,
            sportTitle: element.csna,
            sportCount: startMatchList.length,
            csid: element.csid,
          );
          startMatchGroup.add(matchGroup);
          lastTid = element.tid;
        }
      }

      /// 进行中的球类分组
      LinkedHashMap<String, List<MatchGroup>> startSportMap = LinkedHashMap();
      for (var element in startMatchGroup) {
        if (startSportMap.containsKey(element.csid)) {
          startSportMap[element.csid]?.add(element);
        } else {
          startSportMap[element.csid] = [element];
        }
      }

      List<MatchGroup> startList = [];
      startSportMap.forEach((key, value) {
        List<MatchGroup> tempList = value;
        tempList.safeFirst?.isSportHeader = true;
        int sportCount = 0;

        /// 球类数量
        value.forEach((element) {
          sportCount += element.matches.length;
        });
        tempList.safeFirst?.sportCount = sportCount;
        startList.addAll(tempList);
      });
      startList.safeFirst?.isSectionHeader = true;

      /// 将noStartMatchList中相邻tid一样的赛事组合成MatchGroup
      List<MatchGroup> noStartMatchGroup = [];
      String noStartLastTid = '';
      for (var element in noStartMatchList) {
        element = DataStoreController.to.getMatchById(element.mid) ?? element;
        if (element.tid == noStartLastTid) {
          noStartMatchGroup.last.matches.add(element);
        } else {
          MatchGroup matchGroup = MatchGroup(
            tn: element.tn,
            tid: element.tid,
            matches: [element],
            isSectionHeader: false,
            sectionGroupEnum: SectionGroupEnum.NOT_STARTED,
            isSportHeader: false,
            sportTitle: element.csna,
            sportCount: noStartMatchList.length,
            csid: element.csid,
          );
          noStartMatchGroup.add(matchGroup);
          noStartLastTid = element.tid;
        }
      }

      /// 未开始的球类分组
      LinkedHashMap<String, List<MatchGroup>> noStartSportMap = LinkedHashMap();
      for (var element in noStartMatchGroup) {
        if (noStartSportMap.containsKey(element.csid)) {
          noStartSportMap[element.csid]?.add(element);
        } else {
          noStartSportMap[element.csid] = [element];
        }
      }
      List<MatchGroup> noStartList = [];
      noStartSportMap.forEach((key, value) {
        List<MatchGroup> tempList = value;
        tempList.safeFirst?.isSportHeader = true;
        int sportCount = 0;
        value.forEach((element) {
          sportCount += element.matches.length;
        });
        tempList.safeFirst?.sportCount = sportCount;
        noStartList.addAll(tempList);
      });
      noStartList.safeFirst?.isSectionHeader = true;
      return CombineInfo.generateFromList(startList..addAll(noStartList));
    } else {
      /// 将startMatchList中相邻tid一样的赛事组合成MatchGroup
      List<MatchGroup> allMatchGroup = [];
      String lastTid = '';

      /// tid一致的联赛分组
      for (var element in matchList) {
        element = DataStoreController.to.getMatchById(element.mid) ?? element;
        if (element.tid == lastTid) {
          allMatchGroup.last.matches.add(element);
        } else {
          MatchGroup matchGroup = MatchGroup(
            tn: element.tn,
            tid: element.tid,
            matches: [element],
            isSectionHeader: false,
            sectionGroupEnum: SectionGroupEnum.ALL,
            sportTitle: element.csna,
            sportCount: matchList.length,
            isSportHeader: false,
            csid: element.csid,
          );
          allMatchGroup.add(matchGroup);
          lastTid = element.tid;
        }
      }

      /// 球类分组
      LinkedHashMap<String, List<MatchGroup>> sportMatchGroupMap =
          LinkedHashMap();
      for (var element in allMatchGroup) {
        if (sportMatchGroupMap.containsKey(element.csid)) {
          sportMatchGroupMap[element.csid]!.add(element);
        } else {
          sportMatchGroupMap[element.csid] = [element];
        }
      }

      List<MatchGroup> list = [];
      sportMatchGroupMap.forEach((key, value) {
        List<MatchGroup> tempList = value;
        tempList.safeFirst?.isSportHeader = true;
        int sportCount = 0;

        /// 球类数量
        for (var element in value) {
          sportCount += element.matches.length;
        }
        tempList.safeFirst?.sportCount = sportCount;
        list.addAll(tempList);
      });
      list.safeFirst?.isSectionHeader = true;

      return CombineInfo.generateFromList(list);
    }
  }

  /// 赛事分组，按热度的
  static List<CombineInfo> getHotMatchHandle(List<MatchEntity> matchList) {
    /// 今日和串关的才分组进行中未开始
    if (HomeController.to.homeState.menu.isToday ||
        (HomeController.to.homeState.menu.isMatchBet &&
            (HomeController.to.homeState.dateTime ?? 0) <= 0)) {
      /// 赛事归类开赛未开赛
      List<MatchEntity> startMatchList = [];
      List<MatchEntity> noStartMatchList = [];
      // 今日/串关下面：开始。未开始 (才分组）
      // 其他显示全部
      for (var element in matchList) {
        element = DataStoreController.to.getMatchById(element.mid) ?? element;

        /// 滚球阶段
        if ([1, 110].contains(element.ms)) {
          element.startFlag = 3;
          startMatchList.add(element);
        } else {
          element.startFlag = 4;
          noStartMatchList.add(element);
        }
      }

      /// 将startMatchList中所有tid一样的赛事组合成MatchGroup
      LinkedHashMap<String, MatchGroup> startMatchMap = LinkedHashMap();
      for (var element in startMatchList) {
        element = DataStoreController.to.getMatchById(element.mid) ?? element;

        if (startMatchMap.containsKey(element.tid)) {
          startMatchMap[element.tid]!.matches.add(element);
        } else {
          MatchGroup matchGroup = MatchGroup(
            tn: element.tn,
            tid: element.tid,
            matches: [element],
            isSectionHeader: false,
            sectionGroupEnum: SectionGroupEnum.IN_PROGRESS,
            isSportHeader: false,
            sportTitle: element.csna,
            sportCount: startMatchList.length,
            csid: element.csid,
          );
          startMatchMap[element.tid] = matchGroup;
        }
      }

      /// 进行中的球类分组
      LinkedHashMap<String, List<MatchGroup>> startSportMap = LinkedHashMap();
      for (var element in startMatchMap.values) {
        if (startSportMap.containsKey(element.csid)) {
          startSportMap[element.csid]?.add(element);
        } else {
          startSportMap[element.csid] = [element];
        }
      }

      List<MatchGroup> startList = [];
      startSportMap.forEach((key, value) {
        List<MatchGroup> tempList = value;
        tempList.safeFirst?.isSportHeader = true;
        int sportCount = 0;

        /// 球类数量
        value.forEach((element) {
          sportCount += element.matches.length;
        });
        tempList.safeFirst?.sportCount = sportCount;
        startList.addAll(tempList);
      });
      startList.safeFirst?.isSectionHeader = true;

      /// 将noStartMatchList中所有tid一样的赛事组合成MatchGroup   未开始比赛
      LinkedHashMap<String, MatchGroup> noStartMatchMap = LinkedHashMap();
      for (var element in noStartMatchList) {
        if (noStartMatchMap.containsKey(element.tid)) {
          noStartMatchMap[element.tid]!.matches.add(element);
        } else {
          MatchGroup matchGroup = MatchGroup(
            tn: element.tn,
            tid: element.tid,
            matches: [element],
            isSectionHeader: false,
            sectionGroupEnum: SectionGroupEnum.NOT_STARTED,
            isSportHeader: false,
            sportTitle: element.csna,
            sportCount: noStartMatchList.length,
            csid: element.csid,
          );
          noStartMatchMap[element.tid] = matchGroup;
        }
      }

      /// 未开始的球类分组
      LinkedHashMap<String, List<MatchGroup>> noStartSportMap = LinkedHashMap();
      for (var element in noStartMatchMap.values) {
        if (noStartSportMap.containsKey(element.csid)) {
          noStartSportMap[element.csid]?.add(element);
        } else {
          noStartSportMap[element.csid] = [element];
        }
      }
      List<MatchGroup> noStartList = [];
      noStartSportMap.forEach((key, value) {
        List<MatchGroup> tempList = value;
        tempList.safeFirst?.isSportHeader = true;
        int sportCount = 0;
        value.forEach((element) {
          sportCount += element.matches.length;
        });
        tempList.safeFirst?.sportCount = sportCount;
        noStartList.addAll(tempList);
      });
      noStartList.safeFirst?.isSectionHeader = true;
      return CombineInfo.generateFromList(startList..addAll(noStartList));
    } else {
      /// 将startMatchList中所有tid一样的赛事组合成MatchGroup
      LinkedHashMap<String, MatchGroup> allMatchMap = LinkedHashMap();

      /// tid一致的联赛分组
      for (var element in matchList) {
        element = DataStoreController.to.getMatchById(element.mid) ?? element;

        if (allMatchMap.containsKey(element.tid)) {
          allMatchMap[element.tid]!.matches.add(element);
        } else {
          MatchGroup matchGroup = MatchGroup(
            tn: element.tn,
            tid: element.tid,
            matches: [element],
            isSectionHeader: false,
            sectionGroupEnum: SectionGroupEnum.ALL,
            sportTitle: element.csna,
            sportCount: matchList.length,
            isSportHeader: false,
            csid: element.csid,
          );
          allMatchMap[element.tid] = matchGroup;
        }
      }

      /// 球类分组
      LinkedHashMap<String, List<MatchGroup>> sportMatchGroupMap =
          LinkedHashMap();
      for (var element in allMatchMap.values) {
        if (sportMatchGroupMap.containsKey(element.csid)) {
          sportMatchGroupMap[element.csid]!.add(element);
        } else {
          sportMatchGroupMap[element.csid] = [element];
        }
      }

      List<MatchGroup> list = [];
      sportMatchGroupMap.forEach((key, value) {
        List<MatchGroup> tempList = value;
        tempList.safeFirst?.isSportHeader = true;
        int sportCount = 0;

        /// 球类数量
        for (var element in value) {
          sportCount += element.matches.length;
        }
        tempList.safeFirst?.sportCount = sportCount;
        list.addAll(tempList);
      });
      list.safeFirst?.isSectionHeader = true;

      return CombineInfo.generateFromList(list);
    }
  }

  /// 赛事分组
  /// 今日和串关的才分组进行中未开始
  /// 其他显示全部
  /// 进行中的未开始的全部的大分组下面
  /// 将tid相同的组合为matchgroup
  /// csid相同的归位一组显示球类标题
  /// 分组
  static List<CombineInfo> getMatchHandle(List<MatchEntity> matchList) {
    if (HomeController.to.homeState.isHot) {
      return getHotMatchHandle(matchList);
    } else {
      return getTimeMatchHandle(matchList);
    }
  }

  /// 获取下次的赛事ids
  static List<String> getNextMatchIds(
    List<CombineInfo> combineList,
    int startIndex,
    int endIndex,
  ) {
    List<String> mids = [];
    int targetEndIndex = min(endIndex, combineList.length - 1);
    for (int i = startIndex; i <= targetEndIndex; i++) {
      /// 如果是展开的，就加入
      CombineInfo combineInfo = combineList.elementAt(i);
      if (combineInfo.type == CombineType.matchWithHeader ||
          combineInfo.type == CombineType.match) {
        mids.add(combineInfo.data!.mid);
      }
    }
    return mids;
  }

  static Set<String> sMidList = HashSet();

  /// 单独加载主动被展开的赛事
  static preLoadOnlyMatchGroupBaseInfoList(List<String> midList) async {
    try {
      if (midList.isEmpty) return;
      DataStoreController.to.setShowMatchIdList(midList, needMerge: true);

      String mids = midList.join(',');
      final res = await MatchApi.instance().getMatchBaseInfo(
        mids,
        UserController.to.getUid(),
        HomeController.to.homeState.matchListReq.sort,
        null,
        'v2_h5_st',
        null,
        null,
        null,
       /*   "0",
          null,
          0,*/
          []
      );

      if (res.success && res.data != null) {
        for (var element in res.data!) {
          DataStoreController.to.updateMatch(element, keepSecondary: true);
        }
      }
    } catch (e) {
      Get.log('preLoadOnlyMatchGroupBaseInfoList error: $e');
    }
  }

  /// 加载下10条赛事基本信息
  static Future<void> preLoadNextMatchBaseInfoList(List<String> midList,
      [bool needMerge = false]) async {
    try {
      Get.log('preLoadNextMatchBaseInfoList: $midList');
      if (midList.isEmpty) {
        return;
      }
      DataStoreController.to.setShowMatchIdList(midList, needMerge: needMerge);
      String mids = midList.join(',');
      final res = await MatchApi.instance().getMatchBaseInfo(
        mids,
        UserController.to.getUid(),
        HomeController.to.homeState.matchListReq.sort,
        null,
        'v2_h5_st',
        null,
        null,
        null,
     /*   "0",
        null,
        0,*/
        []
      );
      if (res.success && res.data != null) {
        for (var element in res.data!) {
          DataStoreController.to
              .updateMatch(element, keepSecondary: !needMerge);
        }
      }
    } catch (e) {
      Get.log('preLoadNext10MatchBaseInfoList error: $e');
    } finally {}
  }
}
