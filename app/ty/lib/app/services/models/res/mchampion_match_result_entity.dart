import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/mchampion_match_result_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/mchampion_match_result_entity.g.dart';

@JsonSerializable()
class MchampionMatchResultEntity {
	late String code;
	late List<MchampionMatchResultData> data = [];
	late String msg;
	late int ts;

	MchampionMatchResultEntity();

	factory MchampionMatchResultEntity.fromJson(Map<String, dynamic> json) => $MchampionMatchResultEntityFromJson(json);

	Map<String, dynamic> toJson() => $MchampionMatchResultEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MchampionMatchResultData {
	late String picUrl;
	late String sportId;
	late String tournamentName;
	late String scoreResult;
	late String tournamentId;
	late String playName;
	late String sportName;
	late String matchTime;
	late String matchId;
	late String marketId;
	late bool isExpand;

	MchampionMatchResultData();

	factory MchampionMatchResultData.fromJson(Map<String, dynamic> json) => $MchampionMatchResultDataFromJson(json);

	Map<String, dynamic> toJson() => $MchampionMatchResultDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}