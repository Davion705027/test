import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/login_panda_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/login_panda_entity.g.dart';

@JsonSerializable()
class LoginPandaEntity {
	late bool status;
	late String msg;
	late String code;
	late LoginPandaData data;
	late int serverTime;

	LoginPandaEntity();

	factory LoginPandaEntity.fromJson(Map<String, dynamic> json) => $LoginPandaEntityFromJson(json);

	Map<String, dynamic> toJson() => $LoginPandaEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LoginPandaData {
	late List<String> loginUrlArr;
	late String loginUrl;
	late String domain;
	late String token;

	LoginPandaData();

	factory LoginPandaData.fromJson(Map<String, dynamic> json) => $LoginPandaDataFromJson(json);

	Map<String, dynamic> toJson() => $LoginPandaDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}