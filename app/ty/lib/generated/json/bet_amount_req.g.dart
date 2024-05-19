import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/req/bet_amount_req.dart';

BetAmountReq $BetAmountReqFromJson(Map<String, dynamic> json) {
  final BetAmountReq betAmountReq = BetAmountReq();
  final List<
      BetAmountReqOrderMaxBetMoney>? orderMaxBetMoney = (json['orderMaxBetMoney'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<BetAmountReqOrderMaxBetMoney>(
          e) as BetAmountReqOrderMaxBetMoney).toList();
  if (orderMaxBetMoney != null) {
    betAmountReq.orderMaxBetMoney = orderMaxBetMoney;
  }
  return betAmountReq;
}

Map<String, dynamic> $BetAmountReqToJson(BetAmountReq entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderMaxBetMoney'] =
      entity.orderMaxBetMoney.map((v) => v.toJson()).toList();
  return data;
}

extension BetAmountReqExtension on BetAmountReq {
  BetAmountReq copyWith({
    List<BetAmountReqOrderMaxBetMoney>? orderMaxBetMoney,
  }) {
    return BetAmountReq()
      ..orderMaxBetMoney = orderMaxBetMoney ?? this.orderMaxBetMoney;
  }
}

BetAmountReqOrderMaxBetMoney $BetAmountReqOrderMaxBetMoneyFromJson(
    Map<String, dynamic> json) {
  final BetAmountReqOrderMaxBetMoney betAmountReqOrderMaxBetMoney = BetAmountReqOrderMaxBetMoney();
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    betAmountReqOrderMaxBetMoney.sportId = sportId;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    betAmountReqOrderMaxBetMoney.marketId = marketId;
  }
  final int? deviceType = jsonConvert.convert<int>(json['deviceType']);
  if (deviceType != null) {
    betAmountReqOrderMaxBetMoney.deviceType = deviceType;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    betAmountReqOrderMaxBetMoney.matchId = matchId;
  }
  final String? oddsFinally = jsonConvert.convert<String>(json['oddsFinally']);
  if (oddsFinally != null) {
    betAmountReqOrderMaxBetMoney.oddsFinally = oddsFinally;
  }
  final String? oddsValue = jsonConvert.convert<String>(json['oddsValue']);
  if (oddsValue != null) {
    betAmountReqOrderMaxBetMoney.oddsValue = oddsValue;
  }
  final String? playId = jsonConvert.convert<String>(json['playId']);
  if (playId != null) {
    betAmountReqOrderMaxBetMoney.playId = playId;
  }
  final String? playOptionId = jsonConvert.convert<String>(
      json['playOptionId']);
  if (playOptionId != null) {
    betAmountReqOrderMaxBetMoney.playOptionId = playOptionId;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    betAmountReqOrderMaxBetMoney.playOptions = playOptions;
  }
  final int? seriesType = jsonConvert.convert<int>(json['seriesType']);
  if (seriesType != null) {
    betAmountReqOrderMaxBetMoney.seriesType = seriesType;
  }
  final String? matchProcessId = jsonConvert.convert<String>(
      json['matchProcessId']);
  if (matchProcessId != null) {
    betAmountReqOrderMaxBetMoney.matchProcessId = matchProcessId;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    betAmountReqOrderMaxBetMoney.scoreBenchmark = scoreBenchmark;
  }
  final int? tenantId = jsonConvert.convert<int>(json['tenantId']);
  if (tenantId != null) {
    betAmountReqOrderMaxBetMoney.tenantId = tenantId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    betAmountReqOrderMaxBetMoney.tournamentLevel = tournamentLevel;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    betAmountReqOrderMaxBetMoney.tournamentId = tournamentId;
  }
  final String? dataSource = jsonConvert.convert<String>(json['dataSource']);
  if (dataSource != null) {
    betAmountReqOrderMaxBetMoney.dataSource = dataSource;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    betAmountReqOrderMaxBetMoney.matchType = matchType;
  }
  final int? openMiltSingle = jsonConvert.convert<int>(json['openMiltSingle']);
  if (openMiltSingle != null) {
    betAmountReqOrderMaxBetMoney.openMiltSingle = openMiltSingle;
  }
  return betAmountReqOrderMaxBetMoney;
}

Map<String, dynamic> $BetAmountReqOrderMaxBetMoneyToJson(
    BetAmountReqOrderMaxBetMoney entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['sportId'] = entity.sportId;
  data['marketId'] = entity.marketId;
  data['deviceType'] = entity.deviceType;
  data['matchId'] = entity.matchId;
  data['oddsFinally'] = entity.oddsFinally;
  data['oddsValue'] = entity.oddsValue;
  data['playId'] = entity.playId;
  data['playOptionId'] = entity.playOptionId;
  data['playOptions'] = entity.playOptions;
  data['seriesType'] = entity.seriesType;
  data['matchProcessId'] = entity.matchProcessId;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['tenantId'] = entity.tenantId;
  data['tournamentLevel'] = entity.tournamentLevel;
  data['tournamentId'] = entity.tournamentId;
  data['dataSource'] = entity.dataSource;
  data['matchType'] = entity.matchType;
  data['openMiltSingle'] = entity.openMiltSingle;
  return data;
}

extension BetAmountReqOrderMaxBetMoneyExtension on BetAmountReqOrderMaxBetMoney {
  BetAmountReqOrderMaxBetMoney copyWith({
    String? sportId,
    String? marketId,
    int? deviceType,
    String? matchId,
    String? oddsFinally,
    String? oddsValue,
    String? playId,
    String? playOptionId,
    String? playOptions,
    int? seriesType,
    String? matchProcessId,
    String? scoreBenchmark,
    int? tenantId,
    int? tournamentLevel,
    String? tournamentId,
    String? dataSource,
    int? matchType,
    int? openMiltSingle,
  }) {
    return BetAmountReqOrderMaxBetMoney()
      ..sportId = sportId ?? this.sportId
      ..marketId = marketId ?? this.marketId
      ..deviceType = deviceType ?? this.deviceType
      ..matchId = matchId ?? this.matchId
      ..oddsFinally = oddsFinally ?? this.oddsFinally
      ..oddsValue = oddsValue ?? this.oddsValue
      ..playId = playId ?? this.playId
      ..playOptionId = playOptionId ?? this.playOptionId
      ..playOptions = playOptions ?? this.playOptions
      ..seriesType = seriesType ?? this.seriesType
      ..matchProcessId = matchProcessId ?? this.matchProcessId
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..tenantId = tenantId ?? this.tenantId
      ..tournamentLevel = tournamentLevel ?? this.tournamentLevel
      ..tournamentId = tournamentId ?? this.tournamentId
      ..dataSource = dataSource ?? this.dataSource
      ..matchType = matchType ?? this.matchType
      ..openMiltSingle = openMiltSingle ?? this.openMiltSingle;
  }
}