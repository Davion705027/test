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

/// 水球
class StageChild16 extends StatefulWidget {
  const StageChild16(
      {super.key,
      required this.isPinnedAppbar,
      required this.match,
      required this.isMatchSelect});

  final bool isPinnedAppbar;
  final MatchEntity match;
  final bool isMatchSelect;

  @override
  State<StageChild16> createState() => _StageChild16State();
}

class _StageChild16State extends State<StageChild16> {
  /// 定时器
  Timer? timer;

  // 显示比赛时间的阶段
  List<String> mmpArr = ['13', '14', '15', '16'];

  // 赛事进行时间
  int showTime = 0;

  List<String> mmpArr1 = ['301', '302', '303'];

  @override
  void didUpdateWidget(covariant StageChild16 oldWidget) {
    // 比赛的时候，更新mst时间
    if (mmpArr.contains(widget.match.mmp)) {
      if (widget.match.mess == 0) {
        timer?.cancel();
      } else if (widget.match.mess == 1) {
        initRestTime();
      }
    } else {
      initRestTime();
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
            "mmp_16_${widget.match.mmp}".tr,
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
          // 四节休息阶段显示每节总时间
          if (mmpArr1.contains(widget.match.mmp))
            AutoSizeText(
              widget.match.mlet,
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
          // 四节比赛阶段显示计时器
          if (!mmpArr1.contains(widget.match.mmp) && showTime > 0)
            AutoSizeText(
              LocaleKeys.detail_less.tr +
                  FormatDate.formatMinTime(showTime) +
                  LocaleKeys.detail_mins.tr,
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

  ///@description 重置时间
  ///@param {Number} 赛事进行时间
  initRestTime() {
    timer?.cancel();
    if (mmpArr1.contains(widget.match.mmp)) {
      showTime =
          (widget.match.mlet.split(":")[0] == '8' || widget.match.mle == 0)
              ? 480
              : 0;
      saveMatchTime();
    } else if (mmpArr.contains(widget.match.mmp)) {
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
      setState(() {
        if (showTime <= 0) {
          timer.cancel();
          showTime = 0;
        } else {
          showTime -= 1;
        }
        saveMatchTime();
      });
    });
  }
}
