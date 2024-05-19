import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_cashout_max_amount_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_cashout_max_amount_list_entity.g.dart';

@JsonSerializable()
class GetCashoutMaxAmountListEntity {
	late String code;
	late List<GetCashoutMaxAmountListData> data;
	late String msg;
	late int ts;

	GetCashoutMaxAmountListEntity();

	factory GetCashoutMaxAmountListEntity.fromJson(Map<String, dynamic> json) => $GetCashoutMaxAmountListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetCashoutMaxAmountListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetCashoutMaxAmountListData {
	late double betAmount;
	late double csper;
	late String orderNo;
	late int orderStatus;
	dynamic preBetAmount;
	late double preSettleMaxWin;

	GetCashoutMaxAmountListData();

	factory GetCashoutMaxAmountListData.fromJson(Map<String, dynamic> json) => $GetCashoutMaxAmountListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetCashoutMaxAmountListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}