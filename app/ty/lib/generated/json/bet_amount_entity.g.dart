import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/bet_amount_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/last_market_entity.dart';


BetAmountEntity $BetAmountEntityFromJson(Map<String, dynamic> json) {
  final BetAmountEntity betAmountEntity = BetAmountEntity();
  final List<
      BetAmountBetAmountInfo>? betAmountInfo = (json['betAmountInfo'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<BetAmountBetAmountInfo>(e) as BetAmountBetAmountInfo)
      .toList();
  if (betAmountInfo != null) {
    betAmountEntity.betAmountInfo = betAmountInfo;
  }
  final List<
      LastMarketEntity>? latestMarketInfo = (json['latestMarketInfo'] as List<
      dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<LastMarketEntity>(e) as LastMarketEntity)
      .toList();
  if (latestMarketInfo != null) {
    betAmountEntity.latestMarketInfo = latestMarketInfo;
  }
  return betAmountEntity;
}

Map<String, dynamic> $BetAmountEntityToJson(BetAmountEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmountInfo'] = entity.betAmountInfo.map((v) => v.toJson()).toList();
  data['latestMarketInfo'] =
      entity.latestMarketInfo.map((v) => v.toJson()).toList();
  return data;
}

extension BetAmountEntityExtension on BetAmountEntity {
  BetAmountEntity copyWith({
    List<BetAmountBetAmountInfo>? betAmountInfo,
    List<LastMarketEntity>? latestMarketInfo,
  }) {
    return BetAmountEntity()
      ..betAmountInfo = betAmountInfo ?? this.betAmountInfo
      ..latestMarketInfo = latestMarketInfo ?? this.latestMarketInfo;
  }
}

BetAmountBetAmountInfo $BetAmountBetAmountInfoFromJson(
    Map<String, dynamic> json) {
  final BetAmountBetAmountInfo betAmountBetAmountInfo = BetAmountBetAmountInfo();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    betAmountBetAmountInfo.code = code;
  }
  final String? globalId = jsonConvert.convert<String>(json['globalId']);
  if (globalId != null) {
    betAmountBetAmountInfo.globalId = globalId;
  }
  final String? minBet = jsonConvert.convert<String>(json['minBet']);
  if (minBet != null) {
    betAmountBetAmountInfo.minBet = minBet;
  }
  final String? orderMaxPay = jsonConvert.convert<String>(json['orderMaxPay']);
  if (orderMaxPay != null) {
    betAmountBetAmountInfo.orderMaxPay = orderMaxPay;
  }
  final String? playId = jsonConvert.convert<String>(json['playId']);
  if (playId != null) {
    betAmountBetAmountInfo.playId = playId;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    betAmountBetAmountInfo.playOptionsId = playOptionsId;
  }
  final String? seriesOdds = jsonConvert.convert<String>(json['seriesOdds']);
  if (seriesOdds != null) {
    betAmountBetAmountInfo.seriesOdds = seriesOdds;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    betAmountBetAmountInfo.type = type;
  }
  return betAmountBetAmountInfo;
}

Map<String, dynamic> $BetAmountBetAmountInfoToJson(
    BetAmountBetAmountInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['globalId'] = entity.globalId;
  data['minBet'] = entity.minBet;
  data['orderMaxPay'] = entity.orderMaxPay;
  data['playId'] = entity.playId;
  data['playOptionsId'] = entity.playOptionsId;
  data['seriesOdds'] = entity.seriesOdds;
  data['type'] = entity.type;
  return data;
}

extension BetAmountBetAmountInfoExtension on BetAmountBetAmountInfo {
  BetAmountBetAmountInfo copyWith({
    int? code,
    String? globalId,
    String? minBet,
    String? orderMaxPay,
    String? playId,
    String? playOptionsId,
    String? seriesOdds,
    String? type,
  }) {
    return BetAmountBetAmountInfo()
      ..code = code ?? this.code
      ..globalId = globalId ?? this.globalId
      ..minBet = minBet ?? this.minBet
      ..orderMaxPay = orderMaxPay ?? this.orderMaxPay
      ..playId = playId ?? this.playId
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..seriesOdds = seriesOdds ?? this.seriesOdds
      ..type = type ?? this.type;
  }
}