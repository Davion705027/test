import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../../utils/format_score_util.dart';
import '../../../../../../widgets/image_view.dart';

/// 足球比分模板
class ScoreChild1 extends StatefulWidget {
  const ScoreChild1({super.key, required this.match});

  final MatchEntity match;

  @override
  State<ScoreChild1> createState() => _ScoreChild1State();
}

class _ScoreChild1State extends State<ScoreChild1> {
  /// 加时赛比分
  String overtimeScore = "";

  /// 点球大战比分
  String shootScore = "";

  // 赛果详情不显示文案[黄牌 红牌 等]   // matchResultsDetails
  // 详情显示
  bool showLabel = ![Routes.matchResultsDetails].contains(Get.currentRoute);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 上半场，全场，加时赛，点球大战
        if (getFootballScoreDetail(widget.match) != "")
          Text(
            getFootballScoreDetail(widget.match),
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ).marginOnly(right: 4.w),
        // 角球、黄牌、红牌
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageView(
              'assets/images/detail/corner_kick_red.svg',
              width: 13.h,
              height: 13.h,
            ),
            SizedBox(width: 2.w),
            Text(
              (showLabel ? LocaleKeys.match_result_corner_kick.tr : '') +
                  FormatScore.scoreFormat(
                      footballScoreStatusArray(widget.match)[0]),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(width: 4.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 9.w,
              height: 12.w,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: const Color(0xFFFEAE2B),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.r)),
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              (showLabel ? LocaleKeys.match_result_yellow_card.tr : "") +
                  FormatScore.scoreFormat(
                      footballScoreStatusArray(widget.match)[2]),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(width: 4.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 9.w,
              height: 12.w,
              decoration: ShapeDecoration(
                color: const Color(0xFFF53F3F),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.r)),
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              (showLabel ? LocaleKeys.match_result_red_card.tr : "") +
                  FormatScore.scoreFormat(
                      footballScoreStatusArray(widget.match)[1]),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 获得某个阶段某个比分 上半场，全场，加时赛，点球大战
  String getFootballScoreDetail(MatchEntity match) {
    String detail = "";
    String mmp = widget.match.mmp;
    List<String> scoreArray = footballScoreArray(widget.match);
    if (!ObjectUtil.isEmptyString(scoreArray[1]) && collectionA.contains(mmp)) {
      if (!showLabel) {
        // 赛果显示半
        detail += LocaleKeys.match_info_half.tr;
      } else {
        detail += LocaleKeys.app_h5_detail_half.tr;
      }
    }
    if (!ObjectUtil.isEmptyString(scoreArray[0]) && collectionB.contains(mmp)) {
      detail += "/${LocaleKeys.match_info_full.tr}";
    }
    if (!ObjectUtil.isEmptyString(overtimeScore) && collectionC.contains(mmp)) {
      detail += "/${LocaleKeys.match_info_add.tr}";
    }
    // 赛果显示
    if (!ObjectUtil.isEmptyString(shootScore) &&
        collectionC.contains(mmp) &&
        [Routes.matchResultsDetails].contains(Get.currentRoute)) {
      detail += "/${LocaleKeys.match_info_shoot_out.tr}";
    }
    if (!ObjectUtil.isEmptyString(scoreArray[1]) && collectionA.contains(mmp)) {
      detail += " : ${FormatScore.scoreFormat(scoreArray[1])}";
    }
    if (!ObjectUtil.isEmptyString(scoreArray[0]) && collectionB.contains(mmp)) {
      detail += " / ${FormatScore.scoreFormat(scoreArray[0])}";
    }

    if (!ObjectUtil.isEmptyString(overtimeScore) && collectionC.contains(mmp)) {
      detail += " / ${FormatScore.scoreFormat(overtimeScore)}";
    }
    // 赛果显示
    if (!ObjectUtil.isEmptyString(shootScore) &&
        collectionC.contains(mmp) &&
        [Routes.matchResultsDetails].contains(Get.currentRoute)) {
      detail += " / ${FormatScore.scoreFormat(shootScore)}";
    }

    return detail;
  }

  /// 足球比分集合
  List<String> footballScoreArray(MatchEntity match) {
    List<String> msc = List.from(widget.match.msc);

    // 按照比分阶段的数字进行升序排列
    msc.sort((a, b) {
      int numA = int.parse(a.split("|")[0].substring(1));
      int numB = int.parse(b.split("|")[0].substring(1));
      return numA.compareTo(numB);
    });

    List<String> scoreArr = [];
    // 循环只取出接口返回的比分里面符合足球阶段的比分
    msc.forEach((item) {
      String numIndex = item.split("|")[0];
      // 加时赛
      if (numIndex == 'S7') {
        overtimeScore = item.split("|")[1];
      }
      // 点球
      if (numIndex == 'S170') {
        shootScore = item.split("|")[1];
      }
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    });

    return scoreArr;
  }

  ///@description 角球 红牌 黄牌
  ///@param {Undefined}
  ///@return {Array} 角球 红牌 黄牌数
  List<String> footballScoreStatusArray(MatchEntity match) {
    List<String> msc = List.from(widget.match.msc);

    // 比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      String? numIndexA = a.split("|")[0];
      String? numIndexB = b.split("|")[0];
      int numA = numIndexA != "" ? int.parse(numIndexA.substring(1)) : 0;
      int numB = numIndexB != "" ? int.parse(numIndexB.substring(1)) : 0;
      return numA.compareTo(numB);
    });

    List<String> scoreArr = ['0:0', '0:0', '0:0'];
    // 循环取出接口返回的比分里面的角球、红牌和黄牌数
    msc.forEach((item) {
      String? numIndex = item.split("|")[0];
      String? score = item.split("|")[1];
      if (numIndex == 'S5') {
        scoreArr[0] = score;
      } else if (numIndex == 'S11') {
        scoreArr[1] = score;
      } else if (numIndex == 'S12') {
        scoreArr[2] = score;
      }
    });
    return scoreArr;
  }
}

// 1全场  2上半场  7加时赛  170点球大战
List<String> mscArray = ["S1", "S2", "S7", "S170"];

// 5角球  11红牌  12黄牌
List<String> statusArray = ["S5", "S11", "S12"];

// 满足难度需求
List<String> collectionA = [
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
  '999'
];
List<String> collectionB = [
  '41',
  '100',
  '32',
  '33',
  '42',
  '110',
  '34',
  '50',
  '120',
  '999'
];
List<String> collectionC = ['110', '34', '50', '120', '999'];
