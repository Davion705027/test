import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../utils/bus/bus.dart';
import '../../../../../../utils/bus/event_enum.dart';
import '../../../../../../utils/format_score_util.dart';

/// 橄榄球
class ScoreChild14 extends StatefulWidget {
  const ScoreChild14({super.key, required this.match});

  final MatchEntity match;

  @override
  State<ScoreChild14> createState() => _ScoreChild14State();
}

class _ScoreChild14State extends State<ScoreChild14> {
  // 加时赛比分是否有
  String addScore = "";

  // 点球比分是否有
  String shootScore = "";

  List<String> scoreList = [];

  @override
  void initState() {
    initEvent();
    validateStage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ScoreChild14 oldWidget) {
    initEvent();
    validateStage();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 半场
        if (scoreList[1] != "" && collectionA.contains(widget.match.mmp))
          Text(
            "${LocaleKeys.match_info_half.tr}: ${FormatScore.scoreFormat(scoreList[1])}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Get.theme.scoreDetailColor,
              fontSize: 12.sp,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w700,
            ),
          ).marginOnly(right: 10.w),
        // 加时赛
        if (addScore != "" && collectionC.contains(widget.match.mmp))
          Text(
            "${LocaleKeys.match_info_add.tr}: ${FormatScore.scoreFormat(addScore)}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Get.theme.scoreDetailColor,
              fontSize: 12.sp,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w700,
            ),
          ).marginOnly(right: 10.w),
        // 点球大战
        if (shootScore != "" && collectionD.contains(widget.match.mmp))
          Text(
            "${LocaleKeys.match_info_shoot_out.tr}: ${FormatScore.scoreFormat(shootScore)}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Get.theme.scoreDetailColor,
              fontSize: 12.sp,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w700,
            ),
          ).marginOnly(right: 10.w),
        // 全场
        if (scoreList[0] != "" && collectionB.contains(widget.match.mmp))
          Text(
            "${LocaleKeys.match_info_full.tr}: ${FormatScore.scoreFormat(scoreList[0])}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Get.theme.scoreDetailColor,
              fontSize: 12.sp,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w700,
            ),
          ).marginOnly(right: 10.w),
      ],
    );
  }

  void initEvent() {
    List<String> scoreArr = [];

    List<String> msc = widget.match.msc;

    // sortBy方法  比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      int num1 = int.parse(a.split("|")[0].substring(1));
      int num2 = int.parse(b.split("|")[0].substring(1));
      return num1.compareTo(num2);
    });

    // 循环只取出接口返回的比分里面符合橄榄球阶段的比分
    for (String item in msc) {
      String numIndex = item.split("|")[0];

      // 加时赛
      if (numIndex == 'S7') {
        addScore = item.split("|")[1];
      }

      // 点球
      if (numIndex == 'S170') {
        shootScore = item.split("|")[1];
      }

      // 1全场  2上半场  7加时赛  170点球大战
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    }

    scoreList = scoreArr;
  }

  // 根据赛事阶段显示默认比分
  validateStage() {
    switch (widget.match.mmp) {
      case "34": //等待点球大战阶段 前端显示点球大战 S170是点球大战比分
        Bus.getInstance().emit(EventType.nativeDetailData, 'S170|0:0');
        break;
    }
  }
}

// 1全场  2上半场  7加时赛  170点球大战
List<String> mscArray = ["S1", "S2", "S7", "S170"];

// 展示上半场比分阶段
List<String> collectionA = [
  '6',
  '31',
  '7',
  '41',
  '100',
  '32',
  '33',
  '42',
  '110',
  '34',
  '50',
  '120',
  '999',
  '443',
  '440',
  '444'
];
// 展示全场比分阶段
List<String> collectionB = [
  '7',
  '41',
  '100',
  '32',
  '33',
  '42',
  '110',
  '34',
  '50',
  '120',
  '999',
  '443',
  '440',
  '444'
];
// 加时赛阶段
List<String> collectionC = [
  '32',
  '41',
  '33',
  '42',
  '443',
  '440',
  '444',
  '110',
  '999'
];
// 点球阶段
List<String> collectionD = ['34', '50', '120', '999'];
