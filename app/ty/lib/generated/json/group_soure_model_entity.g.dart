import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/group_soure_model_entity.dart';

GroupSoureModelEntity $GroupSoureModelEntityFromJson(
    Map<String, dynamic> json) {
  final GroupSoureModelEntity groupSoureModelEntity = GroupSoureModelEntity();
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    groupSoureModelEntity.status = status;
  }
  final GroupSoureModelData? data = jsonConvert.convert<GroupSoureModelData>(
      json['data']);
  if (data != null) {
    groupSoureModelEntity.data = data;
  }
  return groupSoureModelEntity;
}

Map<String, dynamic> $GroupSoureModelEntityToJson(
    GroupSoureModelEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data.toJson();
  return data;
}

extension GroupSoureModelEntityExtension on GroupSoureModelEntity {
  GroupSoureModelEntity copyWith({
    String? status,
    GroupSoureModelData? data,
  }) {
    return GroupSoureModelEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GroupSoureModelData $GroupSoureModelDataFromJson(Map<String, dynamic> json) {
  final GroupSoureModelData groupSoureModelData = GroupSoureModelData();
  final List<
      GroupSoureModelDataGroupData>? groupData = (json['group_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GroupSoureModelDataGroupData>(
          e) as GroupSoureModelDataGroupData).toList();
  if (groupData != null) {
    groupSoureModelData.groupData = groupData;
  }
  final int? isDisuse = jsonConvert.convert<int>(json['is_disuse']);
  if (isDisuse != null) {
    groupSoureModelData.isDisuse = isDisuse;
  }
  return groupSoureModelData;
}

Map<String, dynamic> $GroupSoureModelDataToJson(GroupSoureModelData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['group_data'] = entity.groupData.map((v) => v.toJson()).toList();
  data['is_disuse'] = entity.isDisuse;
  return data;
}

extension GroupSoureModelDataExtension on GroupSoureModelData {
  GroupSoureModelData copyWith({
    List<GroupSoureModelDataGroupData>? groupData,
    int? isDisuse,
  }) {
    return GroupSoureModelData()
      ..groupData = groupData ?? this.groupData
      ..isDisuse = isDisuse ?? this.isDisuse;
  }
}

GroupSoureModelDataGroupData $GroupSoureModelDataGroupDataFromJson(
    Map<String, dynamic> json) {
  final GroupSoureModelDataGroupData groupSoureModelDataGroupData = GroupSoureModelDataGroupData();
  final String? groupId = jsonConvert.convert<String>(json['groupId']);
  if (groupId != null) {
    groupSoureModelDataGroupData.groupId = groupId;
  }
  final List<
      GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList>? sVirtualSportXZTeamRankingDetailPOList = (json['sVirtualSportXZTeamRankingDetailPOList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList>(
          e) as GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList)
      .toList();
  if (sVirtualSportXZTeamRankingDetailPOList != null) {
    groupSoureModelDataGroupData.sVirtualSportXZTeamRankingDetailPOList =
        sVirtualSportXZTeamRankingDetailPOList;
  }
  return groupSoureModelDataGroupData;
}

Map<String, dynamic> $GroupSoureModelDataGroupDataToJson(
    GroupSoureModelDataGroupData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['groupId'] = entity.groupId;
  data['sVirtualSportXZTeamRankingDetailPOList'] =
      entity.sVirtualSportXZTeamRankingDetailPOList.map((v) => v.toJson())
          .toList();
  return data;
}

extension GroupSoureModelDataGroupDataExtension on GroupSoureModelDataGroupData {
  GroupSoureModelDataGroupData copyWith({
    String? groupId,
    List<
        GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList>? sVirtualSportXZTeamRankingDetailPOList,
  }) {
    return GroupSoureModelDataGroupData()
      ..groupId = groupId ?? this.groupId
      ..sVirtualSportXZTeamRankingDetailPOList = sVirtualSportXZTeamRankingDetailPOList ??
          this.sVirtualSportXZTeamRankingDetailPOList;
  }
}

GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList $GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOListFromJson(
    Map<String, dynamic> json) {
  final GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList = GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList();
  final int? draw = jsonConvert.convert<int>(json['draw']);
  if (draw != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList.draw =
        draw;
  }
  final int? goalsConceded = jsonConvert.convert<int>(json['goalsConceded']);
  if (goalsConceded != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList
        .goalsConceded = goalsConceded;
  }
  final int? goalsScored = jsonConvert.convert<int>(json['goalsScored']);
  if (goalsScored != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList
        .goalsScored = goalsScored;
  }
  final int? goalsWinning = jsonConvert.convert<int>(json['goalsWinning']);
  if (goalsWinning != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList
        .goalsWinning = goalsWinning;
  }
  final int? lost = jsonConvert.convert<int>(json['lost']);
  if (lost != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList.lost =
        lost;
  }
  final int? points = jsonConvert.convert<int>(json['points']);
  if (points != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList.points =
        points;
  }
  final int? ranking = jsonConvert.convert<int>(json['ranking']);
  if (ranking != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList.ranking =
        ranking;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList.tid =
        tid;
  }
  final int? totalCount = jsonConvert.convert<int>(json['totalCount']);
  if (totalCount != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList
        .totalCount = totalCount;
  }
  final String? virtualTeamId = jsonConvert.convert<String>(
      json['virtualTeamId']);
  if (virtualTeamId != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList
        .virtualTeamId = virtualTeamId;
  }
  final String? virtualTeamName = jsonConvert.convert<String>(
      json['virtualTeamName']);
  if (virtualTeamName != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList
        .virtualTeamName = virtualTeamName;
  }
  final int? win = jsonConvert.convert<int>(json['win']);
  if (win != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList.win =
        win;
  }
  final String? winDrawLostDescription = jsonConvert.convert<String>(
      json['winDrawLostDescription']);
  if (winDrawLostDescription != null) {
    groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList
        .winDrawLostDescription = winDrawLostDescription;
  }
  return groupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList;
}

Map<String,
    dynamic> $GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOListToJson(
    GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['draw'] = entity.draw;
  data['goalsConceded'] = entity.goalsConceded;
  data['goalsScored'] = entity.goalsScored;
  data['goalsWinning'] = entity.goalsWinning;
  data['lost'] = entity.lost;
  data['points'] = entity.points;
  data['ranking'] = entity.ranking;
  data['tid'] = entity.tid;
  data['totalCount'] = entity.totalCount;
  data['virtualTeamId'] = entity.virtualTeamId;
  data['virtualTeamName'] = entity.virtualTeamName;
  data['win'] = entity.win;
  data['winDrawLostDescription'] = entity.winDrawLostDescription;
  return data;
}

extension GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOListExtension on GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList {
  GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList copyWith({
    int? draw,
    int? goalsConceded,
    int? goalsScored,
    int? goalsWinning,
    int? lost,
    int? points,
    int? ranking,
    String? tid,
    int? totalCount,
    String? virtualTeamId,
    String? virtualTeamName,
    int? win,
    String? winDrawLostDescription,
  }) {
    return GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList()
      ..draw = draw ?? this.draw
      ..goalsConceded = goalsConceded ?? this.goalsConceded
      ..goalsScored = goalsScored ?? this.goalsScored
      ..goalsWinning = goalsWinning ?? this.goalsWinning
      ..lost = lost ?? this.lost
      ..points = points ?? this.points
      ..ranking = ranking ?? this.ranking
      ..tid = tid ?? this.tid
      ..totalCount = totalCount ?? this.totalCount
      ..virtualTeamId = virtualTeamId ?? this.virtualTeamId
      ..virtualTeamName = virtualTeamName ?? this.virtualTeamName
      ..win = win ?? this.win
      ..winDrawLostDescription = winDrawLostDescription ??
          this.winDrawLostDescription;
  }
}