import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/collection_req.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/collection_req.g.dart';

@JsonSerializable()
class CollectionReq {
	late String cuid = '';
	late String euid = '';
	late int type = 0;
	late int sort = 0;
	late String device = '';

	CollectionReq();

	factory CollectionReq.fromJson(Map<String, dynamic> json) => $CollectionReqFromJson(json);

	Map<String, dynamic> toJson() => $CollectionReqToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}