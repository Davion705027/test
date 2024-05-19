import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_details_history_entity.dart';

MatchDetailsHistoryEntity $MatchDetailsHistoryEntityFromJson(
    Map<String, dynamic> json) {
  final MatchDetailsHistoryEntity matchDetailsHistoryEntity = MatchDetailsHistoryEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matchDetailsHistoryEntity.code = code;
  }
  final List<MatchDetailsHistoryData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatchDetailsHistoryData>(
          e) as MatchDetailsHistoryData)
      .toList();
  if (data != null) {
    matchDetailsHistoryEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matchDetailsHistoryEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matchDetailsHistoryEntity.ts = ts;
  }
  return matchDetailsHistoryEntity;
}

Map<String, dynamic> $MatchDetailsHistoryEntityToJson(
    MatchDetailsHistoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatchDetailsHistoryEntityExtension on MatchDetailsHistoryEntity {
  MatchDetailsHistoryEntity copyWith({
    String? code,
    List<MatchDetailsHistoryData>? data,
    String? msg,
    int? ts,
  }) {
    return MatchDetailsHistoryEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatchDetailsHistoryData $MatchDetailsHistoryDataFromJson(
    Map<String, dynamic> json) {
  final MatchDetailsHistoryData matchDetailsHistoryData = MatchDetailsHistoryData();
  final String? awayTeamId = jsonConvert.convert<String>(json['awayTeamId']);
  if (awayTeamId != null) {
    matchDetailsHistoryData.awayTeamId = awayTeamId;
  }
  final String? awayTeamName = jsonConvert.convert<String>(
      json['awayTeamName']);
  if (awayTeamName != null) {
    matchDetailsHistoryData.awayTeamName = awayTeamName;
  }
  final String? awayTeamScore = jsonConvert.convert<String>(
      json['awayTeamScore']);
  if (awayTeamScore != null) {
    matchDetailsHistoryData.awayTeamScore = awayTeamScore;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    matchDetailsHistoryData.beginTime = beginTime;
  }
  final String? boldTagName = jsonConvert.convert<String>(json['boldTagName']);
  if (boldTagName != null) {
    matchDetailsHistoryData.boldTagName = boldTagName;
  }
  final String? handicapOdds = jsonConvert.convert<String>(
      json['handicapOdds']);
  if (handicapOdds != null) {
    matchDetailsHistoryData.handicapOdds = handicapOdds;
  }
  final int? handicapResult = jsonConvert.convert<int>(json['handicapResult']);
  if (handicapResult != null) {
    matchDetailsHistoryData.handicapResult = handicapResult;
  }
  final String? handicapVal = jsonConvert.convert<String>(json['handicapVal']);
  if (handicapVal != null) {
    matchDetailsHistoryData.handicapVal = handicapVal;
  }
  final String? homeTeamId = jsonConvert.convert<String>(json['homeTeamId']);
  if (homeTeamId != null) {
    matchDetailsHistoryData.homeTeamId = homeTeamId;
  }
  final String? homeTeamName = jsonConvert.convert<String>(
      json['homeTeamName']);
  if (homeTeamName != null) {
    matchDetailsHistoryData.homeTeamName = homeTeamName;
  }
  final String? homeTeamScore = jsonConvert.convert<String>(
      json['homeTeamScore']);
  if (homeTeamScore != null) {
    matchDetailsHistoryData.homeTeamScore = homeTeamScore;
  }
  final int? matchGroup = jsonConvert.convert<int>(json['matchGroup']);
  if (matchGroup != null) {
    matchDetailsHistoryData.matchGroup = matchGroup;
  }
  final String? overunderOdds = jsonConvert.convert<String>(
      json['overunderOdds']);
  if (overunderOdds != null) {
    matchDetailsHistoryData.overunderOdds = overunderOdds;
  }
  final int? overunderResult = jsonConvert.convert<int>(
      json['overunderResult']);
  if (overunderResult != null) {
    matchDetailsHistoryData.overunderResult = overunderResult;
  }
  final String? overunderVal = jsonConvert.convert<String>(
      json['overunderVal']);
  if (overunderVal != null) {
    matchDetailsHistoryData.overunderVal = overunderVal;
  }
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    matchDetailsHistoryData.result = result;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    matchDetailsHistoryData.sportId = sportId;
  }
  final String? teamGroup = jsonConvert.convert<String>(json['teamGroup']);
  if (teamGroup != null) {
    matchDetailsHistoryData.teamGroup = teamGroup;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    matchDetailsHistoryData.thirdMatchId = thirdMatchId;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    matchDetailsHistoryData.tournamentName = tournamentName;
  }
  final String? winnerOdds = jsonConvert.convert<String>(json['winnerOdds']);
  if (winnerOdds != null) {
    matchDetailsHistoryData.winnerOdds = winnerOdds;
  }
  return matchDetailsHistoryData;
}

Map<String, dynamic> $MatchDetailsHistoryDataToJson(
    MatchDetailsHistoryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['awayTeamId'] = entity.awayTeamId;
  data['awayTeamName'] = entity.awayTeamName;
  data['awayTeamScore'] = entity.awayTeamScore;
  data['beginTime'] = entity.beginTime;
  data['boldTagName'] = entity.boldTagName;
  data['handicapOdds'] = entity.handicapOdds;
  data['handicapResult'] = entity.handicapResult;
  data['handicapVal'] = entity.handicapVal;
  data['homeTeamId'] = entity.homeTeamId;
  data['homeTeamName'] = entity.homeTeamName;
  data['homeTeamScore'] = entity.homeTeamScore;
  data['matchGroup'] = entity.matchGroup;
  data['overunderOdds'] = entity.overunderOdds;
  data['overunderResult'] = entity.overunderResult;
  data['overunderVal'] = entity.overunderVal;
  data['result'] = entity.result;
  data['sportId'] = entity.sportId;
  data['teamGroup'] = entity.teamGroup;
  data['thirdMatchId'] = entity.thirdMatchId;
  data['tournamentName'] = entity.tournamentName;
  data['winnerOdds'] = entity.winnerOdds;
  return data;
}

extension MatchDetailsHistoryDataExtension on MatchDetailsHistoryData {
  MatchDetailsHistoryData copyWith({
    String? awayTeamId,
    String? awayTeamName,
    String? awayTeamScore,
    String? beginTime,
    String? boldTagName,
    String? handicapOdds,
    int? handicapResult,
    String? handicapVal,
    String? homeTeamId,
    String? homeTeamName,
    String? homeTeamScore,
    int? matchGroup,
    String? overunderOdds,
    int? overunderResult,
    String? overunderVal,
    int? result,
    String? sportId,
    String? teamGroup,
    String? thirdMatchId,
    String? tournamentName,
    String? winnerOdds,
  }) {
    return MatchDetailsHistoryData()
      ..awayTeamId = awayTeamId ?? this.awayTeamId
      ..awayTeamName = awayTeamName ?? this.awayTeamName
      ..awayTeamScore = awayTeamScore ?? this.awayTeamScore
      ..beginTime = beginTime ?? this.beginTime
      ..boldTagName = boldTagName ?? this.boldTagName
      ..handicapOdds = handicapOdds ?? this.handicapOdds
      ..handicapResult = handicapResult ?? this.handicapResult
      ..handicapVal = handicapVal ?? this.handicapVal
      ..homeTeamId = homeTeamId ?? this.homeTeamId
      ..homeTeamName = homeTeamName ?? this.homeTeamName
      ..homeTeamScore = homeTeamScore ?? this.homeTeamScore
      ..matchGroup = matchGroup ?? this.matchGroup
      ..overunderOdds = overunderOdds ?? this.overunderOdds
      ..overunderResult = overunderResult ?? this.overunderResult
      ..overunderVal = overunderVal ?? this.overunderVal
      ..result = result ?? this.result
      ..sportId = sportId ?? this.sportId
      ..teamGroup = teamGroup ?? this.teamGroup
      ..thirdMatchId = thirdMatchId ?? this.thirdMatchId
      ..tournamentName = tournamentName ?? this.tournamentName
      ..winnerOdds = winnerOdds ?? this.winnerOdds;
  }
}