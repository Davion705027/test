import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../../utils/format_score_util.dart';

/// 沙滩排球赛事的细节比分展示
class ScoreChild13 extends StatelessWidget {
  const ScoreChild13({super.key, required this.match});

  final MatchEntity match;

  @override
  Widget build(BuildContext context) {
      // mmp 32 等待加时  40 加时赛  110加时赛结束
      // msc S7表示公共加时赛比分

      List<String> scoreList = getScoreArray(match);
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(match.ms != 0)
            // mmp 
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
                  fontWeight: FontWeight.w600,
                ),
              ).marginOnly(right: 10.w);
            }).toList(),
            // 总分
            Text(
                "${LocaleKeys.analysis_football_matches_total_all.tr}:${FormatScore.scoreFormat(countTotal(scoreList))}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xFFFEBE55),
                  fontSize: 12.sp,
                  fontFamily: 'Akrobat',
                  fontWeight: FontWeight.w600,
                ),
              )
        ],
      );

  }

  ///@description 网球比分集合
  ///@return {Array} 网球比分
  List<String> getScoreArray(MatchEntity match) {
    List<String> scoreArr = [];
    List<String> msc = match.msc ?? [];

    // sortBy方法  比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      int aStage = int.parse(a.split("|")[0].substring(1));
      int bStage = int.parse(b.split("|")[0].substring(1));
      return aStage.compareTo(bStage);
    });

    List<String> mscArray = [];
    for(var i = 120; i<= 159; i ++){
        mscArray.add('S$i');
      }

    // 循环只取出接口返回的比分里面符合网球球阶段的比分
    for (String item in msc) {
      String numIndex = item.split("|")[0];
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    }

    return scoreArr;
  }

  //   /**
  //  *@description: 计算总分
  //  *@param {Array} 各阶段组数比分
  //  *@return {String} 总比分
  //  */
  String countTotal(List<String> arr) {
    int totalLeft = 0, totalRight = 0;
    for (var item in arr) {
      totalLeft += int.parse(item.split(":")[0]);
      totalRight += int.parse(item.split(":")[1]);
    }
    return '$totalLeft:$totalRight';
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


