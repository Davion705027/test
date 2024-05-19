import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../utils/bus/bus.dart';
import '../../../../utils/bus/event_enum.dart';
import '../../../../utils/format_date_util.dart';
import '../../../../utils/format_score_util.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/scroll_index_widget.dart';
import 'football_animation.dart';
import 'stage/match_between_score.dart';
import 'stage/match_stage.dart';

/// 详情页视频区域中部(主副队logo+主副队名+赛事[阶段+时间+比分])
class HeaderMiddle extends StatefulWidget {
  const HeaderMiddle(
      {super.key, required this.match, required this.controller});

  final MatchEntity match;
  final MatchDetailController controller;

  @override
  State<HeaderMiddle> createState() => _HeaderMiddleState();
}

class _HeaderMiddleState extends State<HeaderMiddle> {
  /// 定时器
  Timer? timer;

  /// 赛事开始倒计时时间（赛事开始时间-当前时间）
  String longTime = "";

  // 赛事开赛时间倒计时是否显示
  bool startTime = true;

  @override
  void initState() {
    initEvent();

    // 联赛修改触发初始化
    Bus.getInstance().on(EventType.matchTimeInit, (_) {
      initEvent();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    Bus.getInstance().off(EventType.matchTimeInit);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HeaderMiddle oldWidget) {
    if (oldWidget.match.mgt != widget.match.mgt) {
      initEvent();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildVsTeam(widget.match, widget.controller),

          /// 赛事阶段展示
          _buildStage(),
          // 进球 红牌动画
          if (widget.match.csid == "1")
            FootBallAnimation(
              match: widget.match,
            ),
        ],
      ),
    );
  }

