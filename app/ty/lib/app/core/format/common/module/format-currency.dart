/**
 * @Author xlight
 * @Date 2024/2/4 13:58
 */

import '../../index.dart';

extension TYFormatCurrency on TYFormat {
  /**
   * @description: 金额格式化带货币符号，保留2位小数
   * @param {Number} num 金额
   * @return {String} 转换后的金额
   */
  static String formatCurrency(num? inputNum) {
    if (inputNum != null) {
      // Format the number with two decimal places directly
      String formattedNum = inputNum.toStringAsFixed(2);

      // Use RegExp to add commas to the integer part
      return formattedNum.replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+\.)'), (match) => '${match[1]},');
    }
    return '0.00';
  }

  /**
   * @description: 金额格式化带货币符号，小数位保持不变
   * @param {Number} num 金额
   * @return {String} 转换后的金额
   */
  static String formatCurrency2(num? inputNum) {
    if (inputNum != null) {
      String _num = inputNum.toString();
      List<String> parts = _num.split('.');
      String integerPart = parts[0].replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (match) => '${match[1]},');
      String decimalPart = parts.length > 1 ? parts[1] : '';
      return '$integerPart${decimalPart.isNotEmpty ? '.' : ''}$decimalPart';
    }
    return '0';
  }
}