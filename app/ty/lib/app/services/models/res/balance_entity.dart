import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/balance_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/balance_entity.g.dart';

@JsonSerializable()
class BalanceEntity {
	late String uid = '';
	late double amount;

	BalanceEntity();

	factory BalanceEntity.fromJson(Map<String, dynamic> json) => $BalanceEntityFromJson(json);

	Map<String, dynamic> toJson() => $BalanceEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}