import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_other_team_item_entity_entity.dart';

AnalyzeTeamVsOtherTeamItemEntityEntity $AnalyzeTeamVsOtherTeamItemEntityEntityFromJson(
    Map<String, dynamic> json) {
  final AnalyzeTeamVsOtherTeamItemEntityEntity analyzeTeamVsOtherTeamItemEntityEntity = AnalyzeTeamVsOtherTeamItemEntityEntity();
  final String? awayTeamId = jsonConvert.convert<String>(json['awayTeamId']);
  if (awayTeamId != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.awayTeamId = awayTeamId;
  }
  final String? awayTeamName = jsonConvert.convert<String>(
      json['awayTeamName']);
  if (awayTeamName != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.awayTeamName = awayTeamName;
  }
  final String? awayTeamScore = jsonConvert.convert<String>(
      json['awayTeamScore']);
  if (awayTeamScore != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.awayTeamScore = awayTeamScore;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.beginTime = beginTime;
  }
  final String? boldTagName = jsonConvert.convert<String>(json['boldTagName']);
  if (boldTagName != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.boldTagName = boldTagName;
  }
  final String? handicapOdds = jsonConvert.convert<String>(
      json['handicapOdds']);
  if (handicapOdds != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.handicapOdds = handicapOdds;
  }
  final double? handicapResult = jsonConvert.convert<double>(
      json['handicapResult']);
  if (handicapResult != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.handicapResult = handicapResult;
  }
  final String? handicapVal = jsonConvert.convert<String>(json['handicapVal']);
  if (handicapVal != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.handicapVal = handicapVal;
  }
  final String? homeTeamId = jsonConvert.convert<String>(json['homeTeamId']);
  if (homeTeamId != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.homeTeamId = homeTeamId;
  }
  final String? homeTeamName = jsonConvert.convert<String>(
      json['homeTeamName']);
  if (homeTeamName != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.homeTeamName = homeTeamName;
  }
  final String? homeTeamScore = jsonConvert.convert<String>(
      json['homeTeamScore']);
  if (homeTeamScore != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.homeTeamScore = homeTeamScore;
  }
  final double? matchGroup = jsonConvert.convert<double>(json['matchGroup']);
  if (matchGroup != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.matchGroup = matchGroup;
  }
  final String? overunderOdds = jsonConvert.convert<String>(
      json['overunderOdds']);
  if (overunderOdds != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.overunderOdds = overunderOdds;
  }
  final double? overunderResult = jsonConvert.convert<double>(
      json['overunderResult']);
  if (overunderResult != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.overunderResult = overunderResult;
  }
  final String? overunderVal = jsonConvert.convert<String>(
      json['overunderVal']);
  if (overunderVal != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.overunderVal = overunderVal;
  }
  final double? result = jsonConvert.convert<double>(json['result']);
  if (result != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.result = result;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.sportId = sportId;
  }
  final String? teamGroup = jsonConvert.convert<String>(json['teamGroup']);
  if (teamGroup != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.teamGroup = teamGroup;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.thirdMatchId = thirdMatchId;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.tournamentName = tournamentName;
  }
  final String? winnerOdds = jsonConvert.convert<String>(json['winnerOdds']);
  if (winnerOdds != null) {
    analyzeTeamVsOtherTeamItemEntityEntity.winnerOdds = winnerOdds;
  }
  return analyzeTeamVsOtherTeamItemEntityEntity;
}

Map<String, dynamic> $AnalyzeTeamVsOtherTeamItemEntityEntityToJson(
    AnalyzeTeamVsOtherTeamItemEntityEntity entity) {
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

extension AnalyzeTeamVsOtherTeamItemEntityEntityExtension on AnalyzeTeamVsOtherTeamItemEntityEntity {
  AnalyzeTeamVsOtherTeamItemEntityEntity copyWith({
    String? awayTeamId,
    String? awayTeamName,
    String? awayTeamScore,
    String? beginTime,
    String? boldTagName,
    String? handicapOdds,
    double? handicapResult,
    String? handicapVal,
    String? homeTeamId,
    String? homeTeamName,
    String? homeTeamScore,
    double? matchGroup,
    String? overunderOdds,
    double? overunderResult,
    String? overunderVal,
    double? result,
    String? sportId,
    String? teamGroup,
    String? thirdMatchId,
    String? tournamentName,
    String? winnerOdds,
  }) {
    return AnalyzeTeamVsOtherTeamItemEntityEntity()
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