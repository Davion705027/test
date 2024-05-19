import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_date_entity_entity.dart';

DjDateEntityEntity $DjDateEntityEntityFromJson(Map<String, dynamic> json) {
  final DjDateEntityEntity djDateEntityEntity = DjDateEntityEntity();
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    djDateEntityEntity.count = count;
  }
  final String? field1 = jsonConvert.convert<String>(json['field1']);
  if (field1 != null) {
    djDateEntityEntity.field1 = field1;
  }
  final String? field2 = jsonConvert.convert<String>(json['field2']);
  if (field2 != null) {
    djDateEntityEntity.field2 = field2;
  }
  final String? menuId = jsonConvert.convert<String>(json['menuId']);
  if (menuId != null) {
    djDateEntityEntity.menuId = menuId;
  }
  final String? menuName = jsonConvert.convert<String>(json['menuName']);
  if (menuName != null) {
    djDateEntityEntity.menuName = menuName;
  }
  final dynamic menuType = json['menuType'];
  if (menuType != null) {
    djDateEntityEntity.menuType = menuType;
  }
  final dynamic subList = json['subList'];
  if (subList != null) {
    djDateEntityEntity.subList = subList;
  }
  return djDateEntityEntity;
}

Map<String, dynamic> $DjDateEntityEntityToJson(DjDateEntityEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['count'] = entity.count;
  data['field1'] = entity.field1;
  data['field2'] = entity.field2;
  data['menuId'] = entity.menuId;
  data['menuName'] = entity.menuName;
  data['menuType'] = entity.menuType;
  data['subList'] = entity.subList;
  return data;
}

extension DjDateEntityEntityExtension on DjDateEntityEntity {
  DjDateEntityEntity copyWith({
    int? count,
    String? field1,
    String? field2,
    String? menuId,
    String? menuName,
    dynamic menuType,
    dynamic subList,
  }) {
    return DjDateEntityEntity()
      ..count = count ?? this.count
      ..field1 = field1 ?? this.field1
      ..field2 = field2 ?? this.field2
      ..menuId = menuId ?? this.menuId
      ..menuName = menuName ?? this.menuName
      ..menuType = menuType ?? this.menuType
      ..subList = subList ?? this.subList;
  }
}