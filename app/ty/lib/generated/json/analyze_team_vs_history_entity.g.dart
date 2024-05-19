import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';

AnalyzeTeamVsHistoryEntity $AnalyzeTeamVsHistoryEntityFromJson(
    Map<String, dynamic> json) {
  final AnalyzeTeamVsHistoryEntity analyzeTeamVsHistoryEntity = AnalyzeTeamVsHistoryEntity();
  final String? awayTeamId = jsonConvert.convert<String>(json['awayTeamId']);
  if (awayTeamId != null) {
    analyzeTeamVsHistoryEntity.awayTeamId = awayTeamId;
  }
  final String? awayTeamName = jsonConvert.convert<String>(
      json['awayTeamName']);
  if (awayTeamName != null) {
    analyzeTeamVsHistoryEntity.awayTeamName = awayTeamName;
  }
  final String? awayTeamScore = jsonConvert.convert<String>(
      json['awayTeamScore']);
  if (awayTeamScore != null) {
    analyzeTeamVsHistoryEntity.awayTeamScore = awayTeamScore;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    analyzeTeamVsHistoryEntity.beginTime = beginTime;
  }
  final String? boldTagName = jsonConvert.convert<String>(json['boldTagName']);
  if (boldTagName != null) {
    analyzeTeamVsHistoryEntity.boldTagName = boldTagName;
  }
  final String? handicapOdds = jsonConvert.convert<String>(
      json['handicapOdds']);
  if (handicapOdds != null) {
    analyzeTeamVsHistoryEntity.handicapOdds = handicapOdds;
  }
  final num? handicapResult = jsonConvert.convert<num>(json['handicapResult']);
  if (handicapResult != null) {
    analyzeTeamVsHistoryEntity.handicapResult = handicapResult;
  }
  final String? handicapVal = jsonConvert.convert<String>(json['handicapVal']);
  if (handicapVal != null) {
    analyzeTeamVsHistoryEntity.handicapVal = handicapVal;
  }
  final String? homeTeamId = jsonConvert.convert<String>(json['homeTeamId']);
  if (homeTeamId != null) {
    analyzeTeamVsHistoryEntity.homeTeamId = homeTeamId;
  }
  final String? homeTeamName = jsonConvert.convert<String>(
      json['homeTeamName']);
  if (homeTeamName != null) {
    analyzeTeamVsHistoryEntity.homeTeamName = homeTeamName;
  }
  final String? homeTeamScore = jsonConvert.convert<String>(
      json['homeTeamScore']);
  if (homeTeamScore != null) {
    analyzeTeamVsHistoryEntity.homeTeamScore = homeTeamScore;
  }
  final num? matchGroup = jsonConvert.convert<num>(json['matchGroup']);
  if (matchGroup != null) {
    analyzeTeamVsHistoryEntity.matchGroup = matchGroup;
  }
  final String? overunderOdds = jsonConvert.convert<String>(
      json['overunderOdds']);
  if (overunderOdds != null) {
    analyzeTeamVsHistoryEntity.overunderOdds = overunderOdds;
  }
  final dynamic overunderResult = json['overunderResult'];
  if (overunderResult != null) {
    analyzeTeamVsHistoryEntity.overunderResult = overunderResult;
  }
  final String? overunderVal = jsonConvert.convert<String>(
      json['overunderVal']);
  if (overunderVal != null) {
    analyzeTeamVsHistoryEntity.overunderVal = overunderVal;
  }
  final num? result = jsonConvert.convert<num>(json['result']);
  if (result != null) {
    analyzeTeamVsHistoryEntity.result = result;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    analyzeTeamVsHistoryEntity.sportId = sportId;
  }
  final String? teamGroup = jsonConvert.convert<String>(json['teamGroup']);
  if (teamGroup != null) {
    analyzeTeamVsHistoryEntity.teamGroup = teamGroup;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    analyzeTeamVsHistoryEntity.thirdMatchId = thirdMatchId;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    analyzeTeamVsHistoryEntity.tournamentName = tournamentName;
  }
  final String? winnerOdds = jsonConvert.convert<String>(json['winnerOdds']);
  if (winnerOdds != null) {
    analyzeTeamVsHistoryEntity.winnerOdds = winnerOdds;
  }
  return analyzeTeamVsHistoryEntity;
}

Map<String, dynamic> $AnalyzeTeamVsHistoryEntityToJson(
    AnalyzeTeamVsHistoryEntity entity) {
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

extension AnalyzeTeamVsHistoryEntityExtension on AnalyzeTeamVsHistoryEntity {
  AnalyzeTeamVsHistoryEntity copyWith({
    String? awayTeamId,
    String? awayTeamName,
    String? awayTeamScore,
    String? beginTime,
    String? boldTagName,
    String? handicapOdds,
    num? handicapResult,
    String? handicapVal,
    String? homeTeamId,
    String? homeTeamName,
    String? homeTeamScore,
    num? matchGroup,
    String? overunderOdds,
    dynamic overunderResult,
    String? overunderVal,
    num? result,
    String? sportId,
    String? teamGroup,
    String? thirdMatchId,
    String? tournamentName,
    String? winnerOdds,
  }) {
    return AnalyzeTeamVsHistoryEntity()
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