import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/order_pre_settle_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/order_pre_settle_entity.g.dart';

@JsonSerializable()
class OrderPreSettleEntity {
	late String code;
	dynamic data;
	late String msg;
	late int ts;

	OrderPreSettleEntity();

	factory OrderPreSettleEntity.fromJson(Map<String, dynamic> json) => $OrderPreSettleEntityFromJson(json);

	Map<String, dynamic> toJson() => $OrderPreSettleEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}