/**
 * @Author xlight
 * @Date 2024/2/13 10:18
 * @Description: 此文件 主要是应对  根据转换 后的 赔率 计算(在转换为其他赔率时候，必须做欧洲赔率的配分)
 *
 * 实现 匹配不到 后 向下 取值
 */
import '../../index.dart';

extension TYFormatMaxWinMoney on TYFormat {
  static final List<int> float3Csid = [100, 101, 102, 103];
  static final Map<String, int> oddsTable = {
    'EU': 1,
    'HK': 2,
    'US': 3,
    'ID': 4,
    'MY': 5,
    'GB': 6,
  };

  //返回字符串保留两位小数，电竞返回3位小数
  // 2.3 => 2.30  2 => 2.00  3.199 => 3.19  3.119 => 3.11
  static String calc_odds(String val, int csid) {
    if (float3Csid.contains(1 * csid)) {
      if (val.contains('.')) {
        List<String> parts = val.split('.');
        if (parts[1][2] != null) {
          val = '${parts[0]}.${parts[1][0]}${parts[1][1]}${parts[1][2]}';
        } else if (parts[1][1] != null) {
          val = '${parts[0]}.${parts[1][0]}${parts[1][1]}0';
        } else {
          val = '${parts[0]}.${parts[1][0]}00';
        }
      } else {
        val = '$val.000';
      }
    } else {
      if (val.contains('.')) {
        List<String> parts = val.split('.');
        if (parts[1][1] != null) {
          val = '${parts[0]}.${parts[1][0]}${parts[1][1]}';
        } else {
          val = '${parts[0]}.${parts[1][0]}0';
        }
      } else {
        val = '$val.00';
      }
    }
    return val;
  }

  /**
   * 此方法预留  后期 对于 不支持转换赔率的 盘口 做特殊加工
   * 是 对全局 赔率转换的 基础设定
   * arr: 当前盘口 支持的赔率转换类型的 全部值
   *
   * 得出 转换后的 赔率 和 最终使用的赔率 类型， 根据 传入的本金 ，计算 可盈利数值 的 参考值 、
   * 实际的可盈利数值  由 多个 维度 比较 得出结果
   */
  static double compute_money_by_cur_odd_type(
      String val,
      String breakVal,
      List<int>? arr,
      double inputVal,
      int csid,
      ) {
    String str = '';
    String finalOddType = '';

    if (arr == null) {
      val == 'EU' ? str = val : str = computeValueByOddType(breakVal, val);
      finalOddType = val;
    } else {
      if (arr.contains(oddsTable[val]!)) {
        val == 'EU' ? str = val : str = computeValueByOddType(breakVal, val);
        finalOddType = val;
      } else {
        str = val;
        finalOddType = 'EU';
      }
    }

    double num = compute_money_by_odd_type_and_value_and_inputValue(
      val,
      str,
      finalOddType,
      inputVal,
      csid,
    );

    if (num.isNaN) num = 0;
    return num;
  }

  //在format-odds-conversion-mixin中实现，暂时跳过
  static computeValueByOddType(breakVal, val){
    return '';
  }

  static double compute_money_by_odd_type_and_value_and_inputValue(
      String euVal,
      String oddVal,
      String oddType,
      double inputVal,
      int csid,
      ) {
    double num = 0;
    // { label: "欧洲盘(EU)", value: "EU" },
    // { label: "香港盘(HK)", value: "HK" },
    // { label: "马来盘(MY)", value: "MY" },
    // { label: "英式盘(GB)", value: "GB" },
    // { label: "美式盘(US)", value: "US" },
    // { label: "印尼盘(ID)", value: "ID" }

    euVal = double.tryParse(euVal)?.toString()??'0';
    switch (oddType) {
      case 'EU':
        num = compute_money_when_EU(calc_odds(euVal, csid), oddVal, inputVal);
        break;
      case 'HK':
        num = compute_money_when_HK(calc_odds(euVal, csid), oddVal, inputVal);
        break;
      case 'MY':
        num = compute_money_when_MY(calc_odds(euVal, csid), oddVal, inputVal);
        break;
      case 'GB':
        num = compute_money_when_GB(calc_odds(euVal, csid), oddVal, inputVal);
        break;
      case 'US':
        num = compute_money_when_US(calc_odds(euVal, csid), oddVal, inputVal);
        break;
      case 'ID':
        num = compute_money_when_ID(calc_odds(euVal, csid), oddVal, inputVal);
        break;
      default:
        num = 0;
        break;
    }

    return num;
  }

  static double compute_money_when_EU(String euVal, String oddVal, double inputVal) {
    return ((double.tryParse(euVal)??0) - 1) * inputVal;
  }

  static double compute_money_when_HK(String euVal, String oddVal, double inputVal) {
    double n = (double.tryParse(oddVal)??0) * 100000 * inputVal;
    n = n / 100000;
    return n;
  }

  static double compute_money_when_MY(String euVal, String oddVal, double inputVal) {
    double n = 0;
    if ((double.tryParse(oddVal)??0) > 0) {
      n = (double.tryParse(oddVal)??0) * inputVal;
    } else if ((double.tryParse(oddVal)??0) < 0) {
      n = inputVal;
    }
    return n;
  }

  static double compute_money_when_GB(String euVal, String oddVal, double inputVal) {
    double oddVal1 = double.tryParse(oddVal.split('/')[0])??0;
    double oddVal2 = double.tryParse(oddVal.split('/')[1])??0;
    double oddValResult = oddVal1 / oddVal2;
    return oddValResult * inputVal;
  }

  static double compute_money_when_US(String euVal, String oddVal, double inputVal) {
    double n = 0;
    if ((double.tryParse(oddVal)??0) > 0) {
      n = (double.tryParse(oddVal)??0) * (inputVal / 100);
    } else if ((double.tryParse(oddVal)??0) < 0) {
      n = (100 / double.parse(oddVal)) * inputVal;
    }
    return n;
  }

  static double compute_money_when_ID(String euVal, String oddVal, double inputVal) {
    double n = 0;
    if ((double.tryParse(oddVal)??0) > 0) {
      n = (double.tryParse(oddVal)??0) * inputVal;
    } else if ((double.tryParse(oddVal)??0) < 0) {
      n = inputVal;
    }
    return n;
  }
}