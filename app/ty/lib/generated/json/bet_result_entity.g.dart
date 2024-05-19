import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/bet_result_entity.dart';

BetResultEntity $BetResultEntityFromJson(Map<String, dynamic> json) {
  final BetResultEntity betResultEntity = BetResultEntity();
  final String? betMoneyTotal = jsonConvert.convert<String>(
      json['betMoneyTotal']);
  if (betMoneyTotal != null) {
    betResultEntity.betMoneyTotal = betMoneyTotal;
  }
  final String? globalId = jsonConvert.convert<String>(json['globalId']);
  if (globalId != null) {
    betResultEntity.globalId = globalId;
  }
  final int? lock = jsonConvert.convert<int>(json['lock']);
  if (lock != null) {
    betResultEntity.lock = lock;
  }
  final String? maxWinMoneyTotal = jsonConvert.convert<String>(
      json['maxWinMoneyTotal']);
  if (maxWinMoneyTotal != null) {
    betResultEntity.maxWinMoneyTotal = maxWinMoneyTotal;
  }
  final List<
      BetResultOrderDetailRespList>? orderDetailRespList = (json['orderDetailRespList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<BetResultOrderDetailRespList>(
          e) as BetResultOrderDetailRespList).toList();
  if (orderDetailRespList != null) {
    betResultEntity.orderDetailRespList = orderDetailRespList;
  }
  final List<
      BetResultSeriesOrderRespList>? seriesOrderRespList = (json['seriesOrderRespList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<BetResultSeriesOrderRespList>(
          e) as BetResultSeriesOrderRespList).toList();
  if (seriesOrderRespList != null) {
    betResultEntity.seriesOrderRespList = seriesOrderRespList;
  }
  return betResultEntity;
}

Map<String, dynamic> $BetResultEntityToJson(BetResultEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betMoneyTotal'] = entity.betMoneyTotal;
  data['globalId'] = entity.globalId;
  data['lock'] = entity.lock;
  data['maxWinMoneyTotal'] = entity.maxWinMoneyTotal;
  data['orderDetailRespList'] =
      entity.orderDetailRespList.map((v) => v.toJson()).toList();
  data['seriesOrderRespList'] =
      entity.seriesOrderRespList.map((v) => v.toJson()).toList();
  return data;
}

extension BetResultEntityExtension on BetResultEntity {
  BetResultEntity copyWith({
    String? betMoneyTotal,
    String? globalId,
    int? lock,
    String? maxWinMoneyTotal,
    List<BetResultOrderDetailRespList>? orderDetailRespList,
    List<BetResultSeriesOrderRespList>? seriesOrderRespList,
  }) {
    return BetResultEntity()
      ..betMoneyTotal = betMoneyTotal ?? this.betMoneyTotal
      ..globalId = globalId ?? this.globalId
      ..lock = lock ?? this.lock
      ..maxWinMoneyTotal = maxWinMoneyTotal ?? this.maxWinMoneyTotal
      ..orderDetailRespList = orderDetailRespList ?? this.orderDetailRespList
      ..seriesOrderRespList = seriesOrderRespList ?? this.seriesOrderRespList;
  }
}

