import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/mchampion_match_result_entity.dart';

MchampionMatchResultEntity $MchampionMatchResultEntityFromJson(
    Map<String, dynamic> json) {
  final MchampionMatchResultEntity mchampionMatchResultEntity = MchampionMatchResultEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    mchampionMatchResultEntity.code = code;
  }
  final List<MchampionMatchResultData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MchampionMatchResultData>(
          e) as MchampionMatchResultData)
      .toList();
  if (data != null) {
    mchampionMatchResultEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    mchampionMatchResultEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    mchampionMatchResultEntity.ts = ts;
  }
  return mchampionMatchResultEntity;
}

Map<String, dynamic> $MchampionMatchResultEntityToJson(
    MchampionMatchResultEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MchampionMatchResultEntityExtension on MchampionMatchResultEntity {
  MchampionMatchResultEntity copyWith({
    String? code,
    List<MchampionMatchResultData>? data,
    String? msg,
    int? ts,
  }) {
    return MchampionMatchResultEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MchampionMatchResultData $MchampionMatchResultDataFromJson(
    Map<String, dynamic> json) {
  final MchampionMatchResultData mchampionMatchResultData = MchampionMatchResultData();
  final String? picUrl = jsonConvert.convert<String>(json['picUrl']);
  if (picUrl != null) {
    mchampionMatchResultData.picUrl = picUrl;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    mchampionMatchResultData.sportId = sportId;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    mchampionMatchResultData.tournamentName = tournamentName;
  }
  final String? scoreResult = jsonConvert.convert<String>(json['scoreResult']);
  if (scoreResult != null) {
    mchampionMatchResultData.scoreResult = scoreResult;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    mchampionMatchResultData.tournamentId = tournamentId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    mchampionMatchResultData.playName = playName;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    mchampionMatchResultData.sportName = sportName;
  }
  final String? matchTime = jsonConvert.convert<String>(json['matchTime']);
  if (matchTime != null) {
    mchampionMatchResultData.matchTime = matchTime;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    mchampionMatchResultData.matchId = matchId;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    mchampionMatchResultData.marketId = marketId;
  }
  final bool? isExpand = jsonConvert.convert<bool>(json['isExpand']);
  if (isExpand != null) {
    mchampionMatchResultData.isExpand = isExpand;
  }
  return mchampionMatchResultData;
}

Map<String, dynamic> $MchampionMatchResultDataToJson(
    MchampionMatchResultData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['picUrl'] = entity.picUrl;
  data['sportId'] = entity.sportId;
  data['tournamentName'] = entity.tournamentName;
  data['scoreResult'] = entity.scoreResult;
  data['tournamentId'] = entity.tournamentId;
  data['playName'] = entity.playName;
  data['sportName'] = entity.sportName;
  data['matchTime'] = entity.matchTime;
  data['matchId'] = entity.matchId;
  data['marketId'] = entity.marketId;
  data['isExpand'] = entity.isExpand;
  return data;
}

extension MchampionMatchResultDataExtension on MchampionMatchResultData {
  MchampionMatchResultData copyWith({
    String? picUrl,
    String? sportId,
    String? tournamentName,
    String? scoreResult,
    String? tournamentId,
    String? playName,
    String? sportName,
    String? matchTime,
    String? matchId,
    String? marketId,
    bool? isExpand,
  }) {
    return MchampionMatchResultData()
      ..picUrl = picUrl ?? this.picUrl
      ..sportId = sportId ?? this.sportId
      ..tournamentName = tournamentName ?? this.tournamentName
      ..scoreResult = scoreResult ?? this.scoreResult
      ..tournamentId = tournamentId ?? this.tournamentId
      ..playName = playName ?? this.playName
      ..sportName = sportName ?? this.sportName
      ..matchTime = matchTime ?? this.matchTime
      ..matchId = matchId ?? this.matchId
      ..marketId = marketId ?? this.marketId
      ..isExpand = isExpand ?? this.isExpand;
  }
}