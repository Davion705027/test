import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/order_pre_settle_entity.dart';

OrderPreSettleEntity $OrderPreSettleEntityFromJson(Map<String, dynamic> json) {
  final OrderPreSettleEntity orderPreSettleEntity = OrderPreSettleEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    orderPreSettleEntity.code = code;
  }
  final dynamic data = json['data'];
  if (data != null) {
    orderPreSettleEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    orderPreSettleEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    orderPreSettleEntity.ts = ts;
  }
  return orderPreSettleEntity;
}

Map<String, dynamic> $OrderPreSettleEntityToJson(OrderPreSettleEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data;
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension OrderPreSettleEntityExtension on OrderPreSettleEntity {
  OrderPreSettleEntity copyWith({
    String? code,
    dynamic data,
    String? msg,
    int? ts,
  }) {
    return OrderPreSettleEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}