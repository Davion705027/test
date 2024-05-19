import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/save_user_customize_info_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/save_user_customize_info_entity.g.dart';

@JsonSerializable()
class SaveUserCustomizeInfoEntity {
	late String code;
	late String data;
	late String msg;
	late int ts;

	SaveUserCustomizeInfoEntity();

	factory SaveUserCustomizeInfoEntity.fromJson(Map<String, dynamic> json) => $SaveUserCustomizeInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $SaveUserCustomizeInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}