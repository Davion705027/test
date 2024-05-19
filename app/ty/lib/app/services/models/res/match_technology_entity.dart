import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_technology_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class MatchTechnologyEntity {
	String? code;
	MatchTechnologyData? data;
	String? msg;
	int? ts;

	MatchTechnologyEntity();

	factory MatchTechnologyEntity.fromJson(Map<String, dynamic> json) => $MatchTechnologyEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchTechnologyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchTechnologyData {
	MatchTechnologyDataInParam? inParam;
	MatchTechnologyDataHomeAwayGoalAndCoachMap? homeAwayGoalAndCoachMap;

	MatchTechnologyData();

	factory MatchTechnologyData.fromJson(Map<String, dynamic> json) => $MatchTechnologyDataFromJson(json);

	Map<String, dynamic> toJson() => $MatchTechnologyDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchTechnologyDataInParam {
	dynamic historyAddition;
	dynamic histroyQueryMatchSize;
	dynamic homeNearAddition;
	dynamic homeNearMatchSize;
	String? lang;
	int? parentMenuId;
	int? sonMenuId;
	String? standardMatchId;

	MatchTechnologyDataInParam();

	factory MatchTechnologyDataInParam.fromJson(Map<String, dynamic> json) => $MatchTechnologyDataInParamFromJson(json);

	Map<String, dynamic> toJson() => $MatchTechnologyDataInParamToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchTechnologyDataHomeAwayGoalAndCoachMap {
	MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap? homeGoalMap;
	MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap? sThirdMatchCoachDTOMap;
	MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap? awayGoalMap;

	MatchTechnologyDataHomeAwayGoalAndCoachMap();

	factory MatchTechnologyDataHomeAwayGoalAndCoachMap.fromJson(Map<String, dynamic> json) => $MatchTechnologyDataHomeAwayGoalAndCoachMapFromJson(json);

	Map<String, dynamic> toJson() => $MatchTechnologyDataHomeAwayGoalAndCoachMapToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap {


	MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap();

	factory MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap.fromJson(Map<String, dynamic> json) => $MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMapFromJson(json);

	Map<String, dynamic> toJson() => $MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMapToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap {
	@JSONField(name: "1")
	List<MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1>? x1;
	@JSONField(name: "2")
	List<MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2>? x2;

	MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap();

	factory MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap.fromJson(Map<String, dynamic> json) => $MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMapFromJson(json);

	Map<String, dynamic> toJson() => $MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMapToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1 {
	String? coachBirthdate;
	dynamic coachGameCount;
	String? coachName;
	String? coachStyle;
	int? drawCount;
	int? homeAway;
	int? loseCount;
	String? score;
	int? winCount;

	MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1();

	factory MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1.fromJson(Map<String, dynamic> json) => $MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1FromJson(json);

	Map<String, dynamic> toJson() => $MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2 {
	String? coachBirthdate;
	dynamic coachGameCount;
	String? coachName;
	String? coachStyle;
	int? drawCount;
	int? homeAway;
	int? loseCount;
	String? score;
	int? winCount;

	MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2();

	factory MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2.fromJson(Map<String, dynamic> json) => $MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2FromJson(json);

	Map<String, dynamic> toJson() => $MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap {


	MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap();

	factory MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap.fromJson(Map<String, dynamic> json) => $MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMapFromJson(json);

	Map<String, dynamic> toJson() => $MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMapToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}