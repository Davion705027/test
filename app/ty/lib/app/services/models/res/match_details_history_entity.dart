import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_details_history_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class MatchDetailsHistoryEntity {
	String? code;
	List<MatchDetailsHistoryData>? data;
	String? msg;
	int? ts;

	MatchDetailsHistoryEntity();

	factory MatchDetailsHistoryEntity.fromJson(Map<String, dynamic> json) => $MatchDetailsHistoryEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchDetailsHistoryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchDetailsHistoryData {
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

	MatchDetailsHistoryData();

	factory MatchDetailsHistoryData.fromJson(Map<String, dynamic> json) => $MatchDetailsHistoryDataFromJson(json);

	Map<String, dynamic> toJson() => $MatchDetailsHistoryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}