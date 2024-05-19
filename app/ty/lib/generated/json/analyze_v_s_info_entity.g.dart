import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/api/analyze_v_s_info_entity.dart';

AnalyzeVSInfoEntity $AnalyzeVSInfoEntityFromJson(Map<String, dynamic> json) {
  final AnalyzeVSInfoEntity analyzeVSInfoEntity = AnalyzeVSInfoEntity();
  final num? drawTotal = jsonConvert.convert<num>(json['drawTotal']);
  if (drawTotal != null) {
    analyzeVSInfoEntity.drawTotal = drawTotal;
  }
  final num? goalDiffTotal = jsonConvert.convert<num>(json['goalDiffTotal']);
  if (goalDiffTotal != null) {
    analyzeVSInfoEntity.goalDiffTotal = goalDiffTotal;
  }
  final num? goalsAgainstTotal = jsonConvert.convert<num>(
      json['goalsAgainstTotal']);
  if (goalsAgainstTotal != null) {
    analyzeVSInfoEntity.goalsAgainstTotal = goalsAgainstTotal;
  }
  final num? goalsForTotal = jsonConvert.convert<num>(json['goalsForTotal']);
  if (goalsForTotal != null) {
    analyzeVSInfoEntity.goalsForTotal = goalsForTotal;
  }
  final num? lossTotal = jsonConvert.convert<num>(json['lossTotal']);
  if (lossTotal != null) {
    analyzeVSInfoEntity.lossTotal = lossTotal;
  }
  final num? matchCount = jsonConvert.convert<num>(json['matchCount']);
  if (matchCount != null) {
    analyzeVSInfoEntity.matchCount = matchCount;
  }
  final num? matchGroup = jsonConvert.convert<num>(json['matchGroup']);
  if (matchGroup != null) {
    analyzeVSInfoEntity.matchGroup = matchGroup;
  }
  final num? pointsTotal = jsonConvert.convert<num>(json['pointsTotal']);
  if (pointsTotal != null) {
    analyzeVSInfoEntity.pointsTotal = pointsTotal;
  }
  final num? positionTotal = jsonConvert.convert<num>(json['positionTotal']);
  if (positionTotal != null) {
    analyzeVSInfoEntity.positionTotal = positionTotal;
  }
  final String? teamFlag = jsonConvert.convert<String>(json['teamFlag']);
  if (teamFlag != null) {
    analyzeVSInfoEntity.teamFlag = teamFlag;
  }
  final String? teamLogo = jsonConvert.convert<String>(json['teamLogo']);
  if (teamLogo != null) {
    analyzeVSInfoEntity.teamLogo = teamLogo;
  }
  final String? teamName = jsonConvert.convert<String>(json['teamName']);
  if (teamName != null) {
    analyzeVSInfoEntity.teamName = teamName;
  }
  final String? thirdTeamSourceId = jsonConvert.convert<String>(
      json['thirdTeamSourceId']);
  if (thirdTeamSourceId != null) {
    analyzeVSInfoEntity.thirdTeamSourceId = thirdTeamSourceId;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    analyzeVSInfoEntity.tournamentName = tournamentName;
  }
  final num? tournamentType = jsonConvert.convert<num>(json['tournamentType']);
  if (tournamentType != null) {
    analyzeVSInfoEntity.tournamentType = tournamentType;
  }
  final num? winTotal = jsonConvert.convert<num>(json['winTotal']);
  if (winTotal != null) {
    analyzeVSInfoEntity.winTotal = winTotal;
  }
  return analyzeVSInfoEntity;
}

Map<String, dynamic> $AnalyzeVSInfoEntityToJson(AnalyzeVSInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['drawTotal'] = entity.drawTotal;
  data['goalDiffTotal'] = entity.goalDiffTotal;
  data['goalsAgainstTotal'] = entity.goalsAgainstTotal;
  data['goalsForTotal'] = entity.goalsForTotal;
  data['lossTotal'] = entity.lossTotal;
  data['matchCount'] = entity.matchCount;
  data['matchGroup'] = entity.matchGroup;
  data['pointsTotal'] = entity.pointsTotal;
  data['positionTotal'] = entity.positionTotal;
  data['teamFlag'] = entity.teamFlag;
  data['teamLogo'] = entity.teamLogo;
  data['teamName'] = entity.teamName;
  data['thirdTeamSourceId'] = entity.thirdTeamSourceId;
  data['tournamentName'] = entity.tournamentName;
  data['tournamentType'] = entity.tournamentType;
  data['winTotal'] = entity.winTotal;
  return data;
}

extension AnalyzeVSInfoEntityExtension on AnalyzeVSInfoEntity {
  AnalyzeVSInfoEntity copyWith({
    num? drawTotal,
    num? goalDiffTotal,
    num? goalsAgainstTotal,
    num? goalsForTotal,
    num? lossTotal,
    num? matchCount,
    num? matchGroup,
    num? pointsTotal,
    num? positionTotal,
    String? teamFlag,
    String? teamLogo,
    String? teamName,
    String? thirdTeamSourceId,
    String? tournamentName,
    num? tournamentType,
    num? winTotal,
  }) {
    return AnalyzeVSInfoEntity()
      ..drawTotal = drawTotal ?? this.drawTotal
      ..goalDiffTotal = goalDiffTotal ?? this.goalDiffTotal
      ..goalsAgainstTotal = goalsAgainstTotal ?? this.goalsAgainstTotal
      ..goalsForTotal = goalsForTotal ?? this.goalsForTotal
      ..lossTotal = lossTotal ?? this.lossTotal
      ..matchCount = matchCount ?? this.matchCount
      ..matchGroup = matchGroup ?? this.matchGroup
      ..pointsTotal = pointsTotal ?? this.pointsTotal
      ..positionTotal = positionTotal ?? this.positionTotal
      ..teamFlag = teamFlag ?? this.teamFlag
      ..teamLogo = teamLogo ?? this.teamLogo
      ..teamName = teamName ?? this.teamName
      ..thirdTeamSourceId = thirdTeamSourceId ?? this.thirdTeamSourceId
      ..tournamentName = tournamentName ?? this.tournamentName
      ..tournamentType = tournamentType ?? this.tournamentType
      ..winTotal = winTotal ?? this.winTotal;
  }
}