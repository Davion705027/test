import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../services/models/res/match_entity.dart';
import '../../../../utils/format_score_util.dart';

/// 足球红牌、进球 动画
class FootBallAnimation extends StatefulWidget {
  const FootBallAnimation({
    super.key,
    required this.match,
  });

  final MatchEntity match;

  @override
  State<FootBallAnimation> createState() => _FootBallAnimationState();
}

class _FootBallAnimationState extends State<FootBallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // 比分和红牌数值变化时设置时间
  Map<String, int> scoreTime = {"S1": 0, "S11": 0};

  // 是否显示主队进球动画
  bool isShowHomeGoal = false;

  // 是否显示客队进球动画
  bool isShowAwayGoal = false;

  // 是否显示主队红牌动画
  bool isShowHomeRed = false;

  // 是否显示客队红牌动画
  bool isShowAwayRed = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    // 使用Tween从0到1进行渐变
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    // ..addListener(() {
    //   if (isShowHomeGoal ||
    //       isShowAwayGoal ||
    //       isShowHomeRed ||
    //       isShowAwayRed) {
    //     setState(() {});
    //   }
    //   // setState(() {});
    // });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FootBallAnimation oldWidget) {
    if (widget.match.mid == oldWidget.match.mid && widget.match.csid == "1") {
      // 比分变化 只有足球
      Map<String, dynamic> newS1Score = s1Score(widget.match);
      Map<String, dynamic> oldS1Score = s1Score(oldWidget.match);
      if (newS1Score["home"] != oldS1Score['home'] ||
          newS1Score["away"] != oldS1Score['away']) {
        // 主客队比分数值变化，则更新对应时间
        if (newS1Score["home"] > 0 || newS1Score["away"] > 0) {
          scoreTime["S1"] = DateTime.now().millisecondsSinceEpoch;
        }

        // 主队
        if (newS1Score["home"] > 0 && newS1Score["home"] > oldS1Score['home']) {
          resetEvent();
          isShowHomeGoal = (scoreTime["S1"] ?? 0) > (scoreTime["S11"] ?? 0);
          5.seconds.delay(() {
            if (mounted) {
              setState(() {
                isShowHomeGoal = false;
              });
            }
          });
        } else {
          isShowHomeGoal = false;
        }
        // 客队
        if (newS1Score["away"] > 0 && newS1Score["away"] > oldS1Score['away']) {
          resetEvent();
          isShowAwayGoal = (scoreTime["S1"] ?? 0) > (scoreTime["S11"] ?? 0);
          5.seconds.delay(() {
            if (mounted) {
              setState(() {
                isShowAwayGoal = false;
              });
            }
          });
        } else {
          isShowAwayGoal = false;
        }
      }

      // 红牌
      Map<String, dynamic> newS11Score = s11Score(widget.match);
      Map<String, dynamic> oldS11Score = s11Score(oldWidget.match);
      if (newS11Score["home"] != oldS11Score['home'] ||
          newS11Score["away"] != oldS11Score['away']) {
        // 主客队比分数值变化，则更新对应时间
        if (newS11Score["home"] > 0 || newS11Score["away"] > 0) {
          scoreTime["S11"] = DateTime.now().millisecondsSinceEpoch;
        }

        // 主队
        if (newS11Score["home"] > 0 &&
            newS11Score["home"] >= newS11Score['away']) {
          isShowHomeRed = !isShowHomeGoal &&
              (scoreTime["S11"] ?? 0) > (scoreTime["S1"] ?? 0);
          5.seconds.delay(() {
            if (mounted) {
              setState(() {
                isShowHomeRed = false;
              });
            }
          });
        } else {
          isShowHomeRed = false;
        }
        // 客队
        if (newS11Score["away"] > 0 &&
            newS11Score["away"] >= newS11Score['home']) {
          isShowAwayRed = !isShowAwayGoal &&
              (scoreTime["S11"] ?? 0) > (scoreTime["S1"] ?? 0);
          5.seconds.delay(() {
            if (mounted) {
              setState(() {
                isShowAwayRed = false;
              });
            }
          });
        } else {
          isShowAwayRed = false;
        }
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Row(
              children: [
                // 红牌
                isShowHomeRed
                    ? FadeTransition(
                        opacity: _animation,
                        child: Container(
                          width: 9.w,
                          height: 12.w,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF53F3F),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.r)),
                          ),
                        ),
                      ).marginOnly(right: 4.w)
                    : Container(),
                // 进球
                isShowHomeGoal
                    ? FadeTransition(
                        opacity: _animation,
                        child: AutoSizeText(
                          LocaleKeys.match_result_goal.tr,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontFamily: 'Akrobat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: Row(
              children: [
                isShowAwayGoal
                    ? FadeTransition(
                        opacity: _animation,
                        child: AutoSizeText(
                          LocaleKeys.match_result_goal.tr,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontFamily: 'Akrobat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : Container(),
                // 红牌
                isShowAwayRed
                    ? FadeTransition(
                        opacity: _animation,
                        child: Container(
                          width: 9.w,
                          height: 12.w,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF53F3F),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.r)),
                          ),
                        ),
                      ).marginOnly(left: 4.w)
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 重置
  resetEvent() {
    isShowHomeGoal = false;
    isShowAwayGoal = false;
    isShowHomeRed = false;
    isShowAwayRed = false;
  }

  Map<String, dynamic> s1Score(MatchEntity match) {
    Map<String, dynamic> score = {
      'home': 0,
      'away': 0,
      'mid': match.mid,
    };

    for (String item in match.msc) {
      if (item.split("|")[0] == "S1") {
        score = {
          'home': FormatScore.formatTotalScore(match, 0),
          'away': FormatScore.formatTotalScore(match, 1),
          'mid': match.mid,
        };
        break; // 只取第一个符合条件的比分
      }
    }

    return score;
  }

  Map<String, dynamic> s11Score(MatchEntity match) {
    Map<String, dynamic> score = {
      'home': 0,
      'away': 0,
    };

    for (String item in match.msc) {
      if (item.split("|")[0] == "S11") {
        List<String> scoreValues = item.split("|")[1].split(":");
        score = {
          'home': scoreValues.isNotEmpty ? scoreValues[0].toInt() : 0,
          'away': scoreValues.length > 1 ? scoreValues[1].toInt() : 0,
        };
        break; // 只取第一个符合条件的比分
      }
    }

    return score;
  }
}
