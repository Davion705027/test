import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child10.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child11.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child13.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child14.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child15.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child16.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child3.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child4.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child5.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child6.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child7.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child8.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child9.dart';

import '../../../../../services/models/res/match_entity.dart';
import 'templates/score_child1.dart';
import 'templates/score_child2.dart';

/// 赛事比分详情组件[底部比分条]
/// ms,赛事状态：0未开赛，1进行中，2暂停，3结束，4关闭; (mcg栏目类型：| mcg =1 滚球 | mcg=2 即将开赛| mcg=3 今日赛事| mcg=4 早盘)
/// 根据球类id: csid显示相应的比分详情
class MatchDetailScore extends StatelessWidget {
  const MatchDetailScore({super.key, required this.match});

  final MatchEntity match;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      alignment: Alignment.centerLeft,
      child: _buildScoreDetailTemplate(match),
    );
  }

  /// 根据csid显示赛事比分详情模板 【csid 100和101不显示】
  Widget _buildScoreDetailTemplate(MatchEntity match) {
    String csid = match.csid;
    switch (csid) {
      // 足球
      case "1":
        return ScoreChild1(
          match: match,
        );
      // 篮球
      case "2":
        return ScoreChild2(
          match: match,
        );
      // 棒球
      case "3":
        return ScoreChild3(
          match: match,
        );
      // 冰球
      case "4":
        return ScoreChild4(
          match: match,
        );
      // 网球
      case "5":
        return ScoreChild5(
          match: match,
        );
      // 美式足球
      case "6":
        return ScoreChild6(
          match: match,
        );
      // 斯诺克
      case "7":
        return ScoreChild7(
          match: match,
        );
      // 乒乓球
      case "8":
        return ScoreChild8(
          match: match,
        );
      // 网球球
      case "9":
        return ScoreChild9(
          match: match,
        );
      // 羽毛球
      case "10":
        return ScoreChild10(
          match: match,
        );
      // 手
      case "11":
        return ScoreChild11(
          match: match,
        );
      // 沙滩排球
      case "13":
        return ScoreChild13(
          match: match,
        );
      // 橄榄球
      case "14":
        return ScoreChild14(
          match: match,
        );
      // 曲棍球
      case "15":
        return ScoreChild15(
          match: match,
        );
      // 水球
      case "16":
        return ScoreChild16(
          match: match,
        );
      default:
        return Container();
    }
  }
}
