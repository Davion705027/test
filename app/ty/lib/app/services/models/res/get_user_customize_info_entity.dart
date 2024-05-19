import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_user_customize_info_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_user_customize_info_entity.g.dart';

@JsonSerializable()
class GetUserCustomizeInfoEntity {
	late String code;
	late GetUserCustomizeInfoData data;
	late String msg;
	late int ts;

	GetUserCustomizeInfoEntity();

	factory GetUserCustomizeInfoEntity.fromJson(Map<String, dynamic> json) => $GetUserCustomizeInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetUserCustomizeInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserCustomizeInfoData {
	dynamic fastBetAmount;
	dynamic firstTime;
	List<int> seriesList = [];
	List<int> singleList = [];
	late bool switchOn=false;
	late String type;

	GetUserCustomizeInfoData();

	factory GetUserCustomizeInfoData.fromJson(Map<String, dynamic> json) => $GetUserCustomizeInfoDataFromJson(json);

	Map<String, dynamic> toJson() => $GetUserCustomizeInfoDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}