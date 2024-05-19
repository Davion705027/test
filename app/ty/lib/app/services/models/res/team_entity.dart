import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/team_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/team_entity.g.dart';

@JsonSerializable()
class TeamEntity {
	dynamic lurl;
	dynamic tnjc;
	late String tn = '';
	late String tid = '';
	late int tlev = 0;

	TeamEntity();

	factory TeamEntity.fromJson(Map<String, dynamic> json) => $TeamEntityFromJson(json);

	Map<String, dynamic> toJson() => $TeamEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}