/**
 * @Author xlight
 * @Date 2024/2/14 13:48
 * @Description: 此文件 主要是应对 赔率转换(在转换为其他赔率时候，必须做欧洲赔率的配分)
 *
 * 实现 匹配不到 后 向下 取值
 */
import 'dart:core';
import 'dart:math';

import 'package:flutter_ty_app/app/core/constant/index.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';

import '../../index.dart';

extension TYFormatOddsConversionMixin on TYFormat {
  static List<int> float3Csid = Csid.esports_csid; // 需要显示三位小数点的,赛种编号(电竞)

  static Map<String, String> oddsTable = {
    'EU': '1',
    'HK': '2',
    'MY': '3',
    'GB': '4',
    'US': '5',
    'ID': '6',
  };

  static String betChatRoomType = '';

  /** 赔率映射表 */
  static Map oddsConversionMap = {};

  static String accSub(dynamic num1, dynamic num2) {
    int r1 = 0, r2 = 0, m;
    try {
      if (num1.toString().split('.')[1] != null) {
        r1 = num1.toString().split('.')[1].length;
      } else {
        r1 = 0;
      }
      if (num2.toString().split(".")[1] != null) {
        r2 = num2.toString().split(".")[1].length;
      } else {
        r2 = 0;
      }
    } catch (e) {
      print(e);
    }
    m = pow(10, max(r1, r2)).toInt();
    int n = (r1 >= r2) ? r1 : r2;
    return ((num1 * m - num2 * m) / m).toStringAsFixed(n);
  }

  static String computeValueByCurOddType(
      int val, String hpid, List<String> arr, int csid) {
    //当前赔率"EU" /HK
    String curOdd = UserController.to.curOdds;
    /**
     * 此方法预留  后期 对于 不支持转换赔率的 盘口 做特殊加工
     * 是 对全局 赔率转换的 基础设定
     * arr: 当前盘口 支持的赔率转换类型的 全部值
     * csid ：赛种ID
     */
    if (val == null) return "";

    double oddsVal = val /
        100000.0; //double.parse(accSub(double.parse(accSub(val, 1000)), 100));
    // PS-9881赔率优化
    String str = "";
    // 获取当前的盘口赔率
    String curOddsNum = oddsTable[curOdd] ?? '1';

    // 从欧盘转到港盘
    if ([2].contains((int.tryParse(curOddsNum))) && curOdd == 'HK') {
      str = calcOdds(oddsVal.toString(), csid);
      // 获取当前投注项 如果不支持当前的赔率 就使用欧赔
      if (arr.contains(curOddsNum)) {
        str = changeEuToHk(str);
        //聊天室跟单特殊处理
        if (arr.contains(curOddsNum) && betChatRoomType == "HK") {
          str = changeEuToHk(str);
        }
      }

      return formatOdds(str, csid);
    }

    // 非港赔
    if (arr.contains(curOddsNum) && curOdd != null) {
      if (curOdd == 'EU') {
        str = calcOdds(oddsVal.toString(), csid);
      } else {
        str = computeValueByOddType(oddsVal.toString(), curOdd, csid);
      }
    } else {
      str = calcOdds(oddsVal.toString(), csid);
    }

    return formatOdds(str, csid);
  }

  /**
   *@description 赔率展示优化，见优化单 13807,电竞不走这个逻辑
   *@param {Number|String} val 最终赔率 30.40 100.00
   *@param {Number|String} csid 球类id
   *@return {String} 优化后的赔率，30.4 100
   */
  static String formatOdds(String? value, int csid) {
    if (value == '' || value == null) {
      return '';
    }
    if (float3Csid.contains(csid)) return value;
    double dval = double.tryParse(value) ?? 0.0;

    /// 赔率是0的时候，显示-
    if (dval == 0.0) return  "-";
    String val = dval.toString();
    String ret = value;
    if (val.contains('.')) {
      if (dval >= 100) {
        List valList = val.split('.');
        if (valList.length > 1 && valList[1] == '00') {
          ret = val.split('.')[0];
        } else {
          int len = val.length;
          if (val.indexOf('.0') == (len - 2)) {
            ret = val.substring(0, len - 2);
          } else {
            ret = val;
          }
        }
      } else if (dval >= 10) {
        List valList = val.split('.');
        if (valList.length > 1 &&
            valList[1].length > 1 &&
            valList[1][1] == '0') {
          ret = val.substring(0, val.length - 1);
        } else {
          ret = val;
        }
      }
    }
    return ret;
  }

  //返回字符串保留两位小数,csid-赛种ID
  static String calcOdds(String val, int csid) {
    String N = val.toString();
    if (float3Csid.contains(1 * csid)) {
      //3位小数点处理
      if (N.contains(".")) {
        List<String> S = N.split('.');
        if (S[1].length > 2) {
          val = "${S[0]}.${S[1]}";
        } else if (S[1].length == 2) {
          val = "${S[0]}.${S[1]}0";
        } else {
          val = "${S[0]}.${S[1]}00";
        }
      } else {
        val = "$N.000";
      }
    } else {
      if (N.contains(".")) {
        List<String> S = N.split('.');
        List<String> s1 = S[1].split("");
        if (s1.length > 1) {
          val = "${S[0]}.${s1[0]}${s1[1]}";
        } else {
          val = "${S[0]}.${s1[0]}0";
        }
      } else {
        val = "$N.00";
      }
    }
    return val;
  }

