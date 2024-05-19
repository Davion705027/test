import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/analyze_team_vs_history_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
	class AnalyzeTeamVsHistoryEntity {

	String? awayTeamId;
	String? awayTeamName;
	String? awayTeamScore;
	String? beginTime;
	String? boldTagName;
	String? handicapOdds;
	num? handicapResult;
	String? handicapVal;
	String? homeTeamId;
	String? homeTeamName;
	String? homeTeamScore;
	num? matchGroup;
	String? overunderOdds;
	dynamic overunderResult;
	String? overunderVal;
	num? result;
	String? sportId;
	String? teamGroup;
	String? thirdMatchId;
	String? tournamentName;
	String? winnerOdds;
  
  AnalyzeTeamVsHistoryEntity();

  factory AnalyzeTeamVsHistoryEntity.fromJson(Map<String, dynamic> json) => $AnalyzeTeamVsHistoryEntityFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeTeamVsHistoryEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}