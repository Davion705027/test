import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/origin_data_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import 'package:flutter_ty_app/app/services/models/res/sport_entity.dart';

import 'package:flutter_ty_app/app/services/models/res/team_entity.dart';


OriginDataEntity $OriginDataEntityFromJson(Map<String, dynamic> json) {
  final OriginDataEntity originDataEntity = OriginDataEntity();
  final List<SportEntity>? spList = (json['spList'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<SportEntity>(e) as SportEntity).toList();
  if (spList != null) {
    originDataEntity.spList = spList;
  }
  final List<TeamEntity>? tidsObj = (json['tids_obj'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<TeamEntity>(e) as TeamEntity).toList();
  if (tidsObj != null) {
    originDataEntity.tidsObj = tidsObj;
  }
  final List<MatchEntity>? matchsList = (json['matchsList'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<MatchEntity>(e) as MatchEntity)
      .toList();
  if (matchsList != null) {
    originDataEntity.matchsList = matchsList;
  }
  final Map<String, String>? menus =
  (json['menus'] as Map<String, dynamic>).map(
          (k, e) => MapEntry(k, jsonConvert.convert<String>(e) as String));
  if (menus != null) {
    originDataEntity.menus = menus;
  }
  return originDataEntity;
}

Map<String, dynamic> $OriginDataEntityToJson(OriginDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['spList'] = entity.spList.map((v) => v.toJson()).toList();
  data['tids_obj'] = entity.tidsObj.map((v) => v.toJson()).toList();
  data['matchsList'] = entity.matchsList.map((v) => v.toJson()).toList();
  data['menus'] = entity.menus;
  return data;
}

extension OriginDataEntityExtension on OriginDataEntity {
  OriginDataEntity copyWith({
    List<SportEntity>? spList,
    List<TeamEntity>? tidsObj,
    List<MatchEntity>? matchsList,
    Map<String, String>? menus,
  }) {
    return OriginDataEntity()
      ..spList = spList ?? this.spList
      ..tidsObj = tidsObj ?? this.tidsObj
      ..matchsList = matchsList ?? this.matchsList
      ..menus = menus ?? this.menus;
  }
}