import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/menu_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/menu_entity.g.dart';

@JsonSerializable()
class MenuEntity {
	late String code;
	late String data;
	late String msg;
	late int ts;

	MenuEntity();

	factory MenuEntity.fromJson(Map<String, dynamic> json) => $MenuEntityFromJson(json);

	Map<String, dynamic> toJson() => $MenuEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}