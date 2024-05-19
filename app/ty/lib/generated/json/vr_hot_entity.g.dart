import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_hot_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


VrHotEntity $VrHotEntityFromJson(Map<String, dynamic> json) {
  final VrHotEntity vrHotEntity = VrHotEntity();
  final String? hotName = jsonConvert.convert<String>(json['hotName']);
  if (hotName != null) {
    vrHotEntity.hotName = hotName;
  }
  final List<MatchHps>? plays = (json['plays'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MatchHps>(e) as MatchHps).toList();
  if (plays != null) {
    vrHotEntity.plays = plays;
  }
  final List<VrHotTeam>? team = (json['team'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<VrHotTeam>(e) as VrHotTeam).toList();
  if (team != null) {
    vrHotEntity.team = team;
  }
  return vrHotEntity;
}

Map<String, dynamic> $VrHotEntityToJson(VrHotEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hotName'] = entity.hotName;
  data['plays'] = entity.plays.map((v) => v.toJson()).toList();
  data['team'] = entity.team.map((v) => v.toJson()).toList();
  return data;
}

extension VrHotEntityExtension on VrHotEntity {
  VrHotEntity copyWith({
    String? hotName,
    List<MatchHps>? plays,
    List<VrHotTeam>? team,
  }) {
    return VrHotEntity()
      ..hotName = hotName ?? this.hotName
      ..plays = plays ?? this.plays
      ..team = team ?? this.team;
  }
}

VrHotTeam $VrHotTeamFromJson(Map<String, dynamic> json) {
  final VrHotTeam vrHotTeam = VrHotTeam();
  final String? teamName = jsonConvert.convert<String>(json['teamName']);
  if (teamName != null) {
    vrHotTeam.teamName = teamName;
  }
  final String? teamId = jsonConvert.convert<String>(json['teamId']);
  if (teamId != null) {
    vrHotTeam.teamId = teamId;
  }
  return vrHotTeam;
}

Map<String, dynamic> $VrHotTeamToJson(VrHotTeam entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['teamName'] = entity.teamName;
  data['teamId'] = entity.teamId;
  return data;
}

extension VrHotTeamExtension on VrHotTeam {
  VrHotTeam copyWith({
    String? teamName,
    String? teamId,
  }) {
    return VrHotTeam()
      ..teamName = teamName ?? this.teamName
      ..teamId = teamId ?? this.teamId;
  }
}