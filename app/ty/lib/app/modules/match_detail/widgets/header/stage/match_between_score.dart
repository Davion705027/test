import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:get/get.dart';

import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/csid_util.dart';
import '../../../../../widgets/sport_icon.dart';

/// 详情页显示赛事当前局比分以及显示发球方
class MatchBetweenScore extends StatefulWidget {
  const MatchBetweenScore({super.key, required this.match});

  final MatchEntity match;

  @override
  State<MatchBetweenScore> createState() => _MatchBetweenScoreState();
}

class _MatchBetweenScoreState extends State<MatchBetweenScore> {
  List<String> mmpArr = [
    "301",
    "302",
    "303",
    "304",
    "305",
    "306",
    "445"
  ]; // mmp rule array; // 斯诺克, 乒乓球, 羽毛球
  // 冰球三节显示局间比分的阶段
  List<String> mmpArr1 = ["1", "2", "3", "301", "302"];

  @override
  void initState() {
    // 检查mmp是否是局间休息，如果是则不显示发球方
    examineMmp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    num csid = widget.match.csid.toNum() ?? 0;
    int position = SpriteImagesPosition.data[csid] ?? 0;
    String score = "";
    // 网球取S103
    if (csid == 5 && currentScore("S103") != "") {
      score = formatScore(currentScore("S103"));
    }
    // 斯诺克, 乒乓球, 羽毛球, 排球, 沙滩排球 取赛事阶段范围内的最大为当前比分
    else if ([7, 8, 9, 10, 13].contains(csid)) {
      score = formatScore(currentScore(currentScoreCommon()));
    }
    // 冰球三节-局比分
    else if (csid == 4 && mmpArr1.contains(widget.match.mmp)) {
      score = formatScore(currentScore(currentScoreCommon()));
    }
    // 冰球+橄榄球+曲棍球 加时赛比分
    else if (['4', '14', '15'].contains(csid) &&
        ['40', '440', '41', '33', '42'].contains(widget.match.mmp) &&
        currentScore('S7') != "") {
      score = formatScore(currentScore("S7"));
    }
    // 冰球+橄榄球+曲棍球+水球 点球大战比分
    else if (['4', '14', '15', '16'].contains(csid) &&
        (widget.match.mmp == "34" || widget.match.mmp == "50") &&
        currentScore('S170') != "") {
      score = formatScore(currentScore("S170"));
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.match.mat == "home"
              ? sportIcon(
                  index: position, width: 14.w, height: 14.w, isSelected: true)
              : Container(
                  width: 14.w,
                ),
          SizedBox(
            width: 4.w,
          ),
          AutoSizeText(
            score != "" ? "($score)" : "   ",
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          widget.match.mat == "away"
              ? sportIcon(
                  index: position, width: 14.w, height: 14.w, isSelected: true)
              : Container(
                  width: 14.w,
                ),
        ],
      ),
    );
  }

  String currentScore(String str) {
    String content = "";
    for (var v in widget.match.msc) {
      List<String> splitV = v.split("|");
      if (splitV.length == 2 && splitV[0] == str) {
        content = splitV[1];
        break;
      }
    }
    return content;
  }

  /// 比分格式设置
  String formatScore(String res) {
    String str = "";
    if (res.contains("|")) {
      List<String> arr = res.split("|");
      str = arr[1];
    } else if (res.contains(":")) {
      str = res;
    }

    List<String> scoreParts = str.split(":");
    if (scoreParts.length == 2) {
      return '${scoreParts[0]} - ${scoreParts[1]}';
    } else {
      return '';
    }
  }

  examineMmp() {
    // 将休息状态的发球方置空显示，不显示绿色小点;
    if (mmpArr.contains(widget.match.mmp)) {
      widget.match.mat = "";
    }
  }

  String currentScoreCommon() {
    int num = 0;
    widget.match.msc.forEach((v) {
      int current = int.parse(v.split("|")[0].substring(1));
      if (current > num && current >= 120 && current <= 159) {
        num = current;
      }
    });

    if (num != 0 && num != 1) {
      return "S$num";
    } else {
      return "";
    }
  }
}
