import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/last_market_entity.dart';

LastMarketEntity $LastMarketEntityFromJson(Map<String, dynamic> json) {
  final LastMarketEntity lastMarketEntity = LastMarketEntity();
  final String? away = jsonConvert.convert<String>(json['away']);
  if (away != null) {
    lastMarketEntity.away = away;
  }
  final LastMarketCurrentMarket? currentMarket = jsonConvert.convert<
      LastMarketCurrentMarket>(json['currentMarket']);
  if (currentMarket != null) {
    lastMarketEntity.currentMarket = currentMarket;
  }
  final String? home = jsonConvert.convert<String>(json['home']);
  if (home != null) {
    lastMarketEntity.home = home;
  }
  final List<LastMarketMarketList>? marketList = (json['marketList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<LastMarketMarketList>(e) as LastMarketMarketList)
      .toList();
  if (marketList != null) {
    lastMarketEntity.marketList = marketList;
  }
  final int? matchHandicapStatus = jsonConvert.convert<int>(
      json['matchHandicapStatus']);
  if (matchHandicapStatus != null) {
    lastMarketEntity.matchHandicapStatus = matchHandicapStatus;
  }
  final String? matchInfoId = jsonConvert.convert<String>(json['matchInfoId']);
  if (matchInfoId != null) {
    lastMarketEntity.matchInfoId = matchInfoId;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    lastMarketEntity.matchOver = matchOver;
  }
  final int? matchPeriodId = jsonConvert.convert<int>(json['matchPeriodId']);
  if (matchPeriodId != null) {
    lastMarketEntity.matchPeriodId = matchPeriodId;
  }
  final int? matchStatus = jsonConvert.convert<int>(json['matchStatus']);
  if (matchStatus != null) {
    lastMarketEntity.matchStatus = matchStatus;
  }
  final int? pendingOrderStatus = jsonConvert.convert<int>(
      json['pendingOrderStatus']);
  if (pendingOrderStatus != null) {
    lastMarketEntity.pendingOrderStatus = pendingOrderStatus;
  }
  final String? playId = jsonConvert.convert<String>(json['playId']);
  if (playId != null) {
    lastMarketEntity.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    lastMarketEntity.playName = playName;
  }
  return lastMarketEntity;
}

Map<String, dynamic> $LastMarketEntityToJson(LastMarketEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['away'] = entity.away;
  data['currentMarket'] = entity.currentMarket?.toJson();
  data['home'] = entity.home;
  data['marketList'] = entity.marketList.map((v) => v.toJson()).toList();
  data['matchHandicapStatus'] = entity.matchHandicapStatus;
  data['matchInfoId'] = entity.matchInfoId;
  data['matchOver'] = entity.matchOver;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['matchStatus'] = entity.matchStatus;
  data['pendingOrderStatus'] = entity.pendingOrderStatus;
  data['playId'] = entity.playId;
  data['playName'] = entity.playName;
  return data;
}

extension LastMarketEntityExtension on LastMarketEntity {
  LastMarketEntity copyWith({
    String? away,
    LastMarketCurrentMarket? currentMarket,
    String? home,
    List<LastMarketMarketList>? marketList,
    int? matchHandicapStatus,
    String? matchInfoId,
    int? matchOver,
    int? matchPeriodId,
    int? matchStatus,
    int? pendingOrderStatus,
    String? playId,
    String? playName,
  }) {
    return LastMarketEntity()
      ..away = away ?? this.away
      ..currentMarket = currentMarket ?? this.currentMarket
      ..home = home ?? this.home
      ..marketList = marketList ?? this.marketList
      ..matchHandicapStatus = matchHandicapStatus ?? this.matchHandicapStatus
      ..matchInfoId = matchInfoId ?? this.matchInfoId
      ..matchOver = matchOver ?? this.matchOver
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..matchStatus = matchStatus ?? this.matchStatus
      ..pendingOrderStatus = pendingOrderStatus ?? this.pendingOrderStatus
      ..playId = playId ?? this.playId
      ..playName = playName ?? this.playName;
  }
}

LastMarketCurrentMarket $LastMarketCurrentMarketFromJson(
    Map<String, dynamic> json) {
  final LastMarketCurrentMarket lastMarketCurrentMarket = LastMarketCurrentMarket();
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    lastMarketCurrentMarket.chpid = chpid;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    lastMarketCurrentMarket.id = id;
  }
  final List<
      LastMarketCurrentMarketMarketOddsList>? marketOddsList = (json['marketOddsList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<LastMarketCurrentMarketMarketOddsList>(
          e) as LastMarketCurrentMarketMarketOddsList).toList();
  if (marketOddsList != null) {
    lastMarketCurrentMarket.marketOddsList = marketOddsList;
  }
  final int? marketType = jsonConvert.convert<int>(json['marketType']);
  if (marketType != null) {
    lastMarketCurrentMarket.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    lastMarketCurrentMarket.marketValue = marketValue;
  }
  final int? placeNum = jsonConvert.convert<int>(json['placeNum']);
  if (placeNum != null) {
    lastMarketCurrentMarket.placeNum = placeNum;
  }
  final String? preBetBenchmarkScore = jsonConvert.convert<String>(
      json['preBetBenchmarkScore']);
  if (preBetBenchmarkScore != null) {
    lastMarketCurrentMarket.preBetBenchmarkScore = preBetBenchmarkScore;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    lastMarketCurrentMarket.score = score;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    lastMarketCurrentMarket.status = status;
  }
  return lastMarketCurrentMarket;
}

Map<String, dynamic> $LastMarketCurrentMarketToJson(
    LastMarketCurrentMarket entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['chpid'] = entity.chpid;
  data['id'] = entity.id;
  data['marketOddsList'] =
      entity.marketOddsList.map((v) => v.toJson()).toList();
  data['marketType'] = entity.marketType;
  data['marketValue'] = entity.marketValue;
  data['placeNum'] = entity.placeNum;
  data['preBetBenchmarkScore'] = entity.preBetBenchmarkScore;
  data['score'] = entity.score;
  data['status'] = entity.status;
  return data;
}

extension LastMarketCurrentMarketExtension on LastMarketCurrentMarket {
  LastMarketCurrentMarket copyWith({
    String? chpid,
    String? id,
    List<LastMarketCurrentMarketMarketOddsList>? marketOddsList,
    int? marketType,
    String? marketValue,
    int? placeNum,
    String? preBetBenchmarkScore,
    String? score,
    int? status,
  }) {
    return LastMarketCurrentMarket()
      ..chpid = chpid ?? this.chpid
      ..id = id ?? this.id
      ..marketOddsList = marketOddsList ?? this.marketOddsList
      ..marketType = marketType ?? this.marketType
      ..marketValue = marketValue ?? this.marketValue
      ..placeNum = placeNum ?? this.placeNum
      ..preBetBenchmarkScore = preBetBenchmarkScore ?? this.preBetBenchmarkScore
      ..score = score ?? this.score
      ..status = status ?? this.status;
  }
}

LastMarketCurrentMarketMarketOddsList $LastMarketCurrentMarketMarketOddsListFromJson(
    Map<String, dynamic> json) {
  final LastMarketCurrentMarketMarketOddsList lastMarketCurrentMarketMarketOddsList = LastMarketCurrentMarketMarketOddsList();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    lastMarketCurrentMarketMarketOddsList.id = id;
  }
  final int? oddsStatus = jsonConvert.convert<int>(json['oddsStatus']);
  if (oddsStatus != null) {
    lastMarketCurrentMarketMarketOddsList.oddsStatus = oddsStatus;
  }
  final String? oddsType = jsonConvert.convert<String>(json['oddsType']);
  if (oddsType != null) {
    lastMarketCurrentMarketMarketOddsList.oddsType = oddsType;
  }
  final int? oddsValue = jsonConvert.convert<int>(json['oddsValue']);
  if (oddsValue != null) {
    lastMarketCurrentMarketMarketOddsList.oddsValue = oddsValue;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    lastMarketCurrentMarketMarketOddsList.playOptions = playOptions;
  }
  return lastMarketCurrentMarketMarketOddsList;
}

