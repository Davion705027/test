import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/champion_match_result_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/champion_match_result_entity.g.dart';

@JsonSerializable()
class ChampionMatchResultEntity {
	late String code;
	late List<ChampionMatchResultData> data;
	late String msg;
	late int ts;

	ChampionMatchResultEntity();

	factory ChampionMatchResultEntity.fromJson(Map<String, dynamic> json) => $ChampionMatchResultEntityFromJson(json);

	Map<String, dynamic> toJson() => $ChampionMatchResultEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ChampionMatchResultData {
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

	ChampionMatchResultData();

	factory ChampionMatchResultData.fromJson(Map<String, dynamic> json) => $ChampionMatchResultDataFromJson(json);

	Map<String, dynamic> toJson() => $ChampionMatchResultDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}