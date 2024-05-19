import 'dart:convert';

import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/vr_match_entity.g.dart';

export 'package:flutter_ty_app/generated/json/vr_match_entity.g.dart';

@JsonSerializable()
class VrMatchEntity {
  late String lod = '';
  late String mmp = '';
  late String no = '';
  late String batchNo = '';
  late List<MatchEntity> matchs = [];

  @JSONField(serialize: false, deserialize: false)
  bool isExpand = false;

  VrMatchEntity();

  factory VrMatchEntity.fromJson(Map<String, dynamic> json) =>
      $VrMatchEntityFromJson(json);

  Map<String, dynamic> toJson() => $VrMatchEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
