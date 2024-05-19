import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_entity.dart';

SportEntity $SportEntityFromJson(Map<String, dynamic> json) {
  final SportEntity sportEntity = SportEntity();
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    sportEntity.csid = csid;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    sportEntity.csna = csna;
  }
  return sportEntity;
}

Map<String, dynamic> $SportEntityToJson(SportEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['csid'] = entity.csid;
  data['csna'] = entity.csna;
  return data;
}

extension SportEntityExtension on SportEntity {
  SportEntity copyWith({
    String? csid,
    String? csna,
  }) {
    return SportEntity()
      ..csid = csid ?? this.csid
      ..csna = csna ?? this.csna;
  }
}