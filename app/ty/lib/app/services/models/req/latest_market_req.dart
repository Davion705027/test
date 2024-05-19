import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/latest_market_req.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/latest_market_req.g.dart';

@JsonSerializable()
class LatestMarketReq {
	late List<LatestMarketReqIdList> idList = [];

	LatestMarketReq();

	factory LatestMarketReq.fromJson(Map<String, dynamic> json) => $LatestMarketReqFromJson(json);

	Map<String, dynamic> toJson() => $LatestMarketReqToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LatestMarketReqIdList {
	late String marketId = '';
	late String matchInfoId = '';
	late String oddsId = '';
	late String oddsType = '';
	late String playId = '';
	int? placeNum;
	late int matchType = 0;
	late String sportId = '';

	LatestMarketReqIdList();

	factory LatestMarketReqIdList.fromJson(Map<String, dynamic> json) => $LatestMarketReqIdListFromJson(json);

	Map<String, dynamic> toJson() => $LatestMarketReqIdListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}