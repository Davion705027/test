import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../utils/bus/bus.dart';
import '../../../../../../utils/bus/event_enum.dart';
import '../../../../../../utils/format_score_util.dart';

/// 水球
class ScoreChild16 extends StatefulWidget {
  const ScoreChild16({super.key, required this.match});

  final MatchEntity match;

  @override
  State<ScoreChild16> createState() => _ScoreChild16State();
}

class _ScoreChild16State extends State<ScoreChild16> {
  @override
  void initState() {
    validateStage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ScoreChild16 oldWidget) {
    validateStage();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    List<String> scoreList = scoreArray(widget.match);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 常规4节比赛
        // mmp （13 第一节）（14 301 第二节）（15 302 第三节）（16 303 第四节）
        if (modelA.contains(widget.match.mmp) && widget.match.mo != 1)
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

        // 水球点球比分展示
        if (modelB.contains(widget.match.mmp))
          // 常规四节比分
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              if (penaltyScore(widget.match) != "")
                Text(
                  "${LocaleKeys.match_info_shoot_out.tr}: (${FormatScore.scoreFormat(penaltyScore(widget.match))})",
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

  /// 比分集合
  List<String> scoreArray(MatchEntity match) {
    List<String> scoreArr = [];
    List<String> msc = match.msc;
    // 比分升序排列，取出比分阶段后面的数字作为判断条件
    msc.sort((a, b) {
      int num1 = int.parse(a.split("|")[0].substring(1));
      int num2 = int.parse(b.split("|")[0].substring(1));
      return num1.compareTo(num2);
    });

    // 循环只取出符合水球球阶段的比分
    for (String item in msc) {
      String numIndex = item.split("|")[0];
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    }

    return scoreArr;
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

  validateStage() {
    switch (widget.match.mmp) {
      case "301": //301 第一节结束   S20 第二节比分(水球)
        Bus.getInstance().emit(EventType.nativeDetailData, 'S20|0:0');
        break;
      case "302": //302 第二节结束 S21 第三节比分(水球)
        Bus.getInstance().emit(EventType.nativeDetailData, 'S21|0:0');
        break;
      case "303": //303  第三节结束 S22 第四节比分(水球)
        Bus.getInstance().emit(EventType.nativeDetailData, 'S22|0:0');
        break;
      case "34": //等待点球大战阶段 前端显示点球大战 S170是点球大战比分
        Bus.getInstance().emit(EventType.nativeDetailData, 'S170|0:0');
        break;
    }
  }
}

// 常规4节比赛
List<String> modelA = ['13', '14', '15', '16', '301', '302', '303', '999'];

// 点球阶段
List<String> modelB = ["34", "50", "120", '100', '999'];

// 常规4节比赛的比分
List<String> mscArray = ['S19', 'S20', 'S21', 'S22'];
