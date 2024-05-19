import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';
import 'dart:collection';


SportConfigInfo $SportConfigInfoFromJson(Map<String, dynamic> json) {
  final SportConfigInfo sportConfigInfo = SportConfigInfo();
  final int? ct = jsonConvert.convert<int>(json['ct']);
  if (ct != null) {
    sportConfigInfo.ct = ct;
  }
  final int? hl = jsonConvert.convert<int>(json['hl']);
  if (hl != null) {
    sportConfigInfo.hl = hl;
  }
  final String? mi = jsonConvert.convert<String>(json['mi']);
  if (mi != null) {
    sportConfigInfo.mi = mi;
  }
  final List<SportConfigInfo>? sl = (json['sl'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<SportConfigInfo>(e) as SportConfigInfo)
      .toList();
  if (sl != null) {
    sportConfigInfo.sl = sl;
  }
  final int? st = jsonConvert.convert<int>(json['st']);
  if (st != null) {
    sportConfigInfo.st = st;
  }
  return sportConfigInfo;
}

Map<String, dynamic> $SportConfigInfoToJson(SportConfigInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ct'] = entity.ct;
  data['hl'] = entity.hl;
  data['mi'] = entity.mi;
  data['sl'] = entity.sl?.map((v) => v.toJson()).toList();
  data['st'] = entity.st;
  return data;
}

extension SportConfigInfoExtension on SportConfigInfo {
  SportConfigInfo copyWith({
    int? ct,
    int? hl,
    String? mi,
    List<SportConfigInfo>? sl,
    int? st,
  }) {
    return SportConfigInfo()
      ..ct = ct ?? this.ct
      ..hl = hl ?? this.hl
      ..mi = mi ?? this.mi
      ..sl = sl ?? this.sl
      ..st = st ?? this.st;
  }
}