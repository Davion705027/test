import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/common_score_model_entity.dart';

CommonScoreModelEntity $CommonScoreModelEntityFromJson(
    Map<String, dynamic> json) {
  final CommonScoreModelEntity commonScoreModelEntity = CommonScoreModelEntity();
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    commonScoreModelEntity.status = status;
  }
  final List<CommonScoreModelData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<CommonScoreModelData>(e) as CommonScoreModelData)
      .toList();
  if (data != null) {
    commonScoreModelEntity.data = data;
  }
  return commonScoreModelEntity;
}

Map<String, dynamic> $CommonScoreModelEntityToJson(
    CommonScoreModelEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

extension CommonScoreModelEntityExtension on CommonScoreModelEntity {
  CommonScoreModelEntity copyWith({
    String? status,
    List<CommonScoreModelData>? data,
  }) {
    return CommonScoreModelEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

CommonScoreModelData $CommonScoreModelDataFromJson(Map<String, dynamic> json) {
  final CommonScoreModelData commonScoreModelData = CommonScoreModelData();
  final int? draw = jsonConvert.convert<int>(json['draw']);
  if (draw != null) {
    commonScoreModelData.draw = draw;
  }
  final String? history = jsonConvert.convert<String>(json['history']);
  if (history != null) {
    commonScoreModelData.history = history;
  }
  final int? lost = jsonConvert.convert<int>(json['lost']);
  if (lost != null) {
    commonScoreModelData.lost = lost;
  }
  final int? points = jsonConvert.convert<int>(json['points']);
  if (points != null) {
    commonScoreModelData.points = points;
  }
  final int? ranking = jsonConvert.convert<int>(json['ranking']);
  if (ranking != null) {
    commonScoreModelData.ranking = ranking;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    commonScoreModelData.tid = tid;
  }
  final int? totalCount = jsonConvert.convert<int>(json['totalCount']);
  if (totalCount != null) {
    commonScoreModelData.totalCount = totalCount;
  }
  final String? virtualTeamId = jsonConvert.convert<String>(
      json['virtualTeamId']);
  if (virtualTeamId != null) {
    commonScoreModelData.virtualTeamId = virtualTeamId;
  }
  final String? virtualTeamName = jsonConvert.convert<String>(
      json['virtualTeamName']);
  if (virtualTeamName != null) {
    commonScoreModelData.virtualTeamName = virtualTeamName;
  }
  final int? win = jsonConvert.convert<int>(json['win']);
  if (win != null) {
    commonScoreModelData.win = win;
  }
  final String? winDrawLostDescription = jsonConvert.convert<String>(
      json['winDrawLostDescription']);
  if (winDrawLostDescription != null) {
    commonScoreModelData.winDrawLostDescription = winDrawLostDescription;
  }
  return commonScoreModelData;
}

Map<String, dynamic> $CommonScoreModelDataToJson(CommonScoreModelData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['draw'] = entity.draw;
  data['history'] = entity.history;
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

extension CommonScoreModelDataExtension on CommonScoreModelData {
  CommonScoreModelData copyWith({
    int? draw,
    String? history,
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
    return CommonScoreModelData()
      ..draw = draw ?? this.draw
      ..history = history ?? this.history
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