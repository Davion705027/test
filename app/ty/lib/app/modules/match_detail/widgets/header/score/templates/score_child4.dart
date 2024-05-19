import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/routes/app_pages.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../../utils/format_score_util.dart';

/// 冰球比分模板
class ScoreChild4 extends StatelessWidget {
  ScoreChild4({super.key, required this.match});

  final MatchEntity match;
  // 赛果详情不显示    // matchResultsDetails
  // 详情显示
  bool showLabel = ![Routes.matchResultsDetails].contains(Get.currentRoute);

  @override
  Widget build(BuildContext context) {
      // 加时赛
      // mmp 32 等待加时  40 加时赛  110加时赛结束
      // msc S7表示公共加时赛比分

      List<String> scoreList = getScoreArray(match);
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //  常规三节赛事 
          // mmp （13 第一节）（14 301 第二节）（15 302 第三节）（16 303 第四节）
          if (mmpArr.contains(match.mmp) && showLabel)
            ...scoreList.map((e) {
              int index = scoreList.indexOf(e) + 1;
              return Text(
                FormatScore.scoreFormat(e),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: index == scoreList.length && match.mo != 1
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

          // 加时赛||点球大战 
          if (mmpArr1.contains(match.mmp)||mmpArr2.contains(match.mmp))
            // 区分model_a or model_b
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                      if (getExtraTime(match) != "")
                        Text(
                          "${LocaleKeys.match_info_add.tr}${FormatScore.scoreFormat(getExtraTime(match))}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Get.theme.scoreDetailColor,
                            fontSize: 12.sp,
                            fontFamily: 'Akrobat',
                            fontWeight: FontWeight.w700,
                          ),
                        ).marginOnly(right: 10.w),
                      if (getPenaltyScore(match) != "")
                        Text(
                          "${LocaleKeys.match_info_add.tr}${FormatScore.scoreFormat(getPenaltyScore(match))}",
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

  ///@description 冰球比分集合
  ///@return {Array} 冰球比分
  List<String> getScoreArray(MatchEntity match) {
    List<String> scoreArr = [];
    List<String> msc = match.msc ?? [];

    // sortBy方法  比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      int aStage = int.parse(a.split("|")[0].substring(1));
      int bStage = int.parse(b.split("|")[0].substring(1));
      return aStage.compareTo(bStage);
    });

    // 循环只取出接口返回的比分里面符合冰球球阶段的比分
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
  ///@description 获取点球大战的比分
  ///@return {String} 获取点球大战的比分
  String getPenaltyScore(MatchEntity match) {
    String extra = "";
    List<String> msc = match.msc ?? [];

    for (String item in msc) {
      List<String> splitItem = item.split("|");
      if (splitItem.length >= 2 && splitItem[0] == "S170") {
        extra = splitItem[1];
        break;
      }
    }

    return extra;
  }
}


// 冰球比分: 第一节比分, 第二节比分, 第三节比分
List<String> mscArray = ['S120','S121','S122'];

 // mmp 冰球赛事阶段: 1第一节 2第二节 3第三节 301第一节休息, 302第二节休息
List<String> mmpArr = ['1','2','3','301','302','999'];

// 加时赛阶段
List<String> mmpArr1 = ["32","40","110",'999'];

// 点球阶段
List<String> mmpArr2 = ["34","50","120",'999'];





