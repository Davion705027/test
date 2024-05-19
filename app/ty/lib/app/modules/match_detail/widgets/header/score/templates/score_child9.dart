import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

import '../../../../../../utils/bus/bus.dart';
import '../../../../../../utils/bus/event_enum.dart';
import '../../../../../../utils/format_score_util.dart';

/// 排球
class ScoreChild9 extends StatefulWidget {
  const ScoreChild9({super.key, required this.match});

  final MatchEntity match;

  @override
  State<ScoreChild9> createState() => _ScoreChild9State();
}

class _ScoreChild9State extends State<ScoreChild9> {
  @override
  void initState() {
    validateStage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ScoreChild9 oldWidget) {
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
        ...scoreList.map((e) {
          int index = scoreList.indexOf(e) + 1;
          return Text(
            FormatScore.scoreFormat(e),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: (index == scoreList.length && widget.match.mo != 1)
                  ? Get.theme.scoreDetailColor
                  : Colors.white,
              fontSize: 12.sp,
              fontFamily: 'Akrobat',
              fontWeight:
                  index == scoreList.length ? FontWeight.w700 : FontWeight.w600,
            ),
          ).marginOnly(right: 10.w);
        }).toList(),
      ],
    );
  }

  /// 取出符合排球阶段的比分
  List<String> scoreArray(MatchEntity match) {
    List<String> mscArray = [];
    for (int i = 120; i <= 159; i++) {
      mscArray.add('S$i');
    }
    List<String> msc = match.msc;
    // sortBy方法 比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      int aNum = int.parse(a.split('|')[0].substring(1));
      int bNum = int.parse(b.split('|')[0].substring(1));
      return aNum.compareTo(bNum);
    });
    List<String> scoreArr = [];
    // 循环只取出接口返回的比分里面符合排球阶段的比分
    for (String item in msc) {
      // S120 S121 S123 S124 S125 ...
      String numIndex = item.split('|')[0];
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split('|')[1]);
      }
    }
    return scoreArr;
  }

  validateStage() {
    switch (widget.match.mmp) {
      case '301': //301   第一局结束 S121显示第二局比分0:0
        Bus.getInstance().emit(EventType.nativeDetailData, 'S121|0:0');
        break;
      case '9': //9     第二局开始

        Bus.getInstance().emit(EventType.nativeDetailData, 'S121|0:0');
        break;
      case '302': //302   第二局结束 S122显示第三局比分0:0
        Bus.getInstance().emit(EventType.nativeDetailData, 'S122|0:0');
        break;
      case '10': //10    第三局开始
        Bus.getInstance().emit(EventType.nativeDetailData, 'S122|0:0');
        break;
      case '303': //303   第三局结束 S123显示第四局比分0:0
        Bus.getInstance().emit(EventType.nativeDetailData, 'S123|0:0');
        break;
      case '11': //11    第四局开始
        Bus.getInstance().emit(EventType.nativeDetailData, 'S123|0:0');
        break;
      case '304': //304   第四局结束 S124显示第五局比分0:0
        Bus.getInstance().emit(EventType.nativeDetailData, 'S124|0:0');
        break;
      case '12': //12    第五局开始
        Bus.getInstance().emit(EventType.nativeDetailData, 'S124|0:0');
        break;
      case '305': //305   第五局结束 S125显示第六局比分0:0
        Bus.getInstance().emit(EventType.nativeDetailData, 'S125|0:0');
        break;
      case '441': //441   第六局开始
        Bus.getInstance().emit(EventType.nativeDetailData, 'S125|0:0');
        break;
      case '306': //306   第六局结束 S126显示第七局比分0:0
        Bus.getInstance().emit(EventType.nativeDetailData, 'S126|0:0');
        break;
      case '442': //442   第七局开始
        Bus.getInstance().emit(EventType.nativeDetailData, 'S126|0:0');
        break;
    }
  }
}

// mmp rule array; // 排球休息阶段 第一局结束...
List<String> mmpArr = ['301', '302', '303', '304', '305', '306'];

// mmp rule array; // 排球比赛进行阶段 第一局...
List<String> mmpArr2 = ['8', '9', '10', '11', '12', '441', '442'];
