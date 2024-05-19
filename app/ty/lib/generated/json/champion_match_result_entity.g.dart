import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/champion_match_result_entity.dart';

ChampionMatchResultEntity $ChampionMatchResultEntityFromJson(
    Map<String, dynamic> json) {
  final ChampionMatchResultEntity championMatchResultEntity = ChampionMatchResultEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    championMatchResultEntity.code = code;
  }
  final List<ChampionMatchResultData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ChampionMatchResultData>(
          e) as ChampionMatchResultData)
      .toList();
  if (data != null) {
    championMatchResultEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    championMatchResultEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    championMatchResultEntity.ts = ts;
  }
  return championMatchResultEntity;
}

Map<String, dynamic> $ChampionMatchResultEntityToJson(
    ChampionMatchResultEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension ChampionMatchResultEntityExtension on ChampionMatchResultEntity {
  ChampionMatchResultEntity copyWith({
    String? code,
    List<ChampionMatchResultData>? data,
    String? msg,
    int? ts,
  }) {
    return ChampionMatchResultEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

ChampionMatchResultData $ChampionMatchResultDataFromJson(
    Map<String, dynamic> json) {
  final ChampionMatchResultData championMatchResultData = ChampionMatchResultData();
  final String? picUrl = jsonConvert.convert<String>(json['picUrl']);
  if (picUrl != null) {
    championMatchResultData.picUrl = picUrl;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    championMatchResultData.sportId = sportId;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    championMatchResultData.tournamentName = tournamentName;
  }
  final String? scoreResult = jsonConvert.convert<String>(json['scoreResult']);
  if (scoreResult != null) {
    championMatchResultData.scoreResult = scoreResult;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    championMatchResultData.tournamentId = tournamentId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    championMatchResultData.playName = playName;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    championMatchResultData.sportName = sportName;
  }
  final String? matchTime = jsonConvert.convert<String>(json['matchTime']);
  if (matchTime != null) {
    championMatchResultData.matchTime = matchTime;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    championMatchResultData.matchId = matchId;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    championMatchResultData.marketId = marketId;
  }
  return championMatchResultData;
}

Map<String, dynamic> $ChampionMatchResultDataToJson(
    ChampionMatchResultData entity) {
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
  return data;
}

extension ChampionMatchResultDataExtension on ChampionMatchResultData {
  ChampionMatchResultData copyWith({
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
  }) {
    return ChampionMatchResultData()
      ..picUrl = picUrl ?? this.picUrl
      ..sportId = sportId ?? this.sportId
      ..tournamentName = tournamentName ?? this.tournamentName
      ..scoreResult = scoreResult ?? this.scoreResult
      ..tournamentId = tournamentId ?? this.tournamentId
      ..playName = playName ?? this.playName
      ..sportName = sportName ?? this.sportName
      ..matchTime = matchTime ?? this.matchTime
      ..matchId = matchId ?? this.matchId
      ..marketId = marketId ?? this.marketId;
  }
}