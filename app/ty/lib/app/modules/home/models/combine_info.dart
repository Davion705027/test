import 'package:flutter_ty_app/app/modules/home/models/match_group.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';

import '../../../services/models/res/match_entity.dart';

enum CombineType {
  sectionHeader, // 联赛状态的头部
  sportHeader, // 体育类型的头部
  matchWithHeader, // 有头部的比赛
  match, // 没有头部的比赛
}

class CombineInfo {
  CombineType type;

  /// 联赛状态的头部
  SectionGroupEnum? sectionGroupEnum;

  /// 体育类型的头部
  String sportTitle = '';
  /// 球种数量统计
  int sportCount = 0;
  String csid = '';

  MatchEntity? data;
  String tn = '';
  String tid = '';

  ///折叠显示数量
  int matchCount = 0;
  ///最后一场比赛
  bool isLastMatch = false;

  CombineInfo(this.type);

  static List<CombineInfo> generateFromList(List<MatchGroup> matchGroups) {
    List<CombineInfo> list = [];
    for (var element in matchGroups) {
      list.addAll(generateFrom(element));
    }
    return list;
  }

  static List<CombineInfo> generateFrom(MatchGroup matchGroup) {
    List<CombineInfo> list = [];
    if (matchGroup.isSectionHeader) {
      list.add(CombineInfo(CombineType.sectionHeader)
        ..sectionGroupEnum = matchGroup.sectionGroupEnum);
    }
    if (matchGroup.isSportHeader) {
      list.add(CombineInfo(CombineType.sportHeader)
        ..sportTitle = matchGroup.sportTitle
        ..sportCount = matchGroup.sportCount
        ..csid = matchGroup.csid);
    }
    for (int index = 0; index < matchGroup.matches.length; index++) {
      MatchEntity element = matchGroup.matches[index];
      bool isLastMatch = index == matchGroup.matches.length - 1;
      if (index == 0) {
        list.add(CombineInfo(CombineType.matchWithHeader)
          ..data = element
          ..tn = matchGroup.tn
          ..matchCount = matchGroup.matches.length
          ..isLastMatch = isLastMatch
          ..sectionGroupEnum = matchGroup.sectionGroupEnum // 状态折叠
          ..tid = matchGroup.tid); // 联赛折叠
      } else {
        list.add(CombineInfo(CombineType.match)
          ..data = element
          ..tn = matchGroup.tn
          ..sectionGroupEnum = matchGroup.sectionGroupEnum
          ..isLastMatch = isLastMatch // 最后一个项
          ..tid = matchGroup.tid);
      }
    }
    return list;
  }
}
