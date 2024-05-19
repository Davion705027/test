import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../utils/format_score_util.dart';
import '../../../../match_detail/widgets/header/score/templates/score_child3.dart';

/// 列表比分条
class ScoreList extends StatefulWidget {
  const ScoreList({super.key, required this.match, this.edition = 1});

  final MatchEntity match;
  final int edition; // 1专业版 2新手版
  @override
  State<ScoreList> createState() => _ScoreListState();
}

class _ScoreListState extends State<ScoreList> {
  //当前最新的盘/局比分
  String lastListScore = '';

  //比分转换为数组的数据
  List<List<String>> mscConverted = [];
  bool showLeftTriangle = false;
  bool showRightTriangle = false;

  @override
  void didUpdateWidget(covariant ScoreList oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (!_showScoreMatchLine(widget.match)) {
      return Container();
    }
    // 赛事比分变化
    getMscConverted();
    getLastListScore();
    int csid = int.tryParse(widget.match.csid) ?? 0;
    return Row(
      mainAxisAlignment: [3].contains(csid)
          ? MainAxisAlignment.end
          : widget.edition == 2
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
      children: [
        /// 网球不显示详细比分 bug id：63304
        if ('mmp_${widget.match.csid}_${widget.match.mmp}' != "mmp_5_8")
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (mscConverted.length > 1)
                ...mscConverted.map((e) {
                  int i = mscConverted.indexOf(e);

                  // 超过多少显示... 的基数
                  int showUnit = [7].contains(csid) ? 3 : 4;
                  if (isShowScore(widget.match, e) &&
                      i < mscConverted.length - 1) {
                    return Row(
                      children: [
                        // 角球图标
                        if (widget.match.csid == "1" &&
                            e[0] == 'S5' &&
                            e.length > 4)
                          Container(),
                        // HT半场或 FT全场 或 OT
                        if (e.length > 4 &&
                            [1, 11, 14, 15, 16].contains(csid) &&
                            e[4] != '' &&
                            e[0] != 'S5')
                          Text(e[4]),
                        // 比分
                        if (e.length > 2 && i < showUnit)
                          Text(
                            '${e[1]}-${e[2]}',
                            style: TextStyle(
                                color: (i == mscConverted.length - 1)
                                    ? const Color.fromRGBO(23, 156, 255, 1)
                                    : Get.isDarkMode
                                        ? const Color.fromRGBO(175, 179, 200, 1)
                                        : const Color.fromRGBO(0, 0, 0, 0.8),
                                fontSize: 10.sp),
                          ).marginOnly(left: 4.w),
                        // 超过showUnit个 显示 ...
                        if (i == showUnit)
                          Text(
                            "...",
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? const Color.fromRGBO(175, 179, 200, 1)
                                    : const Color.fromRGBO(0, 0, 0, 0.8),
                                fontSize: 10.sp),
                          ).marginOnly(left: 4.w),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }).toList(),
              // 当前比分
              if (mscConverted.isNotEmpty)
                Text(
                  '${mscConverted.safeLast?[1]}-${mscConverted.safeLast?[2]}',
                  style: TextStyle(
                      color: const Color.fromRGBO(23, 156, 255, 1),
                      fontSize: 10.sp),
                ).marginOnly(left: 4.w),
            ],
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 总分、回合数、总局数
            if ([2, 5, 6, 7, 8, 9, 10, 13, 14, 15, 16].contains(csid))
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 总分
                  if ([6].contains(csid) && getTotalScores(widget.match) != '')
                    Text(
                      "${LocaleKeys.list_total_pp_score_count.tr} ${getTotalScores(widget.match)}",
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(175, 179, 200, 1)
                              : const Color.fromRGBO(0, 0, 0, 0.8),
                          fontSize: 10.sp),
                    ),
                  // 赛事回合数mfo
                  if (ObjectUtil.isNotEmpty(widget.match.mfo))
                    Text(
                      widget.match.mfo,
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(175, 179, 200, 1)
                              : const Color.fromRGBO(0, 0, 0, 0.8),
                          fontSize: 10.sp),
                    ).marginSymmetric(horizontal: 4.w),
                  // 即将开赛不显示
                  if (![1, 2, 3, 11].contains(csid) && widget.match.ms != 110)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 总局数
                        if (![4, 6, 7, 8, 9, 10, 13, 14, 15, 16].contains(csid))
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${LocaleKeys.list_total_play_count.tr} ",
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? const Color.fromRGBO(175, 179, 200, 1)
                                        : const Color.fromRGBO(0, 0, 0, 0.8),
                                    fontSize: 10.sp),
                              ),
                              Text(
                                totalGames(),
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(23, 156, 255, 1),
                                    fontSize: 10.sp),
                              ),
                            ],
                          ),
                        // <!-- 总分   5--网球， 5--美式足球， 7--斯诺克， 8--乒乓球， 9--排球， 10--羽毛球，-->
                        if ([7, 8, 9, 10, 13, 15, 16].contains(csid) &&
                            getTotalScores(widget.match) != '')
                          Text(
                            "${LocaleKeys.list_total_pp_score_count.tr} ",
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? const Color.fromRGBO(175, 179, 200, 1)
                                    : const Color.fromRGBO(0, 0, 0, 0.8),
                                fontSize: 10.sp),
                          ).marginOnly(right: 4.w),
                        if ([7, 8, 9, 10, 13, 14, 15, 16].contains(csid) &&
                            getTotalScores(widget.match) != '')
                          Text(
                            totalGames(),
                            style: TextStyle(
                                color: const Color.fromRGBO(23, 156, 255, 1),
                                fontSize: 10.sp),
                          ),
                      ],
                    ),
                ],
              ),

            //  棒球3 出局 一垒二垒三垒
            if (csid == 3)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 12.w,
                    height: 12.h,
                    child: RepaintBoundary(
                      child: CustomPaint(
                        painter: BaseballDiamondPainter(
                          mbolp: widget.match.mbolp == "1",
                          mbthlp: widget.match.mbthlp == "1",
                          mbtlp: widget.match.mbtlp == "1",
                          mbColor: const Color.fromRGBO(18, 125, 204, 1),
                          normalColor: const Color.fromRGBO(201, 205, 219, 0.8),
                        ),
                      ),
                    ),
                  ).marginOnly(right: 8.w),
                  Text(
                    "${LocaleKeys.match_info_strike_out.tr} ${widget.match.mbcn ?? '0'}",
                    style: TextStyle(
                        color: Get.isDarkMode
                            ? const Color.fromRGBO(255, 255, 255, 0.3)
                            : const Color.fromRGBO(175, 179, 200, 1),
                        fontSize: 12.sp),
                  ),
                ],
              ).marginOnly(left: 8.w)
          ],
        ),
      ],
    ).marginSymmetric(vertical: 4.h);
  }

  /// 判断单个比分是否显示
  /// @param match 赛事对象
  /// @param score 比分数组
  /// @return bool
  bool isShowScore(MatchEntity match, List<String> score) {
    bool f = false;
    if (score.isNotEmpty) {
      // C01赛事屏蔽角球总比分S5,黄牌比分S12,红牌比分S11,点球比分S10
      if (match.cds == 'RC' &&
          match.csid == "1" &&
          ['S5', 'S10', 'S11', 'S12'].contains(score[0])) {
        return f;
      }
      if (score.length > 2 && score[1] != '-' && score[2] != '-') {
        if ([1, 11, 14, 15, 16].contains(int.tryParse(match.csid))) {
          f = true;
        }
        if ((match.csid != "1" || match.csid != "11") && score[0] != 'S1') {
          f = true;
        }
      }
    }

    return f;
  }

  /// @description: 获取最新比分赋值给last_list_score
  getLastListScore() {
    List<List<String>> mscConverted = getMscConverted();
    int i = mscConverted.length - 1;
    int h = 0, a = 0;
    try {
      if (mscConverted[i][1] != "-") {
        h = int.tryParse(mscConverted[i][1].toString()) ?? 0;
      }
      if (mscConverted[i][2] != "-") {
        a = int.tryParse(mscConverted[i][2].toString()) ?? 0;
      }
    } catch (e) {
      print(e.toString());
    }
    if (!h.isNaN && !a.isNaN) {
      lastListScore = '$h-$a';
    }
  }

  /// @description: 比分区域是否显示
  /// @param {Object} match 赛事对象
  /// @return {Boolean} 比分区域是否显示
  _showScoreMatchLine(MatchEntity match) {
    // 网斯乒羽(5,7,8,10)  棒冰美排(3、4、6、9)
    int csid = int.tryParse(match.csid) ?? 0;
    bool result = false;
    result = match.ms == 1 &&
        [
          // 1,
          2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
        ].contains(csid);
    return result;
  }

  // 所有盘/局加起来的总比分
  String getTotalScores(MatchEntity match) {
    //4冰球 8乒乓球 9排球 10羽毛球 13 16不统计S1
    int csid = int.tryParse(match.csid) ?? 0;

    List<List<String>> mscFormat = getMscConverted();
    int home = int.tryParse(match.homeScore) ?? 0;
    int away = int.tryParse(match.awayScore) ?? 0;

    if (mscFormat.isNotEmpty) {
      int total = home + away;
      String totalSum = total != 0 ? "($total)" : '';

      // Handling specific csid values
      if ([7, 12].contains(csid)) {
        // return getSnookerScoreSpaceData();
      } else if ([2, 4, 5, 6].contains(csid)) {
        int scoreSub = (home - away).abs();
        return total.toString();
      } else if ([14, 15].contains(csid)) {
        String? found =
            match.msc.firstWhereOrNull((score) => score.contains('S1|'));
        if (found != null) {
          String scoreStr = found.split('S1|')[1];
          List<String> scores = scoreStr.split(':');
          home = int.tryParse(scores[0]) ?? 0;
          away = int.tryParse(scores[1]) ?? 0;
          total = home + away;
          totalSum = total != 0 ? "[$total]" : '';
        } else {
          home = 0;
          away = 0;
          totalSum = "0";
        }
      }

      String result = '';
      if (home == 0 && away == 0 && totalSum.isEmpty) {
        result = "0";
      } else {
        result = '$home-$away$totalSum';
      }

      if ([14].contains(csid)) {
        result = totalSum;
      }

      return result;
    }
    return '';
  }

  List<List<String>> getMscConverted() {
    List<String> msc = widget.match.msc;
    List<List<String>> r0 = [];

    if (msc.isNotEmpty) {
      List<List<String>> f = FormatScore.scoreSwitchHandle(widget.match);
      // if (widget.match.csid == "7" || widget.match.csid == "12") {
      //   if (f != null && f.isNotEmpty) {
      //     r0 = f;
      //   }
      //   if (s1Score != null) {
      //     snoockerS1.value = s1Score;
      //   }
      // } else {
      //   if (f != null && f.isNotEmpty) {
      //     r0 = f;
      //   }
      // }
      if (f.isNotEmpty) {
        r0 = f;
      }
      mscConverted = f.where((element) => (element[1] != '-')).toList();
    }

    if (mscConverted.isEmpty) {
      mscConverted = [
        ["0", "0", "0"]
      ];
    }
    if (r0.isEmpty) {
      r0 = [
        ["0", "0", "0"]
      ];
    }

    if (mscConverted.isEmpty) {
      showRightTriangle = false;
    }

    return r0;
  }

  /// @description 总局数
  String totalGames() {
    int length = mscConverted.length;
    if (length < 1) return '';
    int homeGame = 0;
    int awayGame = 0;
    mscConverted.forEach((t) {
      /// 修复乒乓球总分计算错误
      if (t[0] != 'S1') {
        homeGame += int.tryParse(t[1]) ?? 0;
        awayGame += int.tryParse(t[2]) ?? 0;
      }
    });
    return '$homeGame-$awayGame (${homeGame + awayGame})';
  }
}
