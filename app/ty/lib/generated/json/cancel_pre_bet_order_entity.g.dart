import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/cancel_pre_bet_order_entity.dart';

CancelPreBetOrderEntity $CancelPreBetOrderEntityFromJson(
    Map<String, dynamic> json) {
  final CancelPreBetOrderEntity cancelPreBetOrderEntity = CancelPreBetOrderEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    cancelPreBetOrderEntity.code = code;
  }
  final dynamic data = json['data'];
  if (data != null) {
    cancelPreBetOrderEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    cancelPreBetOrderEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    cancelPreBetOrderEntity.ts = ts;
  }
  return cancelPreBetOrderEntity;
}

Map<String, dynamic> $CancelPreBetOrderEntityToJson(
    CancelPreBetOrderEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data;
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension CancelPreBetOrderEntityExtension on CancelPreBetOrderEntity {
  CancelPreBetOrderEntity copyWith({
    String? code,
    dynamic data,
    String? msg,
    int? ts,
  }) {
    return CancelPreBetOrderEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}