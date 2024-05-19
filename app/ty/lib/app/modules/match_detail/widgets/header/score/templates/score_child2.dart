import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../../routes/app_pages.dart';
import '../../../../../../utils/bus/bus.dart';
import '../../../../../../utils/bus/event_enum.dart';
import '../../../../../../utils/format_score_util.dart';

/// 篮球比分模板
class ScoreChild2 extends StatefulWidget {
  const ScoreChild2({super.key, required this.match});

  final MatchEntity match;

  @override
  State<ScoreChild2> createState() => _ScoreChild2State();
}

class _ScoreChild2State extends State<ScoreChild2> {
  @override
  void initState() {
    validateStage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ScoreChild2 oldWidget) {
    validateStage();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.match.ms != 111 && widget.match.mle != 73) {
      // 加时赛
      // mmp 32 等待加时  40 加时赛  110加时赛结束
      // msc S7表示公共加时赛比分

      List<String> scoreList = basketballScoreArray(widget.match);
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 上半场，下半场模式
          // mmp  1.上半场 2.下半场 31.中场休息
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

          // 常规4节比赛
          // mmp （13 第一节）（14 301 第二节）（15 302 第三节）（16 303 第四节）
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

          // 加时赛
          // mmp 32 等待加时  40 加时赛  110加时赛结束
          if (modelC.contains(widget.match.mmp))
            // 区分model_a or model_b
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (scoreList.length == 2)
                  Row(
                    children: [
                      ...scoreList.map((e) {
                        int index = scoreList.indexOf(e) + 1;
                        return Text(
                          "${index}H ${FormatScore.scoreFormat(e)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontFamily: 'Akrobat',
                            fontWeight: FontWeight.w600,
                          ),
                        ).marginOnly(right: 10.w);
                      }).toList(),
                      if (getExtraTime(widget.match) != "")
                        Text(
                          "${LocaleKeys.match_info_add.tr}${FormatScore.scoreFormat(getExtraTime(widget.match))}",
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
                if (scoreList.length == 4)
                  Row(
                    children: [
                      ...scoreList.map((e) {
                        return Text(
                          FormatScore.scoreFormat(e),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontFamily: 'Akrobat',
                            fontWeight: FontWeight.w600,
                          ),
                        ).marginOnly(right: 10.w);
                      }).toList(),
                      if (getExtraTime(widget.match) != "")
                        Text(
                          "${LocaleKeys.match_info_add.tr}(${FormatScore.scoreFormat(getExtraTime(widget.match))})",
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
            ),
        ],
      );
    }
    return Container();
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
    }
  }

  ///@description 篮球比分集合
  ///@return {Array} 篮球比分
  List<String> basketballScoreArray(MatchEntity match) {
    List<String> scoreArr = [];
    List<String> msc = match.msc ?? [];

    // sortBy方法  比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      int aStage = int.parse(a.split("|")[0].substring(1));
      int bStage = int.parse(b.split("|")[0].substring(1));
      return aStage.compareTo(bStage);
    });

    List<String> mscArray =
        match.mlet == '17' || match.mle == 17 ? mscArray1 : mscArrayBasketball;

    // 循环只取出接口返回的比分里面符合篮球球阶段的比分
    for (String item in msc) {
      String numIndex = item.split("|")[0];
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    }

    return scoreArr;
  }

  ///@description 公共加时赛比分
  ///@return {String} 加时赛比分
  String getExtraTime(MatchEntity match) {
    String extra = "";
    List<String> msc = match.msc ?? [];

    for (String item in msc) {
      List<String> splitItem = item.split("|");
      if (splitItem.length >= 2 && splitItem[0] == "S7") {
        extra = splitItem[1];
        break;
      }
    }

    return extra;
  }
}

// 上半场，下半场
List<String> modelA = ['1', '2', '31'];

// 常规4节比赛
List<String> modelB = ['13', '14', '15', '16', '301', '302', '303'];

// 加时赛比赛
List<String> modelC = ['32', '40', '110', '999'];

// 常规4节比赛的比分
List<String> mscArrayBasketball = ['S19', 'S20', 'S21', 'S22'];

// 上下半场
List<String> mscArray1 = ['S2', 'S3'];
