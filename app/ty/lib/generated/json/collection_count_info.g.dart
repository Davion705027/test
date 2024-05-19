import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/collection_count_info.dart';

CollectionCountInfo $CollectionCountInfoFromJson(Map<String, dynamic> json) {
  final CollectionCountInfo collectionCountInfo = CollectionCountInfo();
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    collectionCountInfo.count = count;
  }
  final String? field1 = jsonConvert.convert<String>(json['field1']);
  if (field1 != null) {
    collectionCountInfo.field1 = field1;
  }
  final String? field2 = jsonConvert.convert<String>(json['field2']);
  if (field2 != null) {
    collectionCountInfo.field2 = field2;
  }
  final String? field3 = jsonConvert.convert<String>(json['field3']);
  if (field3 != null) {
    collectionCountInfo.field3 = field3;
  }
  final dynamic menuId = json['menuId'];
  if (menuId != null) {
    collectionCountInfo.menuId = menuId;
  }
  final dynamic menuType = json['menuType'];
  if (menuType != null) {
    collectionCountInfo.menuType = menuType;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    collectionCountInfo.name = name;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    collectionCountInfo.sportId = sportId;
  }
  final dynamic subList = json['subList'];
  if (subList != null) {
    collectionCountInfo.subList = subList;
  }
  return collectionCountInfo;
}

Map<String, dynamic> $CollectionCountInfoToJson(CollectionCountInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['count'] = entity.count;
  data['field1'] = entity.field1;
  data['field2'] = entity.field2;
  data['field3'] = entity.field3;
  data['menuId'] = entity.menuId;
  data['menuType'] = entity.menuType;
  data['name'] = entity.name;
  data['sportId'] = entity.sportId;
  data['subList'] = entity.subList;
  return data;
}

extension CollectionCountInfoExtension on CollectionCountInfo {
  CollectionCountInfo copyWith({
    int? count,
    String? field1,
    String? field2,
    String? field3,
    dynamic menuId,
    dynamic menuType,
    String? name,
    String? sportId,
    dynamic subList,
  }) {
    return CollectionCountInfo()
      ..count = count ?? this.count
      ..field1 = field1 ?? this.field1
      ..field2 = field2 ?? this.field2
      ..field3 = field3 ?? this.field3
      ..menuId = menuId ?? this.menuId
      ..menuType = menuType ?? this.menuType
      ..name = name ?? this.name
      ..sportId = sportId ?? this.sportId
      ..subList = subList ?? this.subList;
  }
}