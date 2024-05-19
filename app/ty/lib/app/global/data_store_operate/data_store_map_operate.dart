import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/widgets/scroll_index_widget.dart';
import 'package:get/get.dart';

extension DataStoreControllerX on DataStoreController {
  ///可视化数据插入方法
  setShowMatchIdList(List<String> showList,
      {needMerge = false, String pageRouteKey = otherPageKey}) {
    if (pageKey != pageRouteKey) return;
    if (!needMerge) {
      showMatchIdList = showList;
    } else {
      showMatchIdList.addAll(showList);
      showMatchIdList = showMatchIdList.toSet().toList();
    }
  }

  injecthowMatchIdByMatchEntity(String mid) {
    if (!showMatchIdList.contains(mid)) {
      showMatchIdList.add(mid);
    }
  }

  injecthowMatchIdListByMatchEntity(List<MatchEntity> matchList,
      {needMerge = false, String pageRouteKey = otherPageKey}) {
    List<String> matchIdList = [];
    matchList.forEach((MatchEntity match) {
      matchIdList.add(match.mid);
    });
    if (matchIdList.isNotEmpty) {
      setShowMatchIdList(matchIdList,
          needMerge: needMerge, pageRouteKey: pageRouteKey);
    }
  }

  ///============================================== 增加 ==============================================///
  injectMatch(MatchEntity matchEntity) {
    ///添加后 更新UI
    matchMap[getMatchId(matchEntity.mid)] = matchEntity;
    for (var element in matchEntity.hps) {
      for (var element in element.hl) {
        hlMap[getHid(element.hid)] = element;
      }
    }
    bool homeUpdatable = Get.isRegistered<HomeController>() && HomeController.to.visiable &&
        HomeController.to.homeState.endScroll &&
        showMatchIdList.contains(matchEntity.mid);

    ///滚动只插入数据 不更新UI
    update([getMatchId(matchEntity.mid), homeUpdatable]);
  }

  injectHl(MatchHpsHl hlEntity) {
    if (!hlMap.keys.contains(getHid(hlEntity.hid))) {
      ///添加后 更新UI
      hlMap[getHid(hlEntity.hid)] = hlEntity;
      for (var element in hlEntity.ol) {
        injectOl(element);
      }
    }
  }

  injectOl(MatchHpsHlOl olEntity) {
    if (!olMap.keys.contains(getOid(olEntity.oid))) {
      ///添加后 更新UI
      olMap[getOid(olEntity.oid)] = olEntity;
    } else {
      String on = olEntity.on;
      String obn = olEntity.onb;
      MatchHpsHlOl? oldOl = olMap[getOid(olEntity.oid)];
      if (oldOl?.on != on || oldOl?.onb != obn) {
        ///滚动只插入数据 不更新UI
        if (!isScrolling) {
          updateOl(olEntity);
        }
      }
    }
  }

  ///===================================================================================///

