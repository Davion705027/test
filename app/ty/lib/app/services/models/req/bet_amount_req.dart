import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/bet_amount_req.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/bet_amount_req.g.dart';

@JsonSerializable()
class BetAmountReq {
	late List<BetAmountReqOrderMaxBetMoney> orderMaxBetMoney = [];

	BetAmountReq();

	factory BetAmountReq.fromJson(Map<String, dynamic> json) => $BetAmountReqFromJson(json);

	Map<String, dynamic> toJson() => $BetAmountReqToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BetAmountReqOrderMaxBetMoney {
	late String sportId = '';
	late String marketId = '';
	late int deviceType = 0;
	late String matchId = '';
	late String oddsFinally = '';
	late String oddsValue = '';
	late String playId = '';
	late String playOptionId = '';
	late String playOptions = '';
	late int seriesType = 0;
	String? matchProcessId = '';
	late String scoreBenchmark = '';
	late int tenantId = 0;
	late int tournamentLevel = 0;
	late String tournamentId = '';
	late String dataSource = '';
	late int matchType = 0;
	late int openMiltSingle = 0;

	BetAmountReqOrderMaxBetMoney();

	factory BetAmountReqOrderMaxBetMoney.fromJson(Map<String, dynamic> json) => $BetAmountReqOrderMaxBetMoneyFromJson(json);

	Map<String, dynamic> toJson() => $BetAmountReqOrderMaxBetMoneyToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}