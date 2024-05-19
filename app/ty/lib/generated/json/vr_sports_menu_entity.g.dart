import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sports_menu_entity.dart';

VrSportsMenuEntity $VrSportsMenuEntityFromJson(Map<String, dynamic> json) {
  final VrSportsMenuEntity vrSportsMenuEntity = VrSportsMenuEntity();
  final dynamic count = json['count'];
  if (count != null) {
    vrSportsMenuEntity.count = count;
  }
  final String? field1 = jsonConvert.convert<String>(json['field1']);
  if (field1 != null) {
    vrSportsMenuEntity.field1 = field1;
  }
  final String? field2 = jsonConvert.convert<String>(json['field2']);
  if (field2 != null) {
    vrSportsMenuEntity.field2 = field2;
  }
  final String? field3 = jsonConvert.convert<String>(json['field3']);
  if (field3 != null) {
    vrSportsMenuEntity.field3 = field3;
  }
  final String? field4 = jsonConvert.convert<String>(json['field4']);
  if (field4 != null) {
    vrSportsMenuEntity.field4 = field4;
  }
  final String? menuId = jsonConvert.convert<String>(json['menuId']);
  if (menuId != null) {
    vrSportsMenuEntity.menuId = menuId;
  }
  final dynamic menuType = json['menuType'];
  if (menuType != null) {
    vrSportsMenuEntity.menuType = menuType;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    vrSportsMenuEntity.name = name;
  }
  final List<VrSportsMenuEntity>? subList = (json['subList'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<VrSportsMenuEntity>(e) as VrSportsMenuEntity)
      .toList();
  if (subList != null) {
    vrSportsMenuEntity.subList = subList;
  }
  return vrSportsMenuEntity;
}

Map<String, dynamic> $VrSportsMenuEntityToJson(VrSportsMenuEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['count'] = entity.count;
  data['field1'] = entity.field1;
  data['field2'] = entity.field2;
  data['field3'] = entity.field3;
  data['field4'] = entity.field4;
  data['menuId'] = entity.menuId;
  data['menuType'] = entity.menuType;
  data['name'] = entity.name;
  data['subList'] = entity.subList.map((v) => v.toJson()).toList();
  return data;
}

extension VrSportsMenuEntityExtension on VrSportsMenuEntity {
  VrSportsMenuEntity copyWith({
    dynamic count,
    String? field1,
    String? field2,
    String? field3,
    String? field4,
    String? menuId,
    dynamic menuType,
    String? name,
    List<VrSportsMenuEntity>? subList,
  }) {
    return VrSportsMenuEntity()
      ..count = count ?? this.count
      ..field1 = field1 ?? this.field1
      ..field2 = field2 ?? this.field2
      ..field3 = field3 ?? this.field3
      ..field4 = field4 ?? this.field4
      ..menuId = menuId ?? this.menuId
      ..menuType = menuType ?? this.menuType
      ..name = name ?? this.name
      ..subList = subList ?? this.subList;
  }
}