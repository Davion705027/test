import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/balance_entity.dart';

BalanceEntity $BalanceEntityFromJson(Map<String, dynamic> json) {
  final BalanceEntity balanceEntity = BalanceEntity();
  final String? uid = jsonConvert.convert<String>(json['uid']);
  if (uid != null) {
    balanceEntity.uid = uid;
  }
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    balanceEntity.amount = amount;
  }
  return balanceEntity;
}

Map<String, dynamic> $BalanceEntityToJson(BalanceEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['uid'] = entity.uid;
  data['amount'] = entity.amount;
  return data;
}

extension BalanceEntityExtension on BalanceEntity {
  BalanceEntity copyWith({
    String? uid,
    double? amount,
  }) {
    return BalanceEntity()
      ..uid = uid ?? this.uid
      ..amount = amount ?? this.amount;
  }
}