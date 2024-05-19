import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/detail_video_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/detail_video_entity.g.dart';

@JsonSerializable()
class DetailVideoEntity {
	late String csid = "";
	late String mid = "";
	late String tid = "";

	DetailVideoEntity();

	factory DetailVideoEntity.fromJson(Map<String, dynamic> json) => $DetailVideoEntityFromJson(json);

	Map<String, dynamic> toJson() => $DetailVideoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}