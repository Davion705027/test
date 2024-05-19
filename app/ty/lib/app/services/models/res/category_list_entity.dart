import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/category_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/category_list_entity.g.dart';

@JsonSerializable()
class CategoryListEntity {
	late String code;
	late List<CategoryListData> data;
	late String msg;
	late int ts;

	CategoryListEntity();

	factory CategoryListEntity.fromJson(Map<String, dynamic> json) => $CategoryListEntityFromJson(json);

	Map<String, dynamic> toJson() => $CategoryListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CategoryListData {
	late String marketName;
	late int orderNo;
	late List<int> plays = [];
	late String id;
	late String label = "";
	// 电竞特有字段 局数
	int? round;

	CategoryListData();

	factory CategoryListData.fromJson(Map<String, dynamic> json) => $CategoryListDataFromJson(json);

	Map<String, dynamic> toJson() => $CategoryListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}