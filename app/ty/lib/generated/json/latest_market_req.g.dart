import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/req/latest_market_req.dart';

LatestMarketReq $LatestMarketReqFromJson(Map<String, dynamic> json) {
  final LatestMarketReq latestMarketReq = LatestMarketReq();
  final List<LatestMarketReqIdList>? idList = (json['idList'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<LatestMarketReqIdList>(e) as LatestMarketReqIdList)
      .toList();
  if (idList != null) {
    latestMarketReq.idList = idList;
  }
  return latestMarketReq;
}

Map<String, dynamic> $LatestMarketReqToJson(LatestMarketReq entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['idList'] = entity.idList.map((v) => v.toJson()).toList();
  return data;
}

extension LatestMarketReqExtension on LatestMarketReq {
  LatestMarketReq copyWith({
    List<LatestMarketReqIdList>? idList,
  }) {
    return LatestMarketReq()
      ..idList = idList ?? this.idList;
  }
}

LatestMarketReqIdList $LatestMarketReqIdListFromJson(
    Map<String, dynamic> json) {
  final LatestMarketReqIdList latestMarketReqIdList = LatestMarketReqIdList();
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    latestMarketReqIdList.marketId = marketId;
  }
  final String? matchInfoId = jsonConvert.convert<String>(json['matchInfoId']);
  if (matchInfoId != null) {
    latestMarketReqIdList.matchInfoId = matchInfoId;
  }
  final String? oddsId = jsonConvert.convert<String>(json['oddsId']);
  if (oddsId != null) {
    latestMarketReqIdList.oddsId = oddsId;
  }
  final String? oddsType = jsonConvert.convert<String>(json['oddsType']);
  if (oddsType != null) {
    latestMarketReqIdList.oddsType = oddsType;
  }
  final String? playId = jsonConvert.convert<String>(json['playId']);
  if (playId != null) {
    latestMarketReqIdList.playId = playId;
  }
  final int? placeNum = jsonConvert.convert<int>(json['placeNum']);
  if (placeNum != null) {
    latestMarketReqIdList.placeNum = placeNum;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    latestMarketReqIdList.matchType = matchType;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    latestMarketReqIdList.sportId = sportId;
  }
  return latestMarketReqIdList;
}

Map<String, dynamic> $LatestMarketReqIdListToJson(
    LatestMarketReqIdList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['marketId'] = entity.marketId;
  data['matchInfoId'] = entity.matchInfoId;
  data['oddsId'] = entity.oddsId;
  data['oddsType'] = entity.oddsType;
  data['playId'] = entity.playId;
  data['placeNum'] = entity.placeNum;
  data['matchType'] = entity.matchType;
  data['sportId'] = entity.sportId;
  return data;
}

extension LatestMarketReqIdListExtension on LatestMarketReqIdList {
  LatestMarketReqIdList copyWith({
    String? marketId,
    String? matchInfoId,
    String? oddsId,
    String? oddsType,
    String? playId,
    int? placeNum,
    int? matchType,
    String? sportId,
  }) {
    return LatestMarketReqIdList()
      ..marketId = marketId ?? this.marketId
      ..matchInfoId = matchInfoId ?? this.matchInfoId
      ..oddsId = oddsId ?? this.oddsId
      ..oddsType = oddsType ?? this.oddsType
      ..playId = playId ?? this.playId
      ..placeNum = placeNum ?? this.placeNum
      ..matchType = matchType ?? this.matchType
      ..sportId = sportId ?? this.sportId;
  }
}