Map<String, dynamic> $LastMarketCurrentMarketMarketOddsListToJson(
    LastMarketCurrentMarketMarketOddsList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['oddsStatus'] = entity.oddsStatus;
  data['oddsType'] = entity.oddsType;
  data['oddsValue'] = entity.oddsValue;
  data['playOptions'] = entity.playOptions;
  return data;
}

extension LastMarketCurrentMarketMarketOddsListExtension on LastMarketCurrentMarketMarketOddsList {
  LastMarketCurrentMarketMarketOddsList copyWith({
    String? id,
    int? oddsStatus,
    String? oddsType,
    int? oddsValue,
    String? playOptions,
  }) {
    return LastMarketCurrentMarketMarketOddsList()
      ..id = id ?? this.id
      ..oddsStatus = oddsStatus ?? this.oddsStatus
      ..oddsType = oddsType ?? this.oddsType
      ..oddsValue = oddsValue ?? this.oddsValue
      ..playOptions = playOptions ?? this.playOptions;
  }
}

LastMarketMarketList $LastMarketMarketListFromJson(Map<String, dynamic> json) {
  final LastMarketMarketList lastMarketMarketList = LastMarketMarketList();
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    lastMarketMarketList.chpid = chpid;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    lastMarketMarketList.id = id;
  }
  final List<
      LastMarketMarketListMarketOddsList>? marketOddsList = (json['marketOddsList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<LastMarketMarketListMarketOddsList>(
          e) as LastMarketMarketListMarketOddsList).toList();
  if (marketOddsList != null) {
    lastMarketMarketList.marketOddsList = marketOddsList;
  }
  final int? marketType = jsonConvert.convert<int>(json['marketType']);
  if (marketType != null) {
    lastMarketMarketList.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    lastMarketMarketList.marketValue = marketValue;
  }
  final int? placeNum = jsonConvert.convert<int>(json['placeNum']);
  if (placeNum != null) {
    lastMarketMarketList.placeNum = placeNum;
  }
  final String? preBetBenchmarkScore = jsonConvert.convert<String>(
      json['preBetBenchmarkScore']);
  if (preBetBenchmarkScore != null) {
    lastMarketMarketList.preBetBenchmarkScore = preBetBenchmarkScore;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    lastMarketMarketList.score = score;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    lastMarketMarketList.status = status;
  }
  return lastMarketMarketList;
}

