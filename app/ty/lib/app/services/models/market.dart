import '../../../generated/json/base/json_field.dart';
import 'odds.dart';


class Market {
  @JSONField(name: 'cn_name')
  String? cnName;
  @JSONField(name: 'comp_sub_num')
  int? compSubNum;
  @JSONField(name: 'detail_type')
  int? detailType;
  @JSONField(name: 'en_name')
  String? enName;
  String? id;
  @JSONField(name: 'is_default')
  int? isDefault;
  @JSONField(name: 'is_pass_off')
  int? isPassOff;
  @JSONField(name: 'lock_return_rate')
  int? lockReturnRate;

  /// 盘口值
  @JSONField(name: 'market_value')
  String? marketValue;
  @JSONField(name: 'match_id')
  String? matchId;
  @JSONField(name: 'mb_mkt_prize_limit')
  num? mbMktPrizeLimit;
  @JSONField(name: 'mch_comp_prize_limit')
  num? mchCompPrizeLimit;
  String? name;
  @JSONField(name: 'norm_return_rate')
  num? normReturnRate;
  @JSONField(name: 'odd_linkage')
  int? oddLinkage;
  @JSONField(name: 'odd_type_id')
  String? oddTypeId;
  Map<String, Odds?>? odds;
  @JSONField(name: 'option_type')
  int? optionType;
  @JSONField(name: 'prize_limit')
  num? prizeLimit;
  @JSONField(name: 'prize_static_profit')
  num? prizeStaticProfit;
  String? remark;
  int? round;
  @JSONField(name: 'score_benchmark')
  String? scoreBenchmark;
  @JSONField(name: 'settle_count')
  int? settleCount;
  @JSONField(name: 'sort_code')
  int? sortCode;
  int? status;
  @JSONField(name: 'stop_profit')
  int? stopProfit;
  @JSONField(name: 'sub_mkt_id')
  String? subMktId;
  @JSONField(name: 'sub_odd_id')
  String? subOddId;
  int? suspended;
  @JSONField(name: 'suspended_type')
  int? suspendedType;
  String? tag;
  @JSONField(name: 'tag_code')
  int? tagCode;
  @JSONField(name: 'ty_place_num')
  int? tyPlaceNum;
  int? visible;
  @JSONField(name: 'visible_type')
  int? visibleType;

  bool risingEnable = false; //启用 谷底趋势 冠军盘
  dynamic timerOdds;

  @JSONField(serialize: false, deserialize: false)
  bool isExpand = false;

  Market();
}
