import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/analyze_v_s_info_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class AnalyzeVSInfoEntity {

	num? drawTotal;
	num? goalDiffTotal;
	num? goalsAgainstTotal;
	num? goalsForTotal;
	num? lossTotal;
	num? matchCount;
	num? matchGroup;
	num? pointsTotal;
	num? positionTotal;
	String? teamFlag;
	String? teamLogo;
	String? teamName;
	String? thirdTeamSourceId;
	String? tournamentName;
	num? tournamentType;
	num? winTotal;
  
  AnalyzeVSInfoEntity();

  factory AnalyzeVSInfoEntity.fromJson(Map<String, dynamic> json) => $AnalyzeVSInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeVSInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}