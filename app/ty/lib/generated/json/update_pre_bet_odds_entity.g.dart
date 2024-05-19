import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/update_pre_bet_odds_entity.dart';

UpdatePreBetOddsEntity $UpdatePreBetOddsEntityFromJson(
    Map<String, dynamic> json) {
  final UpdatePreBetOddsEntity updatePreBetOddsEntity = UpdatePreBetOddsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    updatePreBetOddsEntity.code = code;
  }
  final dynamic data = json['data'];
  if (data != null) {
    updatePreBetOddsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    updatePreBetOddsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    updatePreBetOddsEntity.ts = ts;
  }
  return updatePreBetOddsEntity;
}

Map<String, dynamic> $UpdatePreBetOddsEntityToJson(
    UpdatePreBetOddsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data;
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension UpdatePreBetOddsEntityExtension on UpdatePreBetOddsEntity {
  UpdatePreBetOddsEntity copyWith({
    String? code,
    dynamic data,
    String? msg,
    int? ts,
  }) {
    return UpdatePreBetOddsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}