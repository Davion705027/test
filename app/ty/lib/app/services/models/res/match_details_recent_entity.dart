import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_details_recent_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class MatchDetailsRecentEntity {
	String? code;
	List<MatchDetailsRecentData>? data;
	String? msg;
	int? ts;

	MatchDetailsRecentEntity();

	factory MatchDetailsRecentEntity.fromJson(Map<String, dynamic> json) => $MatchDetailsRecentEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchDetailsRecentEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchDetailsRecentData {
	String? awayTeamId;
	String? awayTeamName;
	String? awayTeamScore;
	String? beginTime;
	String? boldTagName;
	String? handicapOdds;
	int? handicapResult;
	String? handicapVal;
	String? homeTeamId;
	String? homeTeamName;
	String? homeTeamScore;
	int? matchGroup;
	String? overunderOdds;
	int? overunderResult;
	String? overunderVal;
	int? result;
	String? sportId;
	String? teamGroup;
	String? thirdMatchId;
	String? tournamentName;
	String? winnerOdds;

	MatchDetailsRecentData();

	factory MatchDetailsRecentData.fromJson(Map<String, dynamic> json) => $MatchDetailsRecentDataFromJson(json);

	Map<String, dynamic> toJson() => $MatchDetailsRecentDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}