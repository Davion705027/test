/**
 * @Author xlight
 * @Date 2024/2/5 14:58
 */

import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:intl/intl.dart';

import '../../index.dart';

extension TYFormatDate on TYFormat {
  static String format_Y_M_D_H_M(int? payload) {
    if (payload == null) return "";

    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);

    return DateFormat('yyyy-MM-dd HH:mm').format(time);
  }

  static String formcht_Y_M_D_H_M(int? payload) {
    if (payload == null) return "";

    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);

    return DateFormat('yyyy年MM月dd日 HH:mm').format(time);
  }

  // 判断是 今天 或者 明天，还是距离多少天，后面扩展
  static String? formatHowManyDays(DateTime val) {
    DateTime dateBeginTime = DateTime.parse(DateFormat('yyyy-MM-dd').format(val));
    DateTime dateEndTime = DateTime.now();
    Duration dateDiffTime = dateEndTime.difference(dateBeginTime);

    int difValueTime = dateDiffTime.inDays;
    String? dayValue;

    if (difValueTime == 0) {
      dayValue = 'today';
    } else if (difValueTime == -1) {
      dayValue = 'tomorrow';
    }

    return dayValue ;
  }

  // 示例： 1 月 2 日
  /**
   * 日期格式化
   * @param {String} val 时间戳
   * @return {String}
   */
  String format_M_D(int? payload) {
    if (payload == null) return "";

    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);
    int m = time.month;
    String d = time.day.toString();

    //需要国际化定义
    List<String> monthes = ["time.monthes"];
    String format = "time.time_date_1";

    format = format.replaceFirst("%date", d);
    format = format.replaceFirst("%month", monthes[m - 1]); // Dart months are 1-indexed

    return format;
  }

  // 示例： 1 月 2 日
  /**
   * 日期格式化
   * @param {String} val 时间戳
   * @return {String}
   */
  String formatMDPC(int payload) {
    if (payload == null) return "";

    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);
    int m = time.month;
    String d = time.day.toString();

    //需要国际化定义
    String monthes = 'time.month_${m + 1}';

    String day = 'match_info.day';
    String format = '$monthes $d$day';

    return format;
  }

  // 示例： 12 ：30
  String format_H_M(int? payload) {
    if (payload == null) return "";

    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);

    return DateFormat('HH:mm').format(time);
  }

  // 示例： 23:30
  String format_mgt_time(int? payload) {
    if (payload == null) return "";

    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);

    return DateFormat('mm:ss').format(time);
  }

  /**
   * 日期格式化
   * @param {String} val 时间戳
   * @return {String}
   */
  String format_date(String val) {
    int timestamp = int.parse(val);
    DateTime currentTime = DateTime.now();
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    Duration difference = currentTime.difference(date);
    String str = "";

    if (difference.inMilliseconds > 1000 * 60 * 60 * 24) {
      str = '${date.month}月${date.day}日';
    } else if (difference.inMilliseconds > 1000 * 60 * 60) {
      str = '${(difference.inMilliseconds / (1000 * 60 * 60)).ceil()}小时前';
    } else {
      str = '${(difference.inMilliseconds / (1000 * 60)).ceil()}分钟前';
    }

    return str;
  }

  // 示例： 5 15 23
  String format_min_time(int num) {
    int minutes = (num / 60).ceil();
    return '$minutes';
  }
  
  /// @description: 格式化时间
  /// @param {Number} timestamp 时间戳
  /// @param {String} fmt 自定义格式("mm月DD日 HH时MM")
  /// @return {String} 格式好的时间 
  /// 1710242394079  "mm/dd HH:MM" => 03/12 19:19
  /// "1710172800000"       "03/12 00:00"
  static String formatTime(String val, String fmt) {
    int timestamp = int.parse(val);
  try {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    Map<String, String> opt = {
      "Y+": fmt.lastIndexOf("Y") - fmt.indexOf("Y") == 3
          ? date.year.toString()
          : date.year.toString().substring(2), // 年
      "y+": fmt.lastIndexOf("y") - fmt.indexOf("y") == 3
          ? date.year.toString()
          : date.year.toString().substring(2), // 年
      "m+": date.month.toString(), // 月
      "D+": date.day.toString(), // 日
      "d+": date.day.toString(), // 日
      "H+": date.hour.toString(), // 时
      "h+": date.hour.toString(), // 时
      "M+": date.minute.toString(), // 分
      "S+": date.second.toString(), // 秒
      "s+": date.second.toString(), // 秒
    };

    opt.forEach((key, value) {
      RegExp regex = RegExp(key);
      Match? match = regex.firstMatch(fmt);
      if (match != null) {
        fmt = fmt.replaceFirst(match.group(0)!, match.group(0)!.length == 1 ? value : value.padLeft(match.group(0)!.length, "0"));
      }
    });

    return fmt;
  } catch (error) {
    return '';
  }
}

  static int formatTimeZoneMillisecond(int time, [int offset = 8]) {
    DateTime d = DateTime.fromMillisecondsSinceEpoch(time);
    int localTime = d.millisecondsSinceEpoch;
    int localOffset = d.timeZoneOffset.inMilliseconds;
    int utc = localTime + localOffset;
    int wishTime = utc + (3600000 * offset);
    return wishTime;
  }

  // 示例： 23:30
  static String formatMgtTime(dynamic num) {
    if(num is String){
      num = int.parse(num);
    }
    String showTime(int time) {
      String m = (time ~/ 60).toString().padLeft(2, '0');
      String s = (time % 60).toString().padLeft(2, '0');
      return '$m:$s';
    }

    String time = showTime(num);
    return time;
  }


}