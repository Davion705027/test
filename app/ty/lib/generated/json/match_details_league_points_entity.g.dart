import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_details_league_points_entity.dart';

MatchDetailsLeaguePointsEntity $MatchDetailsLeaguePointsEntityFromJson(
    Map<String, dynamic> json) {
  final MatchDetailsLeaguePointsEntity matchDetailsLeaguePointsEntity = MatchDetailsLeaguePointsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matchDetailsLeaguePointsEntity.code = code;
  }
  final List<MatchDetailsLeaguePointsData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MatchDetailsLeaguePointsData>(
          e) as MatchDetailsLeaguePointsData).toList();
  if (data != null) {
    matchDetailsLeaguePointsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matchDetailsLeaguePointsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matchDetailsLeaguePointsEntity.ts = ts;
  }
  return matchDetailsLeaguePointsEntity;
}

Map<String, dynamic> $MatchDetailsLeaguePointsEntityToJson(
    MatchDetailsLeaguePointsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatchDetailsLeaguePointsEntityExtension on MatchDetailsLeaguePointsEntity {
  MatchDetailsLeaguePointsEntity copyWith({
    String? code,
    List<MatchDetailsLeaguePointsData>? data,
    String? msg,
    int? ts,
  }) {
    return MatchDetailsLeaguePointsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatchDetailsLeaguePointsData $MatchDetailsLeaguePointsDataFromJson(
    Map<String, dynamic> json) {
  final MatchDetailsLeaguePointsData matchDetailsLeaguePointsData = MatchDetailsLeaguePointsData();
  final int? drawTotal = jsonConvert.convert<int>(json['drawTotal']);
  if (drawTotal != null) {
    matchDetailsLeaguePointsData.drawTotal = drawTotal;
  }
  final int? goalDiffTotal = jsonConvert.convert<int>(json['goalDiffTotal']);
  if (goalDiffTotal != null) {
    matchDetailsLeaguePointsData.goalDiffTotal = goalDiffTotal;
  }
  final int? goalsAgainstTotal = jsonConvert.convert<int>(
      json['goalsAgainstTotal']);
  if (goalsAgainstTotal != null) {
    matchDetailsLeaguePointsData.goalsAgainstTotal = goalsAgainstTotal;
  }
  final int? goalsForTotal = jsonConvert.convert<int>(json['goalsForTotal']);
  if (goalsForTotal != null) {
    matchDetailsLeaguePointsData.goalsForTotal = goalsForTotal;
  }
  final int? lossTotal = jsonConvert.convert<int>(json['lossTotal']);
  if (lossTotal != null) {
    matchDetailsLeaguePointsData.lossTotal = lossTotal;
  }
  final int? matchCount = jsonConvert.convert<int>(json['matchCount']);
  if (matchCount != null) {
    matchDetailsLeaguePointsData.matchCount = matchCount;
  }
  final int? matchGroup = jsonConvert.convert<int>(json['matchGroup']);
  if (matchGroup != null) {
    matchDetailsLeaguePointsData.matchGroup = matchGroup;
  }
  final int? pointsTotal = jsonConvert.convert<int>(json['pointsTotal']);
  if (pointsTotal != null) {
    matchDetailsLeaguePointsData.pointsTotal = pointsTotal;
  }
  final int? positionTotal = jsonConvert.convert<int>(json['positionTotal']);
  if (positionTotal != null) {
    matchDetailsLeaguePointsData.positionTotal = positionTotal;
  }
  final String? teamFlag = jsonConvert.convert<String>(json['teamFlag']);
  if (teamFlag != null) {
    matchDetailsLeaguePointsData.teamFlag = teamFlag;
  }
  final String? teamLogo = jsonConvert.convert<String>(json['teamLogo']);
  if (teamLogo != null) {
    matchDetailsLeaguePointsData.teamLogo = teamLogo;
  }
  final String? teamName = jsonConvert.convert<String>(json['teamName']);
  if (teamName != null) {
    matchDetailsLeaguePointsData.teamName = teamName;
  }
  final String? thirdTeamSourceId = jsonConvert.convert<String>(
      json['thirdTeamSourceId']);
  if (thirdTeamSourceId != null) {
    matchDetailsLeaguePointsData.thirdTeamSourceId = thirdTeamSourceId;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    matchDetailsLeaguePointsData.tournamentName = tournamentName;
  }
  final int? tournamentType = jsonConvert.convert<int>(json['tournamentType']);
  if (tournamentType != null) {
    matchDetailsLeaguePointsData.tournamentType = tournamentType;
  }
  final int? winTotal = jsonConvert.convert<int>(json['winTotal']);
  if (winTotal != null) {
    matchDetailsLeaguePointsData.winTotal = winTotal;
  }
  return matchDetailsLeaguePointsData;
}

Map<String, dynamic> $MatchDetailsLeaguePointsDataToJson(
    MatchDetailsLeaguePointsData entity) {
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

extension MatchDetailsLeaguePointsDataExtension on MatchDetailsLeaguePointsData {
  MatchDetailsLeaguePointsData copyWith({
    int? drawTotal,
    int? goalDiffTotal,
    int? goalsAgainstTotal,
    int? goalsForTotal,
    int? lossTotal,
    int? matchCount,
    int? matchGroup,
    int? pointsTotal,
    int? positionTotal,
    String? teamFlag,
    String? teamLogo,
    String? teamName,
    String? thirdTeamSourceId,
    String? tournamentName,
    int? tournamentType,
    int? winTotal,
  }) {
    return MatchDetailsLeaguePointsData()
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