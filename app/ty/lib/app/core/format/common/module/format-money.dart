/**
 * @Author xlight
 * @Date 2024/2/4 13:58
 */

import '../../index.dart';

extension TYFormatMoney on TYFormat {
  static String formatMoney (num money,{int bit = 2}){
    return money.toStringAsFixed(bit);
  }
}