BetResultOrderDetailRespList $BetResultOrderDetailRespListFromJson(
    Map<String, dynamic> json) {
  final BetResultOrderDetailRespList betResultOrderDetailRespList = BetResultOrderDetailRespList();
  final String? addition = jsonConvert.convert<String>(json['addition']);
  if (addition != null) {
    betResultOrderDetailRespList.addition = addition;
  }
  final String? batchNum = jsonConvert.convert<String>(json['batchNum']);
  if (batchNum != null) {
    betResultOrderDetailRespList.batchNum = batchNum;
  }
  final String? betMoney = jsonConvert.convert<String>(json['betMoney']);
  if (betMoney != null) {
    betResultOrderDetailRespList.betMoney = betMoney;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    betResultOrderDetailRespList.marketType = marketType;
  }
  final String? marketValues = jsonConvert.convert<String>(
      json['marketValues']);
  if (marketValues != null) {
    betResultOrderDetailRespList.marketValues = marketValues;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    betResultOrderDetailRespList.matchDay = matchDay;
  }
  final dynamic matchDetailType = json['matchDetailType'];
  if (matchDetailType != null) {
    betResultOrderDetailRespList.matchDetailType = matchDetailType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    betResultOrderDetailRespList.matchInfo = matchInfo;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    betResultOrderDetailRespList.matchName = matchName;
  }
  final int? matchStatus = jsonConvert.convert<int>(json['matchStatus']);
  if (matchStatus != null) {
    betResultOrderDetailRespList.matchStatus = matchStatus;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    betResultOrderDetailRespList.matchType = matchType;
  }
  final String? maxWinMoney = jsonConvert.convert<String>(json['maxWinMoney']);
  if (maxWinMoney != null) {
    betResultOrderDetailRespList.maxWinMoney = maxWinMoney;
  }
  final String? oddsType = jsonConvert.convert<String>(json['oddsType']);
  if (oddsType != null) {
    betResultOrderDetailRespList.oddsType = oddsType;
  }
  final String? oddsValues = jsonConvert.convert<String>(json['oddsValues']);
  if (oddsValues != null) {
    betResultOrderDetailRespList.oddsValues = oddsValues;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    betResultOrderDetailRespList.orderNo = orderNo;
  }
  final int? orderStatusCode = jsonConvert.convert<int>(
      json['orderStatusCode']);
  if (orderStatusCode != null) {
    betResultOrderDetailRespList.orderStatusCode = orderStatusCode;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    betResultOrderDetailRespList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    betResultOrderDetailRespList.playOptionName = playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    betResultOrderDetailRespList.playOptionsId = playOptionsId;
  }
  final dynamic preOrderDetailStatus = json['preOrderDetailStatus'];
  if (preOrderDetailStatus != null) {
    betResultOrderDetailRespList.preOrderDetailStatus = preOrderDetailStatus;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    betResultOrderDetailRespList.scoreBenchmark = scoreBenchmark;
  }
  final String? teamName = jsonConvert.convert<String>(json['teamName']);
  if (teamName != null) {
    betResultOrderDetailRespList.teamName = teamName;
  }
  return betResultOrderDetailRespList;
}

Map<String, dynamic> $BetResultOrderDetailRespListToJson(
    BetResultOrderDetailRespList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['addition'] = entity.addition;
  data['batchNum'] = entity.batchNum;
  data['betMoney'] = entity.betMoney;
  data['marketType'] = entity.marketType;
  data['marketValues'] = entity.marketValues;
  data['matchDay'] = entity.matchDay;
  data['matchDetailType'] = entity.matchDetailType;
  data['matchInfo'] = entity.matchInfo;
  data['matchName'] = entity.matchName;
  data['matchStatus'] = entity.matchStatus;
  data['matchType'] = entity.matchType;
  data['maxWinMoney'] = entity.maxWinMoney;
  data['oddsType'] = entity.oddsType;
  data['oddsValues'] = entity.oddsValues;
  data['orderNo'] = entity.orderNo;
  data['orderStatusCode'] = entity.orderStatusCode;
  data['playName'] = entity.playName;
  data['playOptionName'] = entity.playOptionName;
  data['playOptionsId'] = entity.playOptionsId;
  data['preOrderDetailStatus'] = entity.preOrderDetailStatus;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['teamName'] = entity.teamName;
  return data;
}

