import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

class MatchGroup {
  final String tn; // 联赛名称
  final String tid; // 联赛id
  List<MatchEntity> matches;

  /// 大分组数据
  bool isSectionHeader;
  SectionGroupEnum sectionGroupEnum;

  bool isSportHeader;
  final String csid; // 球类id
  final String sportTitle;
  int sportCount;

  MatchEntity? _matchEntity;

  String get expandKey =>
      '$tid-${matches.map((e) => e.mid).toList().join('-')}';

  MatchEntity getBetTitleMatchEntity() {
    if (_matchEntity == null) {
      _matchEntity = matches.safeFirst;
      matches.forEach((element) {
        if (element.hps.isNotEmpty) {
          _matchEntity = element;
        }
      });
    }

    return _matchEntity ?? MatchEntity();
  }

  MatchGroup({
    required this.tn,
    required this.tid,
    required this.matches,
    required this.isSectionHeader,
    required this.sectionGroupEnum,
    required this.isSportHeader,
    required this.sportTitle,
    required this.sportCount,
    required this.csid,
  });
}
