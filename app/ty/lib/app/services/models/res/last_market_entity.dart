import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/last_market_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/last_market_entity.g.dart';

@JsonSerializable()
class LastMarketEntity {
	late String away = '';
	LastMarketCurrentMarket? currentMarket;
	late String home = '';
	late List<LastMarketMarketList> marketList = [];
	late int matchHandicapStatus = 0;
	late String matchInfoId = '';
	late int matchOver = 0;
	late int matchPeriodId = 0;
	late int matchStatus = 0;
	late int pendingOrderStatus = 0;
	late String playId = '';
	late String playName = '';

	LastMarketEntity();

	factory LastMarketEntity.fromJson(Map<String, dynamic> json) => $LastMarketEntityFromJson(json);

	Map<String, dynamic> toJson() => $LastMarketEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LastMarketCurrentMarket {
	late String chpid = '';
	late String id = '';
	late List<LastMarketCurrentMarketMarketOddsList> marketOddsList = [];
	late int marketType = 0;
	late String marketValue = '';
	int? placeNum;
	late String preBetBenchmarkScore = '';
	late String score = '';
	late int status = 0;

	LastMarketCurrentMarket();

	factory LastMarketCurrentMarket.fromJson(Map<String, dynamic> json) => $LastMarketCurrentMarketFromJson(json);

	Map<String, dynamic> toJson() => $LastMarketCurrentMarketToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LastMarketCurrentMarketMarketOddsList {
	late String id = '';
	late int oddsStatus = 0;
	late String oddsType = '';
	late int oddsValue = 0;
	late String playOptions = '';

	LastMarketCurrentMarketMarketOddsList();

	factory LastMarketCurrentMarketMarketOddsList.fromJson(Map<String, dynamic> json) => $LastMarketCurrentMarketMarketOddsListFromJson(json);

	Map<String, dynamic> toJson() => $LastMarketCurrentMarketMarketOddsListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LastMarketMarketList {
	late String chpid = '';
	late String id = '';
	late List<LastMarketMarketListMarketOddsList> marketOddsList = [];
	late int marketType = 0;
	late String marketValue = '';
	int? placeNum;
	late String preBetBenchmarkScore = '';
	late String score = '';
	late int status = 0;

	LastMarketMarketList();

	factory LastMarketMarketList.fromJson(Map<String, dynamic> json) => $LastMarketMarketListFromJson(json);

	Map<String, dynamic> toJson() => $LastMarketMarketListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LastMarketMarketListMarketOddsList {
	late String id = '';
	late int oddsStatus = 0;
	late String oddsType = '';
	late int oddsValue = 0;
	late String playOptions = '';

	LastMarketMarketListMarketOddsList();

	factory LastMarketMarketListMarketOddsList.fromJson(Map<String, dynamic> json) => $LastMarketMarketListMarketOddsListFromJson(json);

	Map<String, dynamic> toJson() => $LastMarketMarketListMarketOddsListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}