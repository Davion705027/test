import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/dj_date_entity_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/dj_date_entity_entity.g.dart';

@JsonSerializable()
class DjDateEntityEntity {
	late int count;
	late String field1;
	late String field2;
	late String menuId;
	late String menuName;
	dynamic menuType;
	dynamic subList;

	DjDateEntityEntity();

	factory DjDateEntityEntity.fromJson(Map<String, dynamic> json) => $DjDateEntityEntityFromJson(json);

	Map<String, dynamic> toJson() => $DjDateEntityEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}