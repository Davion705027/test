import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/bet_amount_entity.g.dart';
import 'dart:convert';

import 'package:flutter_ty_app/app/services/models/res/last_market_entity.dart';
export 'package:flutter_ty_app/generated/json/bet_amount_entity.g.dart';

@JsonSerializable()
class BetAmountEntity {
	late List<BetAmountBetAmountInfo> betAmountInfo = [];
	late List<LastMarketEntity> latestMarketInfo = [];

	BetAmountEntity();

	factory BetAmountEntity.fromJson(Map<String, dynamic> json) => $BetAmountEntityFromJson(json);

	Map<String, dynamic> toJson() => $BetAmountEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BetAmountBetAmountInfo {
	late int code = 0;
	late String globalId = '';
	late String minBet = '';
	late String orderMaxPay = '';
	late String playId = '';
	late String playOptionsId = '';
	late String seriesOdds = '';
	late String type = '';

	BetAmountBetAmountInfo();

	factory BetAmountBetAmountInfo.fromJson(Map<String, dynamic> json) => $BetAmountBetAmountInfoFromJson(json);

	Map<String, dynamic> toJson() => $BetAmountBetAmountInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}