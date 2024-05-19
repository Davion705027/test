import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../utils/bus/bus.dart';
import '../../../../../../utils/bus/event_enum.dart';
import '../../../../../../utils/format_score_util.dart';

import '../../../../../../routes/app_pages.dart';

/// 曲棍球
class ScoreChild15 extends StatefulWidget {
  const ScoreChild15({super.key, required this.match});

  final MatchEntity match;

  @override
  State<ScoreChild15> createState() => _ScoreChild15State();
}

class _ScoreChild15State extends State<ScoreChild15> {
  @override
  void initState() {
    validateStage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ScoreChild15 oldWidget) {
    validateStage();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.match.ms != 111 && widget.match.mbmty != 3) {
      List<String> scoreList = scoreArray(widget.match);
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 计时赛
          // mmp32 等待加时 40加时赛 110加时赛结束
          // msc S7表示公共加时赛比分

          // 上半场、下半场模式
          // mmp 1上半场 2下半场 31中场休息
          if (modelA.contains(widget.match.mmp) &&
              widget.match.mle == 17 &&
              ![Routes.matchResultsDetails].contains(Get.currentRoute))
            ...scoreList.map((e) {
              int index = scoreList.indexOf(e) + 1;
              return Text(
                "${index}H${FormatScore.scoreFormat(e)}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: index == scoreList.length
                      ? Get.theme.scoreDetailColor
                      : Colors.white,
                  fontSize: 12.sp,
                  fontFamily: 'Akrobat',
                  fontWeight: index == scoreList.length
                      ? FontWeight.w700
                      : FontWeight.w600,
                ),
              ).marginOnly(right: 10.w);
            }).toList(),

          // 常规四节比赛
          // mmp（13第一节）（14 301 第二节）（15 302第三节）（16 303第四节）
          if (modelB.contains(widget.match.mmp) && widget.match.mo != 1)
            ...scoreList.map((e) {
              int index = scoreList.indexOf(e) + 1;
              return Text(
                FormatScore.scoreFormat(e),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: index == scoreList.length
                      ? Get.theme.scoreDetailColor
                      : Colors.white,
                  fontSize: 12.sp,
                  fontFamily: 'Akrobat',
                  fontWeight: index == scoreList.length
                      ? FontWeight.w700
                      : FontWeight.w600,
                ),
              ).marginOnly(right: 10.w);
            }).toList(),
          // modelC 加时赛 || modelD 点球阶段
          // mmp 32 等待加时 40-加时赛 110 加时赛结束
          if (modelC.contains(widget.match.mmp) ||
              modelD.contains(widget.match.mmp))
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 区分modelA 上下半场赛制 or modelB 1234节赛制
                if (scoreList.length == 2)
                  ...scoreList.map((e) {
                    int index = scoreList.indexOf(e) + 1;
                    return Text(
                      "${index}H${FormatScore.scoreFormat(e)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: index == scoreList.length
                            ? Get.theme.scoreDetailColor
                            : Colors.white,
                        fontSize: 12.sp,
                        fontFamily: 'Akrobat',
                        fontWeight: index == scoreList.length
                            ? FontWeight.w700
                            : FontWeight.w600,
                      ),
                    ).marginOnly(right: 10.w);
                  }).toList(),
                if (scoreList.length == 4)
                  ...scoreList.map((e) {
                    int index = scoreList.indexOf(e) + 1;
                    return Text(
                      FormatScore.scoreFormat(e),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: index == scoreList.length
                            ? Get.theme.scoreDetailColor
                            : Colors.white,
                        fontSize: 12.sp,
                        fontFamily: 'Akrobat',
                        fontWeight: index == scoreList.length
                            ? FontWeight.w700
                            : FontWeight.w600,
                      ),
                    ).marginOnly(right: 10.w);
                  }).toList(),
                // 加时赛比分展示
                if (extraTime(widget.match) != "")
                  Text(
                    "${LocaleKeys.match_info_add.tr}: ${FormatScore.scoreFormat(extraTime(widget.match))}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Get.theme.scoreDetailColor,
                      fontSize: 12.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                    ),
                  ).marginOnly(right: 10.w),
                // 点球比分展示
                if (penaltyScore(widget.match) != "")
                  Text(
                    "${LocaleKeys.match_info_shoot_out.tr}: ${FormatScore.scoreFormat(penaltyScore(widget.match))}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Get.theme.scoreDetailColor,
                      fontSize: 12.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                    ),
                  ).marginOnly(right: 10.w),
              ],
            ),
        ],
      );
    }
    return Container();
  }

  /// 比分集合
  List<String> scoreArray(MatchEntity match) {
    List<String> scoreArr = [];
    List<String> msc = match.msc;

    // sortBy方法  比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      int num1 = int.parse(a.split("|")[0].substring(1));
      int num2 = int.parse(b.split("|")[0].substring(1));
      return num1.compareTo(num2);
    });

    // 循环只取出接口返回的比分里面符合篮球球阶段的比分
    if (match.mlet == '17' || match.mle == 17) {
      for (String item in msc) {
        String numIndex = item.split("|")[0];
        if (mscArray1.contains(numIndex)) {
          scoreArr.add(item.split("|")[1]);
        }
      }
    } else {
      // 常规4节比赛的比分
      for (String item in msc) {
        String numIndex = item.split("|")[0];
        if (mscArray.contains(numIndex)) {
          scoreArr.add(item.split("|")[1]);
        }
      }
    }

    return scoreArr;
  }

  /// 加时赛比分  msc:S7
  String extraTime(MatchEntity match) {
    String extra = "";
    List<String> msc = match.msc;

    for (String item in msc) {
      String numIndex = item.split("|")[0];
      if (numIndex == "S7") {
        extra = item.split("|")[1];
        break;
      }
    }

    return extra;
  }

  /// msc S170 点球大战比分 水球
  String penaltyScore(MatchEntity match) {
    String penalty = "";
    List<String> msc = match.msc;
    for (String item in msc) {
      String numIndex = item.split("|")[0];
      if (numIndex == "S170") {
        penalty = item.split("|")[1];
        break;
      }
    }

    return penalty;
  }

  // 根据赛事阶段显示默认比分
  validateStage() {
    switch (widget.match.mmp) {
      case "301": //301 第一节结束   S20 第二节比分
        Bus.getInstance().emit(EventType.nativeDetailData, 'S20|0:0');
        break;
      case "302": //302 第二节结束 S21 第三节比分
        Bus.getInstance().emit(EventType.nativeDetailData, 'S21|0:0');
        break;
      case "303": //303  第三节结束 S22 第四节比分
        Bus.getInstance().emit(EventType.nativeDetailData, 'S22|0:0');
        break;
      case "31": //31  上半场结束S3下半场比分
        Bus.getInstance().emit(EventType.nativeDetailData, 'S3|0:0');
        break;
      case "34": //等待点球大战阶段 前端显示点球大战 S170是点球大战比分
        Bus.getInstance().emit(EventType.nativeDetailData, 'S170|0:0');
        break;
    }
  }
}

// 上半场，下半场赛事阶段
List<String> modelA = ['1', '2', '31', '999'];

// 常规4节比赛阶段
List<String> modelB = ['13', '14', '15', '16', '301', '302', '303', '999'];

// 常规4节比赛的比分
List<String> mscArray = ['S19', 'S20', 'S21', 'S22'];

// 上下半场比分
List<String> mscArray1 = ['S2', 'S3'];
// 加时赛阶段
List<String> modelC = ['32', '40', '110', '440', '443', '444', '999'];
// 点球阶段
List<String> modelD = ["34", "50", "120", '999'];
