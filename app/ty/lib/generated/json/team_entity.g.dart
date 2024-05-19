import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/team_entity.dart';

TeamEntity $TeamEntityFromJson(Map<String, dynamic> json) {
  final TeamEntity teamEntity = TeamEntity();
  final dynamic lurl = json['lurl'];
  if (lurl != null) {
    teamEntity.lurl = lurl;
  }
  final dynamic tnjc = json['tnjc'];
  if (tnjc != null) {
    teamEntity.tnjc = tnjc;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    teamEntity.tn = tn;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    teamEntity.tid = tid;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    teamEntity.tlev = tlev;
  }
  return teamEntity;
}

Map<String, dynamic> $TeamEntityToJson(TeamEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['lurl'] = entity.lurl;
  data['tnjc'] = entity.tnjc;
  data['tn'] = entity.tn;
  data['tid'] = entity.tid;
  data['tlev'] = entity.tlev;
  return data;
}

extension TeamEntityExtension on TeamEntity {
  TeamEntity copyWith({
    dynamic lurl,
    dynamic tnjc,
    String? tn,
    String? tid,
    int? tlev,
  }) {
    return TeamEntity()
      ..lurl = lurl ?? this.lurl
      ..tnjc = tnjc ?? this.tnjc
      ..tn = tn ?? this.tn
      ..tid = tid ?? this.tid
      ..tlev = tlev ?? this.tlev;
  }
}