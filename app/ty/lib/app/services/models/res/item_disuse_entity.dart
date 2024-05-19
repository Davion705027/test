
import 'dart:convert';

import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/item_disuse_entity.g.dart';

@JsonSerializable()
class ItemDisuseEntity {
	late String awayName;
	late String awayNameCode;
	late String awayScore;
	late String homeName;
	late String homeNameCode;
	late String homeScore;
	late String isSecond;
	late String phase;
	late String tournamentId;

	ItemDisuseEntity();

	factory ItemDisuseEntity.fromJson(Map<String, dynamic> json) => $ItemDisuseEntityFromJson(json);

	Map<String, dynamic> toJson() => $ItemDisuseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}