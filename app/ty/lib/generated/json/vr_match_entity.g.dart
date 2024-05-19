import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


VrMatchEntity $VrMatchEntityFromJson(Map<String, dynamic> json) {
  final VrMatchEntity vrMatchEntity = VrMatchEntity();
  final String? lod = jsonConvert.convert<String>(json['lod']);
  if (lod != null) {
    vrMatchEntity.lod = lod;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    vrMatchEntity.mmp = mmp;
  }
  final String? no = jsonConvert.convert<String>(json['no']);
  if (no != null) {
    vrMatchEntity.no = no;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    vrMatchEntity.batchNo = batchNo;
  }
  final List<MatchEntity>? matchs = (json['matchs'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MatchEntity>(e) as MatchEntity).toList();
  if (matchs != null) {
    vrMatchEntity.matchs = matchs;
  }
  return vrMatchEntity;
}

Map<String, dynamic> $VrMatchEntityToJson(VrMatchEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['lod'] = entity.lod;
  data['mmp'] = entity.mmp;
  data['no'] = entity.no;
  data['batchNo'] = entity.batchNo;
  data['matchs'] = entity.matchs.map((v) => v.toJson()).toList();
  return data;
}

extension VrMatchEntityExtension on VrMatchEntity {
  VrMatchEntity copyWith({
    String? lod,
    String? mmp,
    String? no,
    String? batchNo,
    List<MatchEntity>? matchs,
    bool? isExpand,
  }) {
    return VrMatchEntity()
      ..lod = lod ?? this.lod
      ..mmp = mmp ?? this.mmp
      ..no = no ?? this.no
      ..batchNo = batchNo ?? this.batchNo
      ..matchs = matchs ?? this.matchs
      ..isExpand = isExpand ?? this.isExpand;
  }
}