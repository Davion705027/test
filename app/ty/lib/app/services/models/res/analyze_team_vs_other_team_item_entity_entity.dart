import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/analyze_team_vs_other_team_item_entity_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class AnalyzeTeamVsOtherTeamItemEntityEntity {

	String? awayTeamId;
	String? awayTeamName;
	String? awayTeamScore;
	String? beginTime;
	String? boldTagName;
	String? handicapOdds;
	double? handicapResult;
	String? handicapVal;
	String? homeTeamId;
	String? homeTeamName;
	String? homeTeamScore;
	double? matchGroup;
	String? overunderOdds;
	double? overunderResult;
	String? overunderVal;
	double? result;
	String? sportId;
	String? teamGroup;
	String? thirdMatchId;
	String? tournamentName;
	String? winnerOdds;
  
  AnalyzeTeamVsOtherTeamItemEntityEntity();

  factory AnalyzeTeamVsOtherTeamItemEntityEntity.fromJson(Map<String, dynamic> json) => $AnalyzeTeamVsOtherTeamItemEntityEntityFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeTeamVsOtherTeamItemEntityEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}