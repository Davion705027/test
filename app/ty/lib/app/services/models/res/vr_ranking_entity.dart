import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/vr_ranking_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/vr_ranking_entity.g.dart';

@JsonSerializable()
class VrRankingEntity {
	late int draw;
	late String history;
	late int lost;
	late int points;
	late int ranking;
	late String tid;
	late int totalCount;
	late String virtualTeamId;
	late String virtualTeamName;
	late int win;
	late String winDrawLostDescription;

	VrRankingEntity();

	factory VrRankingEntity.fromJson(Map<String, dynamic> json) => $VrRankingEntityFromJson(json);

	Map<String, dynamic> toJson() => $VrRankingEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}