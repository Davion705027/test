import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/req/bet_req.dart';

BetReq $BetReqFromJson(Map<String, dynamic> json) {
  final BetReq betReq = BetReq();
  final int? acceptOdds = jsonConvert.convert<int>(json['acceptOdds']);
  if (acceptOdds != null) {
    betReq.acceptOdds = acceptOdds;
  }
  final int? tenantId = jsonConvert.convert<int>(json['tenantId']);
  if (tenantId != null) {
    betReq.tenantId = tenantId;
  }
  final int? deviceType = jsonConvert.convert<int>(json['deviceType']);
  if (deviceType != null) {
    betReq.deviceType = deviceType;
  }
  final String? currencyCode = jsonConvert.convert<String>(
      json['currencyCode']);
  if (currencyCode != null) {
    betReq.currencyCode = currencyCode;
  }
  final String? deviceImei = jsonConvert.convert<String>(json['deviceImei']);
  if (deviceImei != null) {
    betReq.deviceImei = deviceImei;
  }
  final String? fpId = jsonConvert.convert<String>(json['fpId']);
  if (fpId != null) {
    betReq.fpId = fpId;
  }
  final int? openMiltSingle = jsonConvert.convert<int>(json['openMiltSingle']);
  if (openMiltSingle != null) {
    betReq.openMiltSingle = openMiltSingle;
  }
  final int? preBet = jsonConvert.convert<int>(json['preBet']);
  if (preBet != null) {
    betReq.preBet = preBet;
  }
  final List<BetReqSeriesOrders>? seriesOrders = (json['seriesOrders'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<BetReqSeriesOrders>(e) as BetReqSeriesOrders)
      .toList();
  if (seriesOrders != null) {
    betReq.seriesOrders = seriesOrders;
  }
  return betReq;
}

Map<String, dynamic> $BetReqToJson(BetReq entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['acceptOdds'] = entity.acceptOdds;
  data['tenantId'] = entity.tenantId;
  data['deviceType'] = entity.deviceType;
  data['currencyCode'] = entity.currencyCode;
  data['deviceImei'] = entity.deviceImei;
  data['fpId'] = entity.fpId;
  data['openMiltSingle'] = entity.openMiltSingle;
  data['preBet'] = entity.preBet;
  data['seriesOrders'] = entity.seriesOrders.map((v) => v.toJson()).toList();
  return data;
}

extension BetReqExtension on BetReq {
  BetReq copyWith({
    int? acceptOdds,
    int? tenantId,
    int? deviceType,
    String? currencyCode,
    String? deviceImei,
    String? fpId,
    int? openMiltSingle,
    int? preBet,
    List<BetReqSeriesOrders>? seriesOrders,
  }) {
    return BetReq()
      ..acceptOdds = acceptOdds ?? this.acceptOdds
      ..tenantId = tenantId ?? this.tenantId
      ..deviceType = deviceType ?? this.deviceType
      ..currencyCode = currencyCode ?? this.currencyCode
      ..deviceImei = deviceImei ?? this.deviceImei
      ..fpId = fpId ?? this.fpId
      ..openMiltSingle = openMiltSingle ?? this.openMiltSingle
      ..preBet = preBet ?? this.preBet
      ..seriesOrders = seriesOrders ?? this.seriesOrders;
  }
}

BetReqSeriesOrders $BetReqSeriesOrdersFromJson(Map<String, dynamic> json) {
  final BetReqSeriesOrders betReqSeriesOrders = BetReqSeriesOrders();
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    betReqSeriesOrders.seriesSum = seriesSum;
  }
  final int? seriesType = jsonConvert.convert<int>(json['seriesType']);
  if (seriesType != null) {
    betReqSeriesOrders.seriesType = seriesType;
  }
  final String? seriesValues = jsonConvert.convert<String>(
      json['seriesValues']);
  if (seriesValues != null) {
    betReqSeriesOrders.seriesValues = seriesValues;
  }
  final int? fullBet = jsonConvert.convert<int>(json['fullBet']);
  if (fullBet != null) {
    betReqSeriesOrders.fullBet = fullBet;
  }
  final List<
      BetReqSeriesOrdersOrderDetailList>? orderDetailList = (json['orderDetailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<BetReqSeriesOrdersOrderDetailList>(
          e) as BetReqSeriesOrdersOrderDetailList).toList();
  if (orderDetailList != null) {
    betReqSeriesOrders.orderDetailList = orderDetailList;
  }
  return betReqSeriesOrders;
}

Map<String, dynamic> $BetReqSeriesOrdersToJson(BetReqSeriesOrders entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['seriesSum'] = entity.seriesSum;
  data['seriesType'] = entity.seriesType;
  data['seriesValues'] = entity.seriesValues;
  data['fullBet'] = entity.fullBet;
  data['orderDetailList'] =
      entity.orderDetailList.map((v) => v.toJson()).toList();
  return data;
}

extension BetReqSeriesOrdersExtension on BetReqSeriesOrders {
  BetReqSeriesOrders copyWith({
    int? seriesSum,
    int? seriesType,
    String? seriesValues,
    int? fullBet,
    List<BetReqSeriesOrdersOrderDetailList>? orderDetailList,
  }) {
    return BetReqSeriesOrders()
      ..seriesSum = seriesSum ?? this.seriesSum
      ..seriesType = seriesType ?? this.seriesType
      ..seriesValues = seriesValues ?? this.seriesValues
      ..fullBet = fullBet ?? this.fullBet
      ..orderDetailList = orderDetailList ?? this.orderDetailList;
  }
}

