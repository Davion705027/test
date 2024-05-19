import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

/// Created by leon on 2024/02/19.
/// date_util
class DateUtil {
  DateUtil._();

  final DateTime now = DateTime.now();

  String getMonth() => now.month.toString();

  String getDay() => now.day.toString();

  String getDateMMDD(
    int day, {
    bool isReduceEnable = false,
    bool isReduce = true,
  }) {
    if (isReduceEnable) {
      if (isReduce) {}
    } else {
      return "${getMonth()}/${getDay()}";
    }
    return "";
  }
}