  _buildStage() {
    return Container(
      constraints: BoxConstraints(minWidth: 87.w, maxWidth: 150.w),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 展示赛事阶段，开赛时间以及倒计时等
          if (widget.match.ms != 110)
            MatchStage(
              match: widget.match,
            ),

          SizedBox(height: 2.h),
          // 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断
          // 比赛分数or开赛时间
          if (matchStageContentBottom() != "")
            AutoSizeText(
              matchStageContentBottom(),
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: getMatchStageBottomContentFontSize(),
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w700,
              ),
            ),

          /// 局间比分 联赛下拉不展示局间比分
          if (showMatchBetweenScore()) MatchBetweenScore(match: widget.match),
        ],
      ),
    );
  }

  _buildVsTeam(MatchEntity match, MatchDetailController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 151.5.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 队徽 type 0表示主队 mhlu主队的url
              // 双打情况
              match.mhlu.length > 1
                  ? SizedBox(
                      width: 74.w,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 44.w,
                              height: 44.w,
                              alignment: Alignment.center,
                              child: ImageView(
                                (match.mhlu as List).safe(0),
                                width: 40.w,
                                height: 40.w,
                                cdn: true,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 30.w,
                            child: Container(
                              width: 44.w,
                              height: 44.w,
                              alignment: Alignment.center,
                              child: ImageView(
                                (match.mhlu as List).safe(1),
                                width: 40.w,
                                height: 40.w,
                                cdn: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : // 单打
                  Container(
                      width: 44.w,
                      height: 44.w,
                      alignment: Alignment.center,
                      child: controller.detailState.isDJDetail
                          ? ImageView(
                              (match.mhlu as List).safeFirst,
                              width: 40.w,
                              height: 40.w,
                              dj: true,
                            )
                          : ImageView(
                              (match.mhlu as List).safeFirst,
                              width: 40.w,
                              height: 40.w,
                              cdn: true,
                              // cdn: true,
                            ),
                    ),

              SizedBox(height: 4.h),
              Container(
                alignment: Alignment.center,
                width: 100.w,
                child: Text(
                  controller.getTeamName(type: 1, match: match),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 151.5.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 双打情况
              match.malu.length > 1
                  ? SizedBox(
                      width: 74.w,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 44.w,
                              height: 44.w,
                              alignment: Alignment.center,
                              child: ImageView(
                                (match.malu as List).safe(0),
                                width: 40.w,
                                height: 40.w,
                                cdn: true,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 30.w,
                            child: Container(
                              width: 44.w,
                              height: 44.w,
                              alignment: Alignment.center,
                              child: ImageView(
                                (match.malu as List).safe(1),
                                width: 40.w,
                                height: 40.w,
                                cdn: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : // 单打
                  Container(
                      width: 44.w,
                      height: 44.w,
                      alignment: Alignment.center,
                      child: controller.detailState.isDJDetail
                          ? ImageView(
                              (match.malu as List).safeFirst,
                              width: 40.w,
                              height: 40.w,
                              dj: true,
                            )
                          : ImageView(
                              (match.malu as List).safeFirst,
                              width: 40.w,
                              height: 40.w,
                              cdn: true,
                              // cdn: true,
                            ),
                    ),
              SizedBox(height: 4.h),
              Container(
                alignment: Alignment.center,
                width: 119.w,
                child: Text(
                  controller.getTeamName(type: 2, match: match),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
    int longTimeTemp = (mgt - nowTimeStamp) / 1000 ~/ 60;

    // 赛事开赛时间倒计时为0的时候 让倒计时显示为1分钟
    if (longTimeTemp == 0) {
      longTimeTemp += 1;
    }

    startTime = startTimeTemp;

    // 计算出来的倒计时时间赋值给data的变量显示在页面上
    longTime = longTimeTemp.toString();

    /// 初始化定时器
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!mounted || isScrolling) {
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
          // 此时同步更新match_stage组件的时间
          Bus.getInstance().emit(EventType.matchNoStart, null);
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

  /// 赛事阶段显示内容 下部分(比赛时间or开赛时间)
  String matchStageContentBottom() {
    int ms = widget.match.ms;
    // 赛事未开赛
    if (ms == 0) {
      // 即将开赛的赛事不显示日期
      if (startTime) {
        // 距离开赛时间小于一个小时 显示倒计时 (分钟)
        return LocaleKeys.list_after_time_start.tr.replaceAll("{0}", longTime);
      } else {
        // 格式化显示HH:MM
        return FormatDate.formatHHMM(int.tryParse(widget.match.mgt) ?? 0);
      }
    }
    // 赛前切滚球 ms = 110时：显示即将开赛
    else if (ms == 110) {
      return "ms_$ms".tr;
    } else if ([1, 2, 3, 4].contains(ms)) {
      // 显示比分
      return "${FormatScore.formatTotalScore(widget.match, 0)} - ${FormatScore.formatTotalScore(widget.match, 1)}";
    }
    return "";
  }

  /// 赛事阶段显示内容 下部分 字体
  double getMatchStageBottomContentFontSize() {
    int ms = widget.match.ms;
    // 赛事未开赛
    if (ms == 0) {
      // 即将开赛的赛事不显示日期
      if (startTime) {
        // 距离开赛时间小于一个小时 显示倒计时 (分钟)
        return 12.sp;
      } else {
        // 显示HH：mm
        return 30.sp;
      }
    }
    // 赛前切滚球 ms = 110时：显示即将开赛
    else if (ms == 110) {
      return 12.sp;
    } else if ([1, 2, 3, 4].contains(ms)) {
      // 显示比分
      return 30.sp;
    }
    return 30.sp;
  }

  /// 局间比分显示逻辑：滚球阶段ms=1并且对应赛种才显示
  /// ms 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断
  /// 4--冰球, 5--网球, 7--斯诺克, 8--乒乓球, 9--排球, 10--羽毛球, 13--沙滩排球,14--橄榄球, 15--曲棍球, 16--水球
  ///  A代表ACE，就是俗称的发球直接得分！
  bool showMatchBetweenScore() {
    List<String> msc = widget.match.msc;
    if (["3", "4", "5", "7", "6", "8", "9", "10", "13", "14", "15", "16"]
            .contains(widget.match.csid) &&
        widget.match.ms == 1 &&
        msc.isNotEmpty &&
        widget.match.mmp != "999") {
      return true;
    }
    return false;
  }
}
