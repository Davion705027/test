import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/test_info.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/test_info.g.dart';

@JsonSerializable()
class TestInfo {
	late int id = 0;
	late String name = '';

	TestInfo();

	factory TestInfo.fromJson(Map<String, dynamic> json) => $TestInfoFromJson(json);

	Map<String, dynamic> toJson() => $TestInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}