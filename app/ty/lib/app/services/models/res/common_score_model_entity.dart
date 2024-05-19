import 'dart:convert';

import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/common_score_model_entity.g.dart';


@JsonSerializable()
class CommonScoreModelEntity {
	late String status;
	late List<CommonScoreModelData> data;

	CommonScoreModelEntity();

	factory CommonScoreModelEntity.fromJson(Map<String, dynamic> json) => $CommonScoreModelEntityFromJson(json);

	Map<String, dynamic> toJson() => $CommonScoreModelEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CommonScoreModelData {
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

	CommonScoreModelData();

	factory CommonScoreModelData.fromJson(Map<String, dynamic> json) => $CommonScoreModelDataFromJson(json);

	Map<String, dynamic> toJson() => $CommonScoreModelDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}