  static String changeEuToHk(String val) {
    if (val != null && val.isNotEmpty) {
      // 小数点的位置
      int indexDot = val.indexOf('.');
      // 整数部分
      String intPart = val.substring(0, indexDot);
      // 小数部分
      String smallPart = val.substring(indexDot);

      return "${((int.tryParse(intPart) ?? 0) - 1).toString()}$smallPart";
    }

    return val;
  }

  static String getAccuracy(String str) {
    double val = double.tryParse(str) ?? 0.0;
    if (val >= 10 && val < 100) {
      return str.substring(0, str.length - 1);
    } else if (val >= 100) {
      return str.substring(0, str.length - 3);
    }
    return str;
  }

  //非欧盘时计算赔率转换
  static String computeValueByOddType(String val, String oddType, int csid) {
    /**
     * val  : 原始欧洲赔率的 值
     * odd_type ： 需要转换到的赔率类型的 键名
     * csid ：赛种ID
     *
     * 把传入的值，计算为当前赔率
     * 这里必须清楚，我们始终以欧洲赔率作为标准
     * 数据里面永远存在欧洲赔率
     * 此处转换 传入的只能是 欧洲赔率的数值 和另一个赔率的 标识
     *
     * 存在问题 ，传入的必须是 赔率 不是金额
     * 金额需要另外套接
     *
     * 赔率 有粒度 不一定命中 这里需要做处理
     *
     *
     */

    //  EU_1.01
    /**
     * 切换通用规则：a，部分数据源给过来的赔率数据会落在断档区间内，则自动匹配区间值中小的那一个进行其他赔率转换，
     * 从其他赔率转换回欧洲赔率时直接变回源数据欧洲赔率。例如：数据源过来的赔率为2.58，在区间2.55-2.60之间，
     * 则将数据源的赔率匹配为2.55进行其他赔率转换；从其他赔率转换回欧洲赔率的时候直接回2.58。b，赔率负数要红色显示；正数用黑色显示。

     */
    /**
     *
     * 已和产品确认，和上游数据确认，传递给前端的 是 原始 欧洲赔率
     *
     */
    /**
     * 1	1.01-2.50，以0.01为单位，相应赔率转换
        2	2.5-5.0，以0.05为单位，相应赔率转换
        3	5.0-10，以x.2，x.5，x.7，x.0展示，相应赔率转化
        4   10-20，以0.5为单位，相应赔率转换
        5	20-30，以1为单位，相应赔率转换
        6	30-100，以5为单位，相应赔率转换

        和 产品确认， 负数 小于 -10 的 .5 不显示  ，正数 大于20的 .5 不显示
     */
    if (val == null || oddType == null) {
      return "";
    }

    // 如果是香港赔率直接减1
    if (oddType == 'HK') {
      return ((double.tryParse(val) ?? 1) - 1).toString();
    }

    // 赔率类型错误
    int index = oddsConstant.indexWhere((o) => o.value == oddType);
    val = calcOdds(val, csid);

    if (index < 0) {
      return val;
    }

    if ((double.tryParse(val) ?? 0) <= 1) {
      return val;
    }

    // 正常情况
    dynamic obj;
    String real = "";
    double dval = double.tryParse(val) ?? 0.0;

    obj = oddsConversionMap['EU_$val'];
    if (double.parse(val) <= 2.5) {
      // 1	1.01-2.50，以0.01为单位，相应赔率转换
    } else if (double.parse(val) <= 5) {
      // 2.5-5.0，以0.05为单位，相应赔率转换  3.478
      if (obj == null) {
        real = (((dval * 100).floorToDouble().floor() - dval) / 100).toString();
        obj = oddsConversionMap['EU_$real'];
      }
    } else if (double.parse(val) <= 10) {
      // 5.0-10，以x.2，x.5，x.7，x.0展示，相应赔率转化 5.478
      if (obj == null) {
        int nnn = (dval * 10).floorToDouble().floor();
        int nnnY = nnn % 10;
        if (nnnY >= 0 && nnnY < 2) {
          nnnY = 0;
        } else if (nnnY < 5) {
          nnnY = 2;
        } else if (nnnY < 7) {
          nnnY = 5;
        } else if (nnnY <= 9) {
          nnnY = 7;
        }
        real = (dval.floorToDouble().floor() + nnnY / 10).toString();
        obj = oddsConversionMap['EU_$real'];
      }
    } else if (dval <= 20) {
      // 4   10-20，以0.5为单位，相应赔率转换   10.476
      // 10.476%5=0.47600000000000087
      if (obj == null) {
        // real = ((double.parse(val) * 10) - ((double.parse(val) * 10) % 5)) / 10;
        obj = oddsConversionMap['EU_$real'];
      }
    } else if (double.parse(val) <= 30) {
      // 5	20-30，以1为单位，相应赔率转换
      if (obj == null) {
        real = dval.floorToDouble().floor().toString();
        obj = oddsConversionMap['EU_$real'];
      }
    } else if (double.parse(val) <= 100) {
      // 6	30-100，以5为单位，相应赔率转换
      if (obj == null) {
        real = (dval.floorToDouble().floor() - dval).toString();
        obj = oddsConversionMap['EU_$real'];
      }
    }

    if (obj != null) {
      return obj[oddType];
    } else {
      return val;
    }
  }
}