Map<String, dynamic> $LastMarketMarketListToJson(LastMarketMarketList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['chpid'] = entity.chpid;
  data['id'] = entity.id;
  data['marketOddsList'] =
      entity.marketOddsList.map((v) => v.toJson()).toList();
  data['marketType'] = entity.marketType;
  data['marketValue'] = entity.marketValue;
  data['placeNum'] = entity.placeNum;
  data['preBetBenchmarkScore'] = entity.preBetBenchmarkScore;
  data['score'] = entity.score;
  data['status'] = entity.status;
  return data;
}

extension LastMarketMarketListExtension on LastMarketMarketList {
  LastMarketMarketList copyWith({
    String? chpid,
    String? id,
    List<LastMarketMarketListMarketOddsList>? marketOddsList,
    int? marketType,
    String? marketValue,
    int? placeNum,
    String? preBetBenchmarkScore,
    String? score,
    int? status,
  }) {
    return LastMarketMarketList()
      ..chpid = chpid ?? this.chpid
      ..id = id ?? this.id
      ..marketOddsList = marketOddsList ?? this.marketOddsList
      ..marketType = marketType ?? this.marketType
      ..marketValue = marketValue ?? this.marketValue
      ..placeNum = placeNum ?? this.placeNum
      ..preBetBenchmarkScore = preBetBenchmarkScore ?? this.preBetBenchmarkScore
      ..score = score ?? this.score
      ..status = status ?? this.status;
  }
}

LastMarketMarketListMarketOddsList $LastMarketMarketListMarketOddsListFromJson(
    Map<String, dynamic> json) {
  final LastMarketMarketListMarketOddsList lastMarketMarketListMarketOddsList = LastMarketMarketListMarketOddsList();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    lastMarketMarketListMarketOddsList.id = id;
  }
  final int? oddsStatus = jsonConvert.convert<int>(json['oddsStatus']);
  if (oddsStatus != null) {
    lastMarketMarketListMarketOddsList.oddsStatus = oddsStatus;
  }
  final String? oddsType = jsonConvert.convert<String>(json['oddsType']);
  if (oddsType != null) {
    lastMarketMarketListMarketOddsList.oddsType = oddsType;
  }
  final int? oddsValue = jsonConvert.convert<int>(json['oddsValue']);
  if (oddsValue != null) {
    lastMarketMarketListMarketOddsList.oddsValue = oddsValue;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    lastMarketMarketListMarketOddsList.playOptions = playOptions;
  }
  return lastMarketMarketListMarketOddsList;
}

Map<String, dynamic> $LastMarketMarketListMarketOddsListToJson(
    LastMarketMarketListMarketOddsList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['oddsStatus'] = entity.oddsStatus;
  data['oddsType'] = entity.oddsType;
  data['oddsValue'] = entity.oddsValue;
  data['playOptions'] = entity.playOptions;
  return data;
}

extension LastMarketMarketListMarketOddsListExtension on LastMarketMarketListMarketOddsList {
  LastMarketMarketListMarketOddsList copyWith({
    String? id,
    int? oddsStatus,
    String? oddsType,
    int? oddsValue,
    String? playOptions,
  }) {
    return LastMarketMarketListMarketOddsList()
      ..id = id ?? this.id
      ..oddsStatus = oddsStatus ?? this.oddsStatus
      ..oddsType = oddsType ?? this.oddsType
      ..oddsValue = oddsValue ?? this.oddsValue
      ..playOptions = playOptions ?? this.playOptions;
  }
}