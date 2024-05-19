import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../generated/locales.g.dart';
import '../modules/login/login_head_import.dart';
import '../utils/format_money_util.dart';

/// 为赛事列表(专业版和新手版)提供逻辑方法，拆分组件复杂度
/// 对应vue 路径 core/match-list-h5/match-class/match-list.js
class MatchListClass {
  /// mmp映射赛事阶段名，国际化语言
  static String matchPeriodMap(MatchEntity match, {bool hasReplace = false}) {
    int mmp = int.tryParse(match.mmp) ?? 0;
    int csid = int.tryParse(match.csid) ?? 0;
    int ms = match.ms;

    String mmpMapTitle = '';
    if (ms == 110) {
      // ms == 110: 代表 即将开赛
      return LocaleKeys.ms_110.tr;
    }

    if (mmp == 0 && ms == 1) {
      // 篮球
      if (csid == 2) {
        mmp = 13;
      }
      // 棒球
      else if (csid == 3) {
        mmp = 401;
      }
      // 美式足球6 水球16
      else if ([6, 16].contains(csid)) {
        mmp = 13;
      }
    }

    // 斯诺克7局显示处理
    if (csid == 7) {
      return covertMct(match);
    }

    String r = "";
    String key = "mmp_${csid}_$mmp";
    r = key.tr;
    // 国际化有找到该key 证明转化成功
    if (r != key) {
      mmpMapTitle = r;
      // 如果是篮球的  小节玩法，则转成 上半场
      if ([14, 301].contains(mmp) && hasReplace && csid == 2) {
        mmpMapTitle = "mmp_${csid}_1".tr;
      }
    }

    // 篮球3X3滚球时显示"全场"
    if (ms == 1 && csid == 2 && match.mle == 73) {
      mmpMapTitle = LocaleKeys.mmp_2_21.tr;
    }

    return mmpMapTitle;
  }

  /// @description:斯诺克7局显示处理
  /// @param {Object} {mct局数 mmp赛事阶段 ms赛事状态}
  /// @return {String}
  static String covertMct(MatchEntity match) {
    int mmp = int.parse(match.mmp);
    int mct = match.mct;
    int ms = match.ms;

    String result = '';
    if (isMatchPlaying(ms) && mmp == 0) {
      mct = 1;
    }

    String newNum = mct.toString();
    print(Get.locale?.languageCode);
    // 中文特殊处理
    if (['zh', 'hk'].contains(Get.locale?.languageCode)) {
      newNum = FormatMoney.numberToChinese(mct);
    }
    String gameCount = LocaleKeys.mmp_7_x.tr;
    Map ext = {
      419: LocaleKeys.mmp_7_419.tr,
      420: LocaleKeys.mmp_7_420.tr,
      439: LocaleKeys.mmp_7_439.tr,
    };
    if (mmp == 445) {
      result = LocaleKeys.mmp_7_445.tr;
    } else {
      String gameCountDes = gameCount.replaceAll('%s', newNum);
      String gameCountDes2 = "";
      if (ext.containsKey(mmp)) {
        gameCountDes2 = ext[mmp];
      }
      result = gameCountDes + gameCountDes2;
    }
    return result;
  }

  /// @description: 赛事进行中
  /// 0未开始 1滚球阶段 2暂停 7延迟 10比赛中断 110即将开赛 3结束 4关闭 5取消 6比赛放弃 8未知 9延期
  static bool isMatchPlaying(int ms) {
    return [1, 2, 7, 10, 110].contains(ms);
  }

  /// @description 虚拟赛事换算走表步长
  /// @param match 赛事信息
  /// @param step 原来的步长
  /// @return 换算后的步长
  static double matchVrStep(MatchEntity? match, double step) {
    double res = step;
    if (match == null) {
      return res;
    }
    // C01赛事显示倒计时优化(使用每场比赛90分钟进行换算)
    // if (match.cds == '1500' && match.csid == "1") {
    //   switch (match.mle.toString()) {
    //     case '57': // 2 * 4分钟 加中场休息时间4分钟=>按照720秒换算
    //       res = 7.5;
    //       break;
    //     case '66': // 2 * 5分钟  加中场休息时间4分钟=>按照840秒换算
    //       res = 6.428571;
    //       break;
    //     case '55': // 2 * 6分钟 (10.5s累加1分钟)
    //       res = 5.7142;
    //       break;
    //     default:
    //       break;
    //   }
    // } else


      if (match.ctt == 1 && ["1", "2"].contains(match.csid)) {
      // 是机器开出的虚拟赛事时,使用atf时间系数换算时间
      // ctt (0 人 1机器)   atf (时间系数)
      res = double.parse(match.atf) * step;
    }
    return res;
  }


}
