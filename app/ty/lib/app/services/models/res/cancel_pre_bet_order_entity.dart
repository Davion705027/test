import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/cancel_pre_bet_order_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/cancel_pre_bet_order_entity.g.dart';

@JsonSerializable()
class CancelPreBetOrderEntity {
	late String code;
	dynamic data;
	late String msg;
	late int ts;

	CancelPreBetOrderEntity();

	factory CancelPreBetOrderEntity.fromJson(Map<String, dynamic> json) => $CancelPreBetOrderEntityFromJson(json);

	Map<String, dynamic> toJson() => $CancelPreBetOrderEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}