import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_lineup_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class MatchLineupEntity {
	String? code;
	MatchLineupData? data;
	String? msg;
	int? ts;

	MatchLineupEntity();

	factory MatchLineupEntity.fromJson(Map<String, dynamic> json) => $MatchLineupEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchLineupEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchLineupData {
	String? homeFormation;
	List<MatchLineupDataUp>? up;
	List<MatchLineupDataDown>? down;

	MatchLineupData();

	factory MatchLineupData.fromJson(Map<String, dynamic> json) => $MatchLineupDataFromJson(json);

	Map<String, dynamic> toJson() => $MatchLineupDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchLineupDataUp {
	String? awayFormation;
	String? createTime;
	String? dataSourceCode;
	int? homeAway;
	String? homeFormation;
	String? id;
	int? invalid;
	String? matchInfoId;
	String? modifyTime;
	int? position;
	String? positionEnName;
	String? positionName;
	dynamic shirtNumber;
	String? sportId;
	int? substitute;
	String? thirdPlayerEnName;
	String? thirdPlayerName;
	String? thirdPlayerPicUrl;
	String? thirdPlayerSourceId;
	String? thirdTeamSourceId;

	MatchLineupDataUp();

	factory MatchLineupDataUp.fromJson(Map<String, dynamic> json) => $MatchLineupDataUpFromJson(json);

	Map<String, dynamic> toJson() => $MatchLineupDataUpToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchLineupDataDown {
	String? awayFormation;
	String? createTime;
	String? dataSourceCode;
	int? homeAway;
	String? homeFormation;
	String? id;
	int? invalid;
	String? matchInfoId;
	String? modifyTime;
	int? position;
	String? positionEnName;
	String? positionName;
	dynamic shirtNumber;
	String? sportId;
	int? substitute;
	String? thirdPlayerEnName;
	String? thirdPlayerName;
	String? thirdPlayerPicUrl;
	String? thirdPlayerSourceId;
	String? thirdTeamSourceId;

	MatchLineupDataDown();

	factory MatchLineupDataDown.fromJson(Map<String, dynamic> json) => $MatchLineupDataDownFromJson(json);

	Map<String, dynamic> toJson() => $MatchLineupDataDownToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}