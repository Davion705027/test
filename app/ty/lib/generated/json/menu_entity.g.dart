import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/menu_entity.dart';

MenuEntity $MenuEntityFromJson(Map<String, dynamic> json) {
  final MenuEntity menuEntity = MenuEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    menuEntity.code = code;
  }
  final String? data = jsonConvert.convert<String>(json['data']);
  if (data != null) {
    menuEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    menuEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    menuEntity.ts = ts;
  }
  return menuEntity;
}

Map<String, dynamic> $MenuEntityToJson(MenuEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data;
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MenuEntityExtension on MenuEntity {
  MenuEntity copyWith({
    String? code,
    String? data,
    String? msg,
    int? ts,
  }) {
    return MenuEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}