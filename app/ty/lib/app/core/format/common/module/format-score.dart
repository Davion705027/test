import 'package:flutter_ty_app/app/core/format/index.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';

import '../../project/module/format-msc.dart';

extension TYFormatScore on TYFormat {

  ///@description 根据不同赛事阶段取不同的比分
  ///@param {Object} match 赛事数据对象
  ///@param {Number} num 0-主队  1-客队
  ///@param {String} key 比赛结束显示指定比分
  ///@return {ScoreModel} 主队和客队得分
  static ScoreModel formatTotalScore(MatchEntity match, {String? key}) {
    ScoreModel res = ScoreModel();
    try {
      if (match.msc.isEmpty) return res;
      List? score_;
      var mscmap = {
        for (var item in match.msc)
          item.split("|")[0]: item.split("|")[1].split(":")
      };
      if (match.csid == "1" || match.csid  == "11") {
        //足球和手球
        switch (match.mmp.toString()) {
          //  41 加时赛上半场  33 加时休息  42 加时下半场 110 加时赛结束
          case "41":
          case "33":
          case "42":
          case "110":
            score_ = mscmap['S7'];
            break;
          // 50 点球大战  120 点球大战结束
          case "50":
          case "120":
            score_ = mscmap['S170'];
            break;
          // 即将加时和等待点球的阶段固定取0
          case "32":
          case "34":
            score_ = [0];
            break;
          //全场结束,取点球大战比分，加时赛比分或者全场比分
          case "999":
            score_ = mscmap['S170'] ?? mscmap['S7'] ?? mscmap['S1'];
            if (key != null && key.contains('S')) score_ = mscmap[key];
            break;
          default:
            score_ = mscmap['S1'];
            break;
        }
      } else {
        score_ = mscmap['S1'];
      }
      if( isStrList(score_) ){
        res.text = score_![0] + ' - ' +score_[1];
        res.home = score_[0];
        res.away = score_[1];
      }
      return res;
    } catch (error) {
      print(error);
      return res;
    }
  }


  //  /** get_score_second
  //    * 获取次要玩法比分
  //    * @param {Number}index 1主队比分2客队比分
  //    * @param {String}playId 玩法id
  //    * @param {MatchEntity}match 
  //    * @param {String}hSpecial 
  //    */
  static String getScoreSecond(int index, String playId, MatchEntity match,String hSpecial) {
    String r = '0';
    String splitStr = 'S5|';

    if (playId == playIdConfig.hpsCorner) {
      splitStr = 'S5|'; // 角球 1
    } else if (playId == playIdConfig.hpsPunish) {
      splitStr = 'S10102|'; // 罚牌 5
    } else if (playId == playIdConfig.hps15Minutes) {
      // 15 分钟  2954【客户端】【WEB端】添加时段盘比分展示  17
      //S1001	0~14:59 分钟进球
      //S1002	15~29:59 分钟进球
      //S1003	30~44:59 分钟进球
      //S1004	45~59:59 分钟进球
      //S1005	60~74:59 分钟进球
      //S1006	75~89:59 分钟进球
      final Map scoreConfig = {
        '0': 'S1001|',
        '1': 'S1002|',
        '2': 'S1003|',
        '3': 'S1004|',
        '4': 'S1005|',
        '5': 'S1006|',
      };
      splitStr = scoreConfig[hSpecial] ?? 'S1001|';
    }
    List split = [];
    int csid = match.csid.toInt();
    if (csid == 5) {
      split = ['S23|', 'S39|', 'S55|', 'S71|', 'S87|'];
    } else if (csid == 7 || csid == 8) {
      split = [];
      // 比分S120到S160(不含)
      for (int min = 120; min < 160; min++) {
        split.add('S$min|');
      }
    }

    if (match.msc.isNotEmpty) {
      if ([5, 7, 8].contains(csid)) {
        List foundScoreList = [];
        for (var fScore in match.msc) {
          for (var splStr in split) {
            if (fScore.contains(splStr)) {
              List sliced = TYFormatMsc.formatMsc(fScore);
              foundScoreList.addAll(sliced);
            }
          }
        }
        if (foundScoreList.isNotEmpty) {
          r = foundScoreList.last;
        }
      } else {
        // todo msc 排序规则和js 不一致 导致比分计算错误
        for (var fScore in match.msc) {
          if (fScore.contains(splitStr)) {
            List sliced = TYFormatMsc.formatMsc(fScore);
            r = sliced[index];
          }
        }
      }
    }

    // 罚牌
    if (playId == playIdConfig.hpsPunish) {
      if (MatchUtil.isOvertimeed(match)) {
        r = '0';
      }
    }
    return r;
  }
  
}

class ScoreModel{
  // 主队分数
  String home = '0';
  // 客队分数
  String away =  '0';
  // 渲染比分 home-away
  String text = '';
}


List<String> formatMsc(String str) {
  if (str == '' || str.isEmpty) {
    return [];
  }

  List<String> list_ = str.split(RegExp(r'[:|]'));

  for (int i = 0, l = 3 - list_.length; i < l; i++) {
    list_.add('');
  }

  list_.add('msc_${list_[0]}'.tr);
  return list_;
}
