import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/menu_count_info_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/menu_count_info_entity.g.dart';

@JsonSerializable()
class MenuCountInfoEntity {
	late bool containLive = false;
	late int count = 0;
	late int menuId = 0;
	late int sys = 0;

	MenuCountInfoEntity();

	factory MenuCountInfoEntity.fromJson(Map<String, dynamic> json) => $MenuCountInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $MenuCountInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}