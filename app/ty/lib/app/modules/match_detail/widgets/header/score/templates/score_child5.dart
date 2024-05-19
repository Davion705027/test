import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../../utils/format_score_util.dart';

/// 网球比分模板
class ScoreChild5 extends StatelessWidget {
  const ScoreChild5({super.key, required this.match});

  final MatchEntity match;

  @override
  Widget build(BuildContext context) {
      // mmp 32 等待加时  40 加时赛  110加时赛结束
      // msc S7表示公共加时赛比分

      List<String> scoreList = basketballScoreArray(match);
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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

       
        ],
      );

  }

  ///@description 网球比分集合
  ///@return {Array} 网球比分
  List<String> basketballScoreArray(MatchEntity match) {
    List<String> scoreArr = [];
    List<String> msc = match.msc ?? [];

    // sortBy方法  比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      int aStage = int.parse(a.split("|")[0].substring(1));
      int bStage = int.parse(b.split("|")[0].substring(1));
      return aStage.compareTo(bStage);
    });


    // 循环只取出接口返回的比分里面符合网球球阶段的比分
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

List<String> mscArray = ['S23','S39','S55','S71','S87'];
