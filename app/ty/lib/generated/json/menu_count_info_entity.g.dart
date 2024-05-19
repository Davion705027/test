import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/menu_count_info_entity.dart';

MenuCountInfoEntity $MenuCountInfoEntityFromJson(Map<String, dynamic> json) {
  final MenuCountInfoEntity menuCountInfoEntity = MenuCountInfoEntity();
  final bool? containLive = jsonConvert.convert<bool>(json['containLive']);
  if (containLive != null) {
    menuCountInfoEntity.containLive = containLive;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    menuCountInfoEntity.count = count;
  }
  final int? menuId = jsonConvert.convert<int>(json['menuId']);
  if (menuId != null) {
    menuCountInfoEntity.menuId = menuId;
  }
  final int? sys = jsonConvert.convert<int>(json['sys']);
  if (sys != null) {
    menuCountInfoEntity.sys = sys;
  }
  return menuCountInfoEntity;
}

Map<String, dynamic> $MenuCountInfoEntityToJson(MenuCountInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['containLive'] = entity.containLive;
  data['count'] = entity.count;
  data['menuId'] = entity.menuId;
  data['sys'] = entity.sys;
  return data;
}

extension MenuCountInfoEntityExtension on MenuCountInfoEntity {
  MenuCountInfoEntity copyWith({
    bool? containLive,
    int? count,
    int? menuId,
    int? sys,
  }) {
    return MenuCountInfoEntity()
      ..containLive = containLive ?? this.containLive
      ..count = count ?? this.count
      ..menuId = menuId ?? this.menuId
      ..sys = sys ?? this.sys;
  }
}