BetReqSeriesOrdersOrderDetailList $BetReqSeriesOrdersOrderDetailListFromJson(
    Map<String, dynamic> json) {
  final BetReqSeriesOrdersOrderDetailList betReqSeriesOrdersOrderDetailList = BetReqSeriesOrdersOrderDetailList();
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    betReqSeriesOrdersOrderDetailList.sportId = sportId;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    betReqSeriesOrdersOrderDetailList.matchId = matchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    betReqSeriesOrdersOrderDetailList.tournamentId = tournamentId;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    betReqSeriesOrdersOrderDetailList.scoreBenchmark = scoreBenchmark;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    betReqSeriesOrdersOrderDetailList.betAmount = betAmount;
  }
  final String? placeNum = jsonConvert.convert<String>(json['placeNum']);
  if (placeNum != null) {
    betReqSeriesOrdersOrderDetailList.placeNum = placeNum;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    betReqSeriesOrdersOrderDetailList.marketId = marketId;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    betReqSeriesOrdersOrderDetailList.playOptionsId = playOptionsId;
  }
  final String? marketTypeFinally = jsonConvert.convert<String>(
      json['marketTypeFinally']);
  if (marketTypeFinally != null) {
    betReqSeriesOrdersOrderDetailList.marketTypeFinally = marketTypeFinally;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    betReqSeriesOrdersOrderDetailList.marketValue = marketValue;
  }
  final int? odds = jsonConvert.convert<int>(json['odds']);
  if (odds != null) {
    betReqSeriesOrdersOrderDetailList.odds = odds;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    betReqSeriesOrdersOrderDetailList.oddFinally = oddFinally;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    betReqSeriesOrdersOrderDetailList.playName = playName;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    betReqSeriesOrdersOrderDetailList.sportName = sportName;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    betReqSeriesOrdersOrderDetailList.matchType = matchType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    betReqSeriesOrdersOrderDetailList.matchName = matchName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    betReqSeriesOrdersOrderDetailList.playOptionName = playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    betReqSeriesOrdersOrderDetailList.playOptions = playOptions;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    betReqSeriesOrdersOrderDetailList.tournamentLevel = tournamentLevel;
  }
  final String? playId = jsonConvert.convert<String>(json['playId']);
  if (playId != null) {
    betReqSeriesOrdersOrderDetailList.playId = playId;
  }
  final String? dataSource = jsonConvert.convert<String>(json['dataSource']);
  if (dataSource != null) {
    betReqSeriesOrdersOrderDetailList.dataSource = dataSource;
  }
  return betReqSeriesOrdersOrderDetailList;
}

Map<String, dynamic> $BetReqSeriesOrdersOrderDetailListToJson(
    BetReqSeriesOrdersOrderDetailList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['sportId'] = entity.sportId;
  data['matchId'] = entity.matchId;
  data['tournamentId'] = entity.tournamentId;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['betAmount'] = entity.betAmount;
  data['placeNum'] = entity.placeNum;
  data['marketId'] = entity.marketId;
  data['playOptionsId'] = entity.playOptionsId;
  data['marketTypeFinally'] = entity.marketTypeFinally;
  data['marketValue'] = entity.marketValue;
  data['odds'] = entity.odds;
  data['oddFinally'] = entity.oddFinally;
  data['playName'] = entity.playName;
  data['sportName'] = entity.sportName;
  data['matchType'] = entity.matchType;
  data['matchName'] = entity.matchName;
  data['playOptionName'] = entity.playOptionName;
  data['playOptions'] = entity.playOptions;
  data['tournamentLevel'] = entity.tournamentLevel;
  data['playId'] = entity.playId;
  data['dataSource'] = entity.dataSource;
  return data;
}

extension BetReqSeriesOrdersOrderDetailListExtension on BetReqSeriesOrdersOrderDetailList {
  BetReqSeriesOrdersOrderDetailList copyWith({
    String? sportId,
    String? matchId,
    String? tournamentId,
    String? scoreBenchmark,
    String? betAmount,
    String? placeNum,
    String? marketId,
    String? playOptionsId,
    String? marketTypeFinally,
    String? marketValue,
    int? odds,
    String? oddFinally,
    String? playName,
    String? sportName,
    int? matchType,
    String? matchName,
    String? playOptionName,
    String? playOptions,
    int? tournamentLevel,
    String? playId,
    String? dataSource,
  }) {
    return BetReqSeriesOrdersOrderDetailList()
      ..sportId = sportId ?? this.sportId
      ..matchId = matchId ?? this.matchId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..betAmount = betAmount ?? this.betAmount
      ..placeNum = placeNum ?? this.placeNum
      ..marketId = marketId ?? this.marketId
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..marketTypeFinally = marketTypeFinally ?? this.marketTypeFinally
      ..marketValue = marketValue ?? this.marketValue
      ..odds = odds ?? this.odds
      ..oddFinally = oddFinally ?? this.oddFinally
      ..playName = playName ?? this.playName
      ..sportName = sportName ?? this.sportName
      ..matchType = matchType ?? this.matchType
      ..matchName = matchName ?? this.matchName
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptions = playOptions ?? this.playOptions
      ..tournamentLevel = tournamentLevel ?? this.tournamentLevel
      ..playId = playId ?? this.playId
      ..dataSource = dataSource ?? this.dataSource;
  }
}