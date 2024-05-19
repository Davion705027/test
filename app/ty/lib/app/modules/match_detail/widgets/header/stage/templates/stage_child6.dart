import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../../db/app_cache.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../../utils/format_date_util.dart';

/// 详情页显示美式足球赛事第几节以及赛事时间
class StageChild6 extends StatefulWidget {
  const StageChild6(
      {super.key,
      required this.isPinnedAppbar,
      required this.match,
      required this.isMatchSelect});

  final bool isPinnedAppbar;
  final MatchEntity match;
  final bool isMatchSelect;

  @override
  State<StageChild6> createState() => _StageChild6State();
}

class _StageChild6State extends State<StageChild6> {
  /// 定时器
  Timer? timer;

  // 显示比赛时间的阶段
  List<String> mmpArr = ['13', '14', '15', '16', "40", "301", "302", "303"];

  // 赛事进行时间
  int showTime = 0;

  // 业务为局间休息(前端展示为赛事阶段)
  List<String> mmpArr1 = ["301", "302", "303"];

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
  void didUpdateWidget(covariant StageChild6 oldWidget) {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          "mmp_6_${detailDataMmp()}".tr,
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
        //  mlet的值控制是否显示倒计时 为空不显示
        if (widget.match.mlet != '')
          Row(
            children: [
              // 赛事计时器
              if (mmpArr.contains(widget.match.mmp) && showTime != 0)
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

              // 前端做兼容处理 赛事阶段未开赛+赛事状态进行中 默认显示每节赛事的时间
              if (widget.match.mmp == "0" && widget.match.ms == 1)
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
            ],
          ),
      ],
    );
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

  // *@description 美足赛事阶段显示
  // *@param {Undefined}
  // *@return {String} 赛事阶段
  detailDataMmp() {
    // 前端做兼容处理 赛事阶段未开赛+赛事状态进行中 默认显示第一节
    if (widget.match.mmp == '0' && widget.match.ms == 1) {
      // mmp=13 代表第一节
      return '13';
    } else {
      return widget.match.mmp;
    }
  }

  ///@description 判断赛事是暂停||开始
  initEvent() {
    if (widget.match.mess == 0 && !mmpArr1.contains(widget.match.mmp)) {
      showTime = int.parse(widget.match.mst);
      saveMatchTime();
    } else {
      initRestTime();
    }
  }

  ///@description 重置时间
  ///@param {Number} 赛事进行时间
  initRestTime() {
    // // 显示比赛时间的阶段且时间静止不动 因为是在赛事休息阶段
    if (mmpArr1.contains(widget.match.mmp)) {
      showTime = 900;
      saveMatchTime();
    } else if (mmpArr.sublist(0, 5).contains(widget.match.mmp)) {
      showTime = int.parse(widget.match.mst);
      // 正在比赛阶段时间正计时
      calculateGraph();
    }
  }

  ///@description 时间倒计时
  ///@param {Number} 赛事进行时间
  calculateGraph() {
    if (showTime <= 0) {
      showTime = 0;
    } else if (widget.match.mess == 1) {
      showTime -= 1;
    }
    saveMatchTime();
  }
}
