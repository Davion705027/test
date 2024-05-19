import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ty_app/app/core/format/index.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/app/utils/format_money_util.dart';

void main() {
  test('Test formatCurrency', () {
    expect(TYFormatCurrency.formatCurrency(123456789), '123,456,789.00');
    expect(TYFormatCurrency.formatCurrency(9876543.21), '9,876,543.21');
    expect(TYFormatCurrency.formatCurrency(1234.5678), '1,234.57');
    expect(TYFormatCurrency.formatCurrency(0), '0.00');
    expect(TYFormatCurrency.formatCurrency(-123456.789), '-123,456.79');
    expect(TYFormatCurrency.formatCurrency(null), '0.00');
  });

  test('Test formatCurrency2', () {
    expect(TYFormatCurrency.formatCurrency2(123456789), '123,456,789');
    expect(TYFormatCurrency.formatCurrency2(9876543.21), '9,876,543.21');
    expect(TYFormatCurrency.formatCurrency2(1234.5678), '1,234.5678');
    expect(TYFormatCurrency.formatCurrency2(0), '0');
    expect(TYFormatCurrency.formatCurrency2(null), '0');
  });

  test('formatOdds tests', () {
    expect(TYFormatOddsConversionMixin.formatOdds(null, 1), '');
    expect(TYFormatOddsConversionMixin.formatOdds('30.400', 1), '30.400');
    expect(TYFormatOddsConversionMixin.formatOdds('150.000', 5), '150');
    expect(TYFormatOddsConversionMixin.formatOdds('30.400', 4), '30.4');
  });

  test("formatmoney", () {
    expect(FormatMoney.numberToChinese(123), "一百二十三");
  });

    /// 1710242394079  "mm/dd HH:MM" => 03/12 19:19
    /// "1710172800000"              => 03/12 00:00
  test('format Date',(){
    expect(TYFormatDate.formatTime('1710242394079', "mm/dd HH:MM"), '03/12 19:19');
    expect(TYFormatDate.formatTime('1710172800000', "mm/dd HH:MM"), '03/12 00:00');
  });
}
