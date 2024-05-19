import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:intl/intl.dart';

class FormatDate {
  /// @description 赛事显示倒计时优化显示
  /// @param match 赛事信息
  /// @param counting_time 需要显示的时间
  /// @return String
  static String countingTimeCtrShowFormat(
      MatchEntity? match, String countingTime) {
    if (match == null) {
      return countingTime;
    }
    // countingTime 格式为 00:00
    String countingTime_ = countingTime;

    // C01赛事只显示分钟不显示秒
    if (match.cds == 'C01' &&
        match.csid == "1" &&
        !ObjectUtil.isEmptyString(countingTime)) {
      countingTime_ = countingTime_.split(':')[0];
    } else if (match.ctt == 1 &&
        ["1", "2"].contains(match.csid) &&
        !ObjectUtil.isEmptyString(countingTime)) {
      countingTime_ = countingTime_.split(':')[0];
    }
    return countingTime_;
  }

  // 格式 20:00
  static String formatHHMM(int? payload) {
    if (payload == null) return "";

    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);

    return DateFormat('HH:mm').format(time);
  }
  // 格式 2024-1-23
  static String formatDate(int? payload) {
    if (payload == null) return "";
    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);

    return DateFormat('yyyy-MM-dd').format(time);
  }
  // 示例： 23:30
  static String formatMgtTime(int num) {
    String m = (num ~/ 60).toString().padLeft(2, '0');
    String s = (num % 60).toInt().toString().padLeft(2, '0');
    return '$m:$s';
  }
  // 示例： 23:30
  static String formatMgtTimeMD(int payload) {
    if (payload == null) return "";

    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);
    return DateFormat('MM月dd日 HH:mm').format(time);
  }
  // 格式 20:00:00
  static String formatHHMMSS(int? payload) {
    if (payload == null) return "";
    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);
    return DateFormat('HH:mm:ss').format(time);
  }

  // 格式化分钟时间
  static String formatMinTime(int num) {
    int m = (num / 60).ceil();
    return '$m';
  }
}
