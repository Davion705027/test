import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../utils/format_date_util.dart';

/// 详情页显示篮球赛事第几节以及赛事时间
class StageChild2 extends StatefulWidget {
  final bool isPinnedAppbar;
  final MatchEntity match;
  final bool isMatchSelect;

  const StageChild2(
      {super.key,
      required this.isPinnedAppbar,
      required this.match,
      required this.isMatchSelect});

  @override
  State<StageChild2> createState() => _StageChild2State();
}

class _StageChild2State extends State<StageChild2> {
  int showTime = 0;

  /// 定时器
  Timer? timer;

  @override
  void initState() {
    initEvent();
    getSyncMatchTime();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant StageChild2 oldWidget) {
    // mess 1开始 0暂停
    // 比赛的时候，更新mst时间
    // 赛事阶段
    if (oldWidget.match.mmp != widget.match.mmp ||
        oldWidget.match.mess != widget.match.mess ||
        oldWidget.match.mst != widget.match.mst) {
      if (mmpArr.contains(widget.match.mmp)) {
        // 暂停  在篮球暂停时 ws推送的C102或者接口返回的cmec的值是事件编码 会出现很多种情况 不能作为附加的判断条件 只用判断mess的值即可
        if (widget.match.mess == 0) {
          timer?.cancel();
          // 开始
        } else if (widget.match.mess == 1) {
          // let num = 0;
          // if(n.c_time){ num = (new Date().getTime() - n.c_time) / 1000 }
          initRestTime();
        }
      } else {
        initRestTime();
      }
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
    if (widget.match.mle != 73) {
      String text = "";
      if (widget.match.mmp == "100") {
        if ((widget.match.mlet == '0' || widget.match.mle == 0) ||
            (widget.match.mlet == '7' || widget.match.mle == 7)) {
          //第四节
          text = LocaleKeys.mmp_2_1001.tr;
        }
        if (widget.match.mlet == '17' || widget.match.mle == 17) {
          //下半场
          text = LocaleKeys.mmp_2_1002.tr;
        }
      } else if (widget.match.mmp == "110") {
        text = "ms_${widget.match.ms}".tr;
      } else {
        text = "mmp_2_${widget.match.mmp}".tr;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            text,
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
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            widget.match.ms == 1
                ? LocaleKeys.mmp_2_21.tr
                : "mmp_2_${widget.match.mmp}".tr,
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
          if (showTime > 0)
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
  ///
  initRestTime() {
    timer?.cancel();

    // 比赛休息时间,显示下一节比赛时间初始化比赛休息时间
    if (widget.match.mmp == '301' ||
        widget.match.mmp == '302' ||
        widget.match.mmp == '303' ||
        widget.match.mmp == '31') {
      // 根据mle 的值，来显示默认值的值；
      showTime = (widget.match.mlet == '0' || widget.match.mle == 0)
          ? 600
          : (widget.match.mlet == '7' || widget.match.mle == 7)
              ? 720
              : (widget.match.mlet == '17' || widget.match.mle == 17)
                  ? 1200
                  : (widget.match.mlet == '64' || widget.match.mle == 64)
                      ? 360
                      : (widget.match.mlet == '68' || widget.match.mle == 68)
                          ? 300
                          : (widget.match.mlet == '70' ||
                                  widget.match.mle == 70)
                              ? 240
                              : 0;
      saveMatchTime();
    } else if (widget.match.mmp == '1' ||
        widget.match.mmp == '2' ||
        widget.match.mmp == '13' ||
        widget.match.mmp == '14' ||
        widget.match.mmp == '15' ||
        widget.match.mmp == '16' ||
        widget.match.mmp == '40' ||
        widget.match.mmp == '21') {
      // 进入比赛时;
      calculateGraph();
    }
  }

  ///@description 时间倒计时
  ///@param {Number} 赛事进行时间
  calculateGraph() {
    showTime = int.parse(widget.match.mst);
    saveMatchTime();

    /// 初始化定时器
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!mounted) {
        return;
      }
      setState(() {
        if (showTime <= 0) {
          showTime = 0;
        } else {
          if (widget.match.mess == 0) {
            timer.cancel();
            showTime++;
          }
          showTime -= 1;
        }
        saveMatchTime();
        getSyncMatchTime();
      });
    });
  }
}

List<String> mmpArrBase = [
  '1',
  '2',
  '13',
  '14',
  '15',
  '16',
  '40',
  '301',
  '302',
  '303',
  '31',
  '100'
];

// 显示比赛时间
List<String> mmpArr = ['1', '2', '13', '14', '15', '16', '40'];

// 赛间休息;
List<String> mmpArr1 = ['301', '302', '303', '31'];