  ///============================================== 更新 ==============================================///
  updateMatch(MatchEntity matchEntityity, {bool keepSecondary = false}) {
    ///修改后 更新UI
    if (keepSecondary) {
      MatchEntity? oldMatchEntity = matchMap[getMatchId(matchEntityity.mid)];

      ///角球
      if (matchEntityity.hpsCorner.isEmpty) {
        matchEntityity.hpsCorner.addAll(oldMatchEntity?.hpsCorner ?? []);
        foreach(matchEntityity.hpsCorner);
        // injectOl(olEntity)
      }

      ///15分钟
      if (matchEntityity.hps15Minutes.isEmpty) {
        matchEntityity.hps15Minutes.addAll(oldMatchEntity?.hps15Minutes ?? []);
        foreach(matchEntityity.hps15Minutes);
      }

      ///特色组合数据
      if (matchEntityity.hpsCompose.isEmpty) {
        matchEntityity.hpsCompose.addAll(oldMatchEntity?.hpsCompose ?? []);
        foreach(matchEntityity.hpsCompose);
      }

      ///波胆数据
      if (matchEntityity.hpsBold.isEmpty) {
        matchEntityity.hpsBold.addAll(oldMatchEntity?.hpsBold ?? []);
        foreach(matchEntityity.hpsBold);
      }

      //*更新数据*/
      ///罚牌
      if (matchEntityity.hpsPunish.isEmpty) {
        matchEntityity.hpsPunish.addAll(oldMatchEntity?.hpsPunish ?? []);
        foreach(matchEntityity.hpsPunish);
      }

      ///晋级赛
      if (matchEntityity.hpsPromotion.isEmpty) {
        matchEntityity.hpsPromotion.addAll(oldMatchEntity?.hpsPromotion ?? []);
        foreach(matchEntityity.hpsPromotion);
      }

      ///冠军
      if (matchEntityity.hpsOutright.isEmpty) {
        matchEntityity.hpsOutright.addAll(oldMatchEntity?.hpsOutright ?? []);
        foreach(matchEntityity.hpsOutright);
      }

      ///加时赛
      if (matchEntityity.hpsOvertime.isEmpty) {
        matchEntityity.hpsOvertime.addAll(oldMatchEntity?.hpsOvertime ?? []);
        foreach(matchEntityity.hpsOvertime);
      }

      ///点球大战
      if (matchEntityity.hpsPenalty.isEmpty) {
        matchEntityity.hpsPenalty.addAll(oldMatchEntity?.hpsPenalty ?? []);
        foreach(matchEntityity.hpsPenalty);
      }
    }

    matchMap[getMatchId(matchEntityity.mid)] = matchEntityity;
    foreach(matchEntityity.hps);

    /// 在首页且滚动结束时才更新UI
    bool homeUpdatable =
      Get.isRegistered<HomeController>() && HomeController.to.visiable && HomeController.to.homeState.endScroll;

    ///滚动只插入数据 不更新UI
    if (!isScrolling) {
      update([getMatchId(matchEntityity.mid), homeUpdatable]);
    }
  }

  foreach(List<MatchHps> hpsList) {
    hpsList.forEach((MatchHps hl) {
      hl.hl.forEach((MatchHpsHl hpsHl) {
        hpsHl.ol.forEach((MatchHpsHlOl ol) {
          injectOl(ol);
        });
      });
    });
  }

  updateHl(MatchHpsHl hlEntity) {
    ///修改后 更新UI
    hlMap[getHid(hlEntity.hid)] = hlEntity;
    bool homeUpdatable =
      Get.isRegistered<HomeController>() && HomeController.to.visiable && HomeController.to.homeState.endScroll;

    ///滚动只插入数据 不更新UI
    if (!isScrolling) {
      update([getHid(hlEntity.hid), homeUpdatable]);
    }
  }

  updateOl(MatchHpsHlOl olEntity) {
    ///修改后 更新UI
    olMap[getOid(olEntity.oid)] = olEntity;
    bool homeUpdatable =
        Get.isRegistered<HomeController>() && HomeController.to.visiable && HomeController.to.homeState.endScroll;

    ///滚动只插入数据 不更新UI
    if (!isScrolling) {
      update([getOid(olEntity.oid), homeUpdatable]);
    }

  }

  ///===================================================================================///

  ///============================================== 查询 ==============================================///

  MatchEntity? getMatchById(String mid) {
    return matchMap[getMatchId(mid)];
  }

  MatchHpsHl? getHlById(String hid) {
    return hlMap[getHid(hid)];
  }

  MatchHpsHlOl? getOlById(String oid) {
    return olMap[getOid(oid)];
  }

  ///===================================================================================///

  ///============================================== 删除 ==============================================///

  removeMatchById(String mid) {
    matchMap.remove(getMatchId(mid));
  }

  removeHlById(String hid) {
    hlMap.remove(getHid(hid));
  }

  removeOlById(String oid) {
    olMap.remove(getOid(oid));
  }

  ///===================================================================================///
  ///
  String getMatchId(String mid) {
    return MATCH_ID + mid;
  }

  String getHid(String hid) {
    return HID + hid;
  }

  String getOid(String oid) {
    return OID + oid;
  }
}
