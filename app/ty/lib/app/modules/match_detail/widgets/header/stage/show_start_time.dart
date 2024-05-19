import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../utils/format_date_util.dart';

/// 详情页同联赛的赛事即将开赛显示时间
class ShowStartTime extends StatefulWidget {
  const ShowStartTime(
      {super.key,
      required this.match,
      required this.isPinnedAppbar,
      required this.isMatchSelect});

  final MatchEntity match;

  /// 是否是置顶头部
  final bool isPinnedAppbar;

  /// 是否是联赛下拉
  final bool isMatchSelect;

  @override
  State<ShowStartTime> createState() => _ShowStartTimeState();
}

class _ShowStartTimeState extends State<ShowStartTime> {
  /// 定时器
  Timer? timer;

  /// 赛事开始倒计时时间（赛事开始时间-当前时间）
  String longTime = "";

  // 赛事开赛时间倒计时是否显示
  bool startTime = true;

  @override
  void initState() {
    initEvent();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String str = "";
    // 即将开赛的赛事不显示日期
    if (startTime) {
      // 距离开赛时间小于一个小时 显示倒计时 (分钟)
      str = LocaleKeys.list_after_time_start.tr.replaceAll("{0}", longTime);
    } else {
      // 格式化显示HH:MM
      str = FormatDate.formatHHMM(int.tryParse(widget.match.mgt) ?? 0);
    }

    return AutoSizeText(
      str,
      maxLines: 1,
      minFontSize: 8,
      style: TextStyle(
        color: widget.isMatchSelect
            ? Get.theme.matchSelectTitleColor
            : Colors.white,
        fontSize: (widget.isMatchSelect && !startTime)
            ? 32.sp
            : widget.isPinnedAppbar
                ? 14.sp
                : 12.sp,
        fontFamily: 'PingFang SC',
        fontWeight: widget.isMatchSelect
            ? FontWeight.w700
            : widget.isPinnedAppbar
                ? FontWeight.w500
                : FontWeight.w400,
      ),
    );
  }

  /// 计算赛事开始倒计时时间
  initEvent() {
    // 当前时间戳 1709022665703
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;

    int mgt = int.tryParse(widget.match.mgt) ?? 0;
    // 赛事开始时间 - 当前时间 小于一小时并且大于0时为true
    bool startTimeTemp =
        (mgt - nowTimeStamp) < 3600 * 1000 && (mgt - nowTimeStamp) > 0;

    // 赛事开始倒计时时间(整数)
    int longTimeTemp = ((mgt - nowTimeStamp) / 1000 / 60).floor();

    // 赛事开赛时间倒计时为0的时候 让倒计时显示为1分钟
    if (longTimeTemp == 0) {
      longTimeTemp += 1;
    }
    // 判断开始时间小于本地时间 则不显示具体时间
    if ((mgt - nowTimeStamp) < 0) {
      timer?.cancel();
      startTime = false;
    } else {
      startTime = startTimeTemp;
    }

    // 计算出来的倒计时时间赋值给data的变量显示在页面上
    longTime = longTimeTemp.toString();

    /// 初始化定时器
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!mounted) {
        return;
      }
      setState(() {
        int now = DateTime.now().millisecondsSinceEpoch;
        int mgt = int.tryParse(widget.match.mgt) ?? 0;
        // 判断赛事开始时间-当前时间 小于0的时候 清除定时器
        if (mgt - now < 0) {
          timer.cancel();
          // 不显示倒计时
          startTime = false;
        }
        // 同上注释
        int newLongTime = ((mgt - now) / 1000 / 60).floor();
        if (newLongTime == 0) {
          newLongTime += 1;
        }
        longTime = newLongTime.toString();
      });
    });
  }
}
