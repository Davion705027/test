import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/update_pre_bet_odds_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/update_pre_bet_odds_entity.g.dart';

@JsonSerializable()
class UpdatePreBetOddsEntity {
	late String code;
	late dynamic data;
	late String msg;
	late int ts;

	UpdatePreBetOddsEntity();

	factory UpdatePreBetOddsEntity.fromJson(Map<String, dynamic> json) => $UpdatePreBetOddsEntityFromJson(json);

	Map<String, dynamic> toJson() => $UpdatePreBetOddsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}