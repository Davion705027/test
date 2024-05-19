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

/// 美式足球
class ScoreChild6 extends StatefulWidget {
  const ScoreChild6({super.key, required this.match});

  final MatchEntity match;

  @override
  State<ScoreChild6> createState() => _ScoreChild6State();
}

class _ScoreChild6State extends State<ScoreChild6> {
  @override
  void initState() {
    validateStage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ScoreChild6 oldWidget) {
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
        // 常规四节比赛
        // mmp （13 第一节）（14 301 第二节）（15 302第三节）（16 303 第四节）
        if (modelA.contains(widget.match.mmp) && widget.match.mo != 1)
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

        // 加时赛
        // mmp 32 等待加时 40-加时赛 110 加时赛结束 100 完赛 999 完赛
        if (modelB.contains(widget.match.mmp) && scoreList.length == 4)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 历史比分
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
              if (extraTime(widget.match) != "" && widget.match.mmp != "32")
                Text(
                  "OT: ${FormatScore.scoreFormat(extraTime(widget.match))}",
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

    // sortBy方法  比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      int num1 = int.parse(a.split("|")[0].substring(1));
      int num2 = int.parse(b.split("|")[0].substring(1));
      return num1.compareTo(num2);
    });

    // 循环只取出接口返回的比分里面符合美足球阶段的比分
    for (String item in msc) {
      String numIndex = item.split("|")[0];
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
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
      case "40": //40 加时赛 S7 加时赛比分
        Bus.getInstance().emit(EventType.nativeDetailData, 'S7|0:0');
        break;
        break;
    }
  }
}

// 常规4节比赛
List<String> modelA = ['13', '14', '15', '16', '301', '302', '303', '999'];

// 加时赛比赛以及完赛
List<String> modelB = ['32', '40', '100', '110', '999', '999'];

//第1 2 3 4节比分
List<String> mscArray = ['S19', 'S20', 'S21', 'S22'];
