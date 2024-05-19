import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/detail_video_entity.dart';

DetailVideoEntity $DetailVideoEntityFromJson(Map<String, dynamic> json) {
  final DetailVideoEntity detailVideoEntity = DetailVideoEntity();
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    detailVideoEntity.csid = csid;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    detailVideoEntity.mid = mid;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    detailVideoEntity.tid = tid;
  }
  return detailVideoEntity;
}

Map<String, dynamic> $DetailVideoEntityToJson(DetailVideoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['csid'] = entity.csid;
  data['mid'] = entity.mid;
  data['tid'] = entity.tid;
  return data;
}

extension DetailVideoEntityExtension on DetailVideoEntity {
  DetailVideoEntity copyWith({
    String? csid,
    String? mid,
    String? tid,
  }) {
    return DetailVideoEntity()
      ..csid = csid ?? this.csid
      ..mid = mid ?? this.mid
      ..tid = tid ?? this.tid;
  }
}