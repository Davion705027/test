import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_details_league_points_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class MatchDetailsLeaguePointsEntity {
	String? code;
	List<MatchDetailsLeaguePointsData>? data;
	String? msg;
	int? ts;

	MatchDetailsLeaguePointsEntity();

	factory MatchDetailsLeaguePointsEntity.fromJson(Map<String, dynamic> json) => $MatchDetailsLeaguePointsEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchDetailsLeaguePointsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchDetailsLeaguePointsData {
	int? drawTotal;
	int? goalDiffTotal;
	int? goalsAgainstTotal;
	int? goalsForTotal;
	int? lossTotal;
	int? matchCount;
	int? matchGroup;
	int? pointsTotal;
	int? positionTotal;
	String? teamFlag;
	String? teamLogo;
	String? teamName;
	String? thirdTeamSourceId;
	String? tournamentName;
	int? tournamentType;
	int? winTotal;

	MatchDetailsLeaguePointsData();

	factory MatchDetailsLeaguePointsData.fromJson(Map<String, dynamic> json) => $MatchDetailsLeaguePointsDataFromJson(json);

	Map<String, dynamic> toJson() => $MatchDetailsLeaguePointsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}