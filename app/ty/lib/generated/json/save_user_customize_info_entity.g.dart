import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/save_user_customize_info_entity.dart';

SaveUserCustomizeInfoEntity $SaveUserCustomizeInfoEntityFromJson(
    Map<String, dynamic> json) {
  final SaveUserCustomizeInfoEntity saveUserCustomizeInfoEntity = SaveUserCustomizeInfoEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    saveUserCustomizeInfoEntity.code = code;
  }
  final String? data = jsonConvert.convert<String>(json['data']);
  if (data != null) {
    saveUserCustomizeInfoEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    saveUserCustomizeInfoEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    saveUserCustomizeInfoEntity.ts = ts;
  }
  return saveUserCustomizeInfoEntity;
}

Map<String, dynamic> $SaveUserCustomizeInfoEntityToJson(
    SaveUserCustomizeInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data;
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension SaveUserCustomizeInfoEntityExtension on SaveUserCustomizeInfoEntity {
  SaveUserCustomizeInfoEntity copyWith({
    String? code,
    String? data,
    String? msg,
    int? ts,
  }) {
    return SaveUserCustomizeInfoEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}