import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/collection_count_info.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/collection_count_info.g.dart';

@JsonSerializable()
class CollectionCountInfo {
	late int count = 0;
	late String field1 = '';
	late String field2 = '';
	late String field3 = '';
	dynamic menuId;
	dynamic menuType;
	late String name = '';
	late String sportId = '';
	dynamic subList;

	CollectionCountInfo();

	factory CollectionCountInfo.fromJson(Map<String, dynamic> json) => $CollectionCountInfoFromJson(json);

	Map<String, dynamic> toJson() => $CollectionCountInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}