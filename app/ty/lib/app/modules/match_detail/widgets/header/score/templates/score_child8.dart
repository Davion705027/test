import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../../utils/bus/bus.dart';
import '../../../../../../utils/bus/event_enum.dart';
import '../../../../../../utils/format_score_util.dart';

/// 乒乓球
class ScoreChild8 extends StatefulWidget {
  const ScoreChild8({super.key, required this.match});

  final MatchEntity match;

  @override
  State<ScoreChild8> createState() => _ScoreChild8State();
}

class _ScoreChild8State extends State<ScoreChild8> {
  @override
  void initState() {
    validateStage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ScoreChild8 oldWidget) {
    validateStage();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // mmp 32 等待加时  40 加时赛  110加时赛结束
    // msc S7表示公共加时赛比分

    List<String> scoreList = scoreArray(widget.match);
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
              color: index == scoreList.length && widget.match.mo != 1
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

  List<String> scoreArray(MatchEntity match) {
    List<String> scoreArr = [];
    List<String> msc = match.msc ?? [];

    // sortBy方法  比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      int aStage = int.parse(a.split("|")[0].substring(1));
      int bStage = int.parse(b.split("|")[0].substring(1));
      return aStage.compareTo(bStage);
    });

    List<String> mscArray = [];
    for (var i = 120; i <= 159; i++) {
      mscArray.add('S$i');
    }

    // 循环只取出接口返回的比分里面符合斯诺克球阶段的比分
    for (String item in msc) {
      String numIndex = item.split("|")[0];
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    }

    return scoreArr;
  }

  validateStage() {
    switch (widget.match.mmp) {
      case "301":
        Bus.getInstance().emit(EventType.nativeDetailData, 'S121|0:0');
        break;
      case "9":
        Bus.getInstance().emit(EventType.nativeDetailData, 'S121|0:0');
        break;
      case "302": //302   第二局结束
        Bus.getInstance().emit(EventType.nativeDetailData, 'S122|0:0');
        break;
      case "10": //10    第三局
        Bus.getInstance().emit(EventType.nativeDetailData, 'S122|0:0');
        break;
      case "303": //303   第三局结束
        Bus.getInstance().emit(EventType.nativeDetailData, 'S123|0:0');
        break;
      case "11": //11    第四局
        Bus.getInstance().emit(EventType.nativeDetailData, 'S123|0:0');
        break;
      case "304": //304   第四局结束
        Bus.getInstance().emit(EventType.nativeDetailData, 'S124|0:0');
        break;
      case "12": //12    第五局
        Bus.getInstance().emit(EventType.nativeDetailData, 'S124|0:0');
        break;
      case "305": //305   第五局结束
        Bus.getInstance().emit(EventType.nativeDetailData, 'S125|0:0');
        break;
      case "441": //441   第六局
        Bus.getInstance().emit(EventType.nativeDetailData, 'S125|0:0');
        break;
      case "306": //306   第六局结束
        Bus.getInstance().emit(EventType.nativeDetailData, 'S126|0:0');
        break;
      case "442": //442   第七局
        Bus.getInstance().emit(EventType.nativeDetailData, 'S126|0:0');
        break;
    }
  }
}
