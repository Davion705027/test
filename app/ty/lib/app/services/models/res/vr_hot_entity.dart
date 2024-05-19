import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/vr_hot_entity.g.dart';
import 'dart:convert';

export 'package:flutter_ty_app/generated/json/vr_hot_entity.g.dart';
/// vr热门投注
@JsonSerializable()
class VrHotEntity {
  late String hotName;
  late List<MatchHps> plays = [];
  late List<VrHotTeam> team = [];

  VrHotEntity();

  factory VrHotEntity.fromJson(Map<String, dynamic> json) =>
      $VrHotEntityFromJson(json);

  Map<String, dynamic> toJson() => $VrHotEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VrHotTeam {
  late String teamName;
  late String teamId;

  VrHotTeam();

  factory VrHotTeam.fromJson(Map<String, dynamic> json) =>
      $VrHotTeamFromJson(json);

  Map<String, dynamic> toJson() => $VrHotTeamToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
