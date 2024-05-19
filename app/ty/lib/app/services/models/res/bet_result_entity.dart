import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/bet_result_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/bet_result_entity.g.dart';

@JsonSerializable()
class BetResultEntity {
	late String betMoneyTotal = '';
	late String globalId = '';
	late int lock = 0;
	late String maxWinMoneyTotal = '';
	late List<BetResultOrderDetailRespList> orderDetailRespList = [];
	late List<BetResultSeriesOrderRespList> seriesOrderRespList = [];

	BetResultEntity();

	factory BetResultEntity.fromJson(Map<String, dynamic> json) => $BetResultEntityFromJson(json);

	Map<String, dynamic> toJson() => $BetResultEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BetResultOrderDetailRespList {
	late String addition = '';
	late String batchNum = '';
	late String betMoney = '';
	late String marketType = '';
	late String marketValues = '';
	late String matchDay = '';
	dynamic matchDetailType;
	late String matchInfo = '';
	late String matchName = '';
	late int matchStatus = 0;
	late int matchType = 0;
	late String maxWinMoney = '';
	late String oddsType = '';
	late String oddsValues = '';
	late String orderNo = '';
	late int orderStatusCode;
	late String playName = '';
	late String playOptionName = '';
	late String playOptionsId = '';
	dynamic preOrderDetailStatus;
	late String scoreBenchmark = '';
	late String teamName = '';

	BetResultOrderDetailRespList();

	factory BetResultOrderDetailRespList.fromJson(Map<String, dynamic> json) => $BetResultOrderDetailRespListFromJson(json);

	Map<String, dynamic> toJson() => $BetResultOrderDetailRespListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BetResultSeriesOrderRespList {
	late String betAmount = '';
	late String marketType = '';
	late String maxWinAmount = '';
	late String orderNo = '';
	late int orderStatusCode = 0;
	late String seriesBetAmount = '';
	late int seriesSum = 0;
	late String seriesValue = '';

	BetResultSeriesOrderRespList();

	factory BetResultSeriesOrderRespList.fromJson(Map<String, dynamic> json) => $BetResultSeriesOrderRespListFromJson(json);

	Map<String, dynamic> toJson() => $BetResultSeriesOrderRespListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}