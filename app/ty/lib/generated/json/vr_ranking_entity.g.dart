import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_ranking_entity.dart';

VrRankingEntity $VrRankingEntityFromJson(Map<String, dynamic> json) {
  final VrRankingEntity vrRankingEntity = VrRankingEntity();
  final int? draw = jsonConvert.convert<int>(json['draw']);
  if (draw != null) {
    vrRankingEntity.draw = draw;
  }
  final String? history = jsonConvert.convert<String>(json['history']);
  if (history != null) {
    vrRankingEntity.history = history;
  }
  final int? lost = jsonConvert.convert<int>(json['lost']);
  if (lost != null) {
    vrRankingEntity.lost = lost;
  }
  final int? points = jsonConvert.convert<int>(json['points']);
  if (points != null) {
    vrRankingEntity.points = points;
  }
  final int? ranking = jsonConvert.convert<int>(json['ranking']);
  if (ranking != null) {
    vrRankingEntity.ranking = ranking;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    vrRankingEntity.tid = tid;
  }
  final int? totalCount = jsonConvert.convert<int>(json['totalCount']);
  if (totalCount != null) {
    vrRankingEntity.totalCount = totalCount;
  }
  final String? virtualTeamId = jsonConvert.convert<String>(
      json['virtualTeamId']);
  if (virtualTeamId != null) {
    vrRankingEntity.virtualTeamId = virtualTeamId;
  }
  final String? virtualTeamName = jsonConvert.convert<String>(
      json['virtualTeamName']);
  if (virtualTeamName != null) {
    vrRankingEntity.virtualTeamName = virtualTeamName;
  }
  final int? win = jsonConvert.convert<int>(json['win']);
  if (win != null) {
    vrRankingEntity.win = win;
  }
  final String? winDrawLostDescription = jsonConvert.convert<String>(
      json['winDrawLostDescription']);
  if (winDrawLostDescription != null) {
    vrRankingEntity.winDrawLostDescription = winDrawLostDescription;
  }
  return vrRankingEntity;
}

Map<String, dynamic> $VrRankingEntityToJson(VrRankingEntity entity) {
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

extension VrRankingEntityExtension on VrRankingEntity {
  VrRankingEntity copyWith({
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
    return VrRankingEntity()
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