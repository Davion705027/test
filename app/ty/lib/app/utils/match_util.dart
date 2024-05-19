import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

class MatchUtil {
  // 上半场 下半场
  static String getHalf(MatchEntity matchEntity) {
    return 'mmp_${matchEntity.csid}_${matchEntity.mmp}'.tr;
  }


  // 是否显示 多少分钟后开赛
  static bool showStartCountingDown(MatchEntity item)  {

      bool r = false;
      // 滚球中不需要显示多少分钟后开赛
      if (item.ms == 1) {
        return r;
      }
      int startTime = int.tryParse(item.mgt) ?? 0; // 开始时间

      int diffTime = IntKV.diffTime.get() ?? 0;
      int nowLocal = DateTime.now().millisecondsSinceEpoch + diffTime;
      int subTime = startTime - nowLocal;

      // mcg 1:滚球 2:即将开赛 3:今日赛事 4:早盘
      r = item.mcg != 1 && 0 < subTime && subTime < 60 * 60 * 1000;
      return r;
    }

 
    // 获取还有多少分钟开赛
   static int getStartCountTime(MatchEntity item)  {

    
      int startTime = int.parse(item.mgt); // 开始时间


      int diffTime = IntKV.diffTime.get() ?? 0;
      int nowLocal = DateTime.now().millisecondsSinceEpoch + diffTime;

      int nowServerrTime = nowLocal + diffTime;
      int res = ((startTime - nowLocal)/ 1000 / 60).round();
      return res;

    }

    /// @description: 进行中(但不是收藏页)的赛事显示累加计时|倒计时
    /// @param {Object} item 赛事对象
    /// @return {Boolean}
    static bool showCountingDown (MatchEntity item) {
      return [1, 2, 10].contains(item.ms * 1);
    }


  /// @description: 获取赛事的让球方
  /// @param {Object} match
  /// @return {Number} 0未找到让球方 1主队为让球方 2客队为让球方
  static int getHandicapIndexBy(MatchEntity match) {
    int result = 0;
    List<MatchHps> hps = match.hps;

    int hpid = getHandicapWId(int.tryParse(match.csid) ?? 0);
    MatchHps? hpItem = hps.firstWhereOrNull((item) => item.hpid == hpid.toString());

    if (hpItem != null && hpItem.hl.isNotEmpty) {
      MatchHpsHl hlItem = hpItem.hl[0];

      // For csid 5 (网球) and 让盘 hpid 154
      if (match.csid == "5") {
        hpItem =
            hps.firstWhereOrNull((item) => item.hpid == "154");
        if (hpItem != null) {
          hlItem = hpItem.hl[0];
        }
      }

      List<MatchHpsHlOl>? ol = hpItem?.hl[0].ol;

      if (ol != null) {
        int foundIndex = 0;
        for (int i = 0; i < ol.length; i++) {
          String onStr = ol[i].on;
          if (onStr.startsWith("-")) {
            foundIndex = i + 1;
          }
                }
        result = foundIndex;
      }
    }
    return result;
  }

  /// 根据体育类型的csid获取赛事的让球玩法id
  /// @param {Number} csid 体育类型id
  static int getHandicapWId(int csid) {
    int sportId = csid;
    int sportIdConvert = 4; // Default value

    switch (sportId) {
      case 5: // 网球
        sportIdConvert = 154; // 让盘154 让局155
        break;
      case 10: // 羽毛球
        sportIdConvert = 172;
        break;
      case 8: // 乒乓球
        sportIdConvert = 172;
        break;
      case 7: // 斯诺克
        sportIdConvert = 181;
        break;
      case 2: // 篮球
        sportIdConvert = 39;
        break;
      case 1: // 足球
        sportIdConvert = 4;
        break;
      case 3: // 棒
        sportIdConvert = 243;
        break;
      case 4: // 冰
        sportIdConvert = 4;
        break;
      case 6: // 美
        sportIdConvert = 39;
        break;
      case 9: // 排
        sportIdConvert = 172;
        break;
      default:
        sportIdConvert = 4;
        break;
    }
    return sportIdConvert;
  }
  // 是否进行到加时赛及以后的阶段
  static isOvertimeed(MatchEntity match){
    return [32,33,34,41,42,50,80,90,100,110,120,999].contains(match.mmp.toInt());
  }
}
