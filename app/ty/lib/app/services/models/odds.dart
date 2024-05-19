import 'package:common_utils/common_utils.dart';

import '../../../generated/json/base/json_field.dart';


class Odds {
  /// id
  String? id;

  /// match_id
  @JSONField(name: 'match_id')
  String? matchId;

  /// market_id
  @JSONField(name: 'market_id')
  String? marketId;

  /// name
  String? name;

  /// en_name
  @JSONField(name: 'en_name')
  String? enName;

  /// odd
  String? odd;

  /// org_odd
  @JSONField(name: 'org_odd')
  String? orgOdd;

  /// org_odd_live
  @JSONField(name: 'org_odd_live')
  String? orgOddLive;

  @JSONField(name: 'PreOdd')
  String? preOdd;

  @JSONField(name: 'return_rate')
  dynamic returnRate;

  /// round
  num? round;

  /// is_winner
  @JSONField(name: 'is_winner')
  num? isWinner;

  /// sort_id
  @JSONField(name: 'sort_id')
  num? sortId;

  int? status;

  /// visible
  num? visible;

  /// suspended
  num? suspended;

  /// team_id
  @JSONField(name: 'team_id')
  String? teamId;

  /// linked_id
  @JSONField(name: 'linked_id')
  String? linkedId;

  @JSONField(name: 'GroupOddString')
  String? groupOddString;

  @JSONField(name: 'odd_group')
  Map<String, dynamic>? oddGroup;

  @JSONField(name: 'od_bet_param')
  String? odBetParam;

  int? detailType;

  @JSONField(name: 'market_name')
  String marketName = "";

  int? tagCode;
  int? isPassOff;

  /// Constructor...
  Odds();

  /// 赔率合并
  Odds merge(Odds odds) {
    odd = odds.odd;
    preOdd = odds.preOdd;
    returnRate = odds.returnRate;
    visible = odds.visible;
    oddGroup = odds.oddGroup;
    sortId = odds.sortId;
    return this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Odds &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          matchId == other.matchId &&
          marketId == other.marketId;

  @override
  int get hashCode => id.hashCode ^ matchId.hashCode ^ marketId.hashCode;

  String get titleName {
    return name
            ?.replaceAll('&nbsp;', ' ')
            .replaceAll('&lt;', '<')
            .replaceAll('&gt;', '>') ??
        '';
  }
}
