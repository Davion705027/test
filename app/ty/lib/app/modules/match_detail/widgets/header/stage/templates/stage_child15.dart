import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../db/app_cache.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../../utils/format_date_util.dart';

/// 曲棍球
class StageChild15 extends StatefulWidget {
  const StageChild15(
      {super.key,
      required this.isPinnedAppbar,
      required this.match,
      required this.isMatchSelect});

  final bool isPinnedAppbar;
  final MatchEntity match;
  final bool isMatchSelect;

  @override
  State<StageChild15> createState() => _StageChild15State();
}

class _StageChild15State extends State<StageChild15> {
  /// 定时器
  Timer? timer;

  // 显示比赛时间的阶段
  List<String> mmpArr = ['6', '7', '13', '14', '15', '16', '40', '21'];

  // 赛事进行时间
  int showTime = 0;

  // 上下半场
  List<String> mmpArr1 = ['301', '302', '303', '31'];

  List<String> mmpArrBase = [
    '6',
    '7',
    '13',
    '14',
    '15',
    '16',
    '40',
    '440',
    '301',
    '302',
    '303',
    '31',
    '100'
  ];

  @override
  void initState() {
    initEvent();
    getSyncMatchTime();

    /// 初始化定时器
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!mounted) {
        return;
      }
      setState(() {
        calculateGraph();
        getSyncMatchTime();
      });
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant StageChild15 oldWidget) {
    // 比赛的时候，更新mst时间
    if (mmpArr.contains(widget.match.mmp)) {
      initEvent();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.match.ms == 110) {
      return AutoSizeText(
        LocaleKeys.ms_110.tr,
        maxLines: 1,
        minFontSize: 8,
        style: TextStyle(
          color: widget.isMatchSelect
              ? Get.theme.subSelectTitleColor
              : Colors.white,
          fontSize: widget.isPinnedAppbar ? 14.sp : 12.sp,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w500,
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            "mmp_15_${widget.match.mmp}".tr,
            maxLines: 1,
            minFontSize: 8,
            style: TextStyle(
              color: widget.isMatchSelect
                  ? Get.theme.subSelectTitleColor
                  : Colors.white,
              fontSize: widget.isPinnedAppbar ? 14.sp : 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
          // 赛事计时器
          if (mmpArrBase.contains(widget.match.mmp) && showTime >= 0)
            AutoSizeText(
              FormatDate.formatMgtTime(showTime),
              maxLines: 1,
              minFontSize: 8,
              style: TextStyle(
                color: widget.isMatchSelect
                    ? Get.theme.subSelectTitleColor
                    : Colors.white,
                fontSize: widget.isPinnedAppbar ? 14.sp : 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ).marginOnly(left: 4.w),
        ],
      );
    }
  }

  /// 获取同步的赛事时间
  getSyncMatchTime() {
    if (widget.isPinnedAppbar) {
      // final matchTimeMap = MapKV.matchTime.get();
      // if (matchTimeMap != null && matchTimeMap.containsKey(widget.match.mid)) {
      //   showTime = matchTimeMap[widget.match.mid];
      // }
    }
  }

  /// 同步赛事时间
  saveMatchTime() {
    if (widget.isPinnedAppbar) return;
    // MapKV.matchTime.save({widget.match.mid: showTime});
  }

  ///@description 判断赛事是暂停||开始
  initEvent() {
    if (widget.match.mess == 0 &&
        widget.match.cmec == "time_start" &&
        !mmpArr1.contains(widget.match.mmp)) {
      showTime = int.parse(widget.match.mst);
      saveMatchTime();
    } else {
      initRestTime();
    }
  }

  ///@description 重置时间
  ///@param {Number} 赛事进行时间
  initRestTime() {
    if (mmpArr1.contains(widget.match.mmp)) {
      showTime = widget.match.mlet == "0" || widget.match.mle == 0 ? 900 : 0;
      saveMatchTime();
    } else if (mmpArr.contains(widget.match.mmp)) {
      showTime = int.parse(widget.match.mst);
      calculateGraph();
    }
  }

  ///@description 时间倒计时
  ///@param {Number} 赛事进行时间
  calculateGraph() {
    if (showTime <= 0) {
      showTime = 0;
    } else {
      showTime -= 1;
    }

    saveMatchTime();
  }
}
