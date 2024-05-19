import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/team_entity.dart';
import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'dart:convert';

import 'package:flutter_ty_app/generated/json/origin_data_entity.g.dart';

@JsonSerializable()
class OriginDataEntity {
  late List<SportEntity> spList = [];
  @JSONField(name: "tids_obj")
  late List<TeamEntity> tidsObj = [];
  late List<MatchEntity> matchsList = [];
  late Map<String, String> menus;

  OriginDataEntity();

  factory OriginDataEntity.fromJson(Map<String, dynamic> json) =>
      $OriginDataEntityFromJson(json);

  /// from string
  factory OriginDataEntity.fromJsonString(String json) =>
      $OriginDataEntityFromJson(jsonDecode(json));

  Map<String, dynamic> toJson() => $OriginDataEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