extension BetResultOrderDetailRespListExtension on BetResultOrderDetailRespList {
  BetResultOrderDetailRespList copyWith({
    String? addition,
    String? batchNum,
    String? betMoney,
    String? marketType,
    String? marketValues,
    String? matchDay,
    dynamic matchDetailType,
    String? matchInfo,
    String? matchName,
    int? matchStatus,
    int? matchType,
    String? maxWinMoney,
    String? oddsType,
    String? oddsValues,
    String? orderNo,
    int? orderStatusCode,
    String? playName,
    String? playOptionName,
    String? playOptionsId,
    dynamic preOrderDetailStatus,
    String? scoreBenchmark,
    String? teamName,
  }) {
    return BetResultOrderDetailRespList()
      ..addition = addition ?? this.addition
      ..batchNum = batchNum ?? this.batchNum
      ..betMoney = betMoney ?? this.betMoney
      ..marketType = marketType ?? this.marketType
      ..marketValues = marketValues ?? this.marketValues
      ..matchDay = matchDay ?? this.matchDay
      ..matchDetailType = matchDetailType ?? this.matchDetailType
      ..matchInfo = matchInfo ?? this.matchInfo
      ..matchName = matchName ?? this.matchName
      ..matchStatus = matchStatus ?? this.matchStatus
      ..matchType = matchType ?? this.matchType
      ..maxWinMoney = maxWinMoney ?? this.maxWinMoney
      ..oddsType = oddsType ?? this.oddsType
      ..oddsValues = oddsValues ?? this.oddsValues
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatusCode = orderStatusCode ?? this.orderStatusCode
      ..playName = playName ?? this.playName
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..preOrderDetailStatus = preOrderDetailStatus ?? this.preOrderDetailStatus
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..teamName = teamName ?? this.teamName;
  }
}

BetResultSeriesOrderRespList $BetResultSeriesOrderRespListFromJson(
    Map<String, dynamic> json) {
  final BetResultSeriesOrderRespList betResultSeriesOrderRespList = BetResultSeriesOrderRespList();
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    betResultSeriesOrderRespList.betAmount = betAmount;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    betResultSeriesOrderRespList.marketType = marketType;
  }
  final String? maxWinAmount = jsonConvert.convert<String>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    betResultSeriesOrderRespList.maxWinAmount = maxWinAmount;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    betResultSeriesOrderRespList.orderNo = orderNo;
  }
  final int? orderStatusCode = jsonConvert.convert<int>(
      json['orderStatusCode']);
  if (orderStatusCode != null) {
    betResultSeriesOrderRespList.orderStatusCode = orderStatusCode;
  }
  final String? seriesBetAmount = jsonConvert.convert<String>(
      json['seriesBetAmount']);
  if (seriesBetAmount != null) {
    betResultSeriesOrderRespList.seriesBetAmount = seriesBetAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    betResultSeriesOrderRespList.seriesSum = seriesSum;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    betResultSeriesOrderRespList.seriesValue = seriesValue;
  }
  return betResultSeriesOrderRespList;
}

Map<String, dynamic> $BetResultSeriesOrderRespListToJson(
    BetResultSeriesOrderRespList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['marketType'] = entity.marketType;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['orderNo'] = entity.orderNo;
  data['orderStatusCode'] = entity.orderStatusCode;
  data['seriesBetAmount'] = entity.seriesBetAmount;
  data['seriesSum'] = entity.seriesSum;
  data['seriesValue'] = entity.seriesValue;
  return data;
}

extension BetResultSeriesOrderRespListExtension on BetResultSeriesOrderRespList {
  BetResultSeriesOrderRespList copyWith({
    String? betAmount,
    String? marketType,
    String? maxWinAmount,
    String? orderNo,
    int? orderStatusCode,
    String? seriesBetAmount,
    int? seriesSum,
    String? seriesValue,
  }) {
    return BetResultSeriesOrderRespList()
      ..betAmount = betAmount ?? this.betAmount
      ..marketType = marketType ?? this.marketType
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatusCode = orderStatusCode ?? this.orderStatusCode
      ..seriesBetAmount = seriesBetAmount ?? this.seriesBetAmount
      ..seriesSum = seriesSum ?? this.seriesSum
      ..seriesValue = seriesValue ?? this.seriesValue;
  }
}