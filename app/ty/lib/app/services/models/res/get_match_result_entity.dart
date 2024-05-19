import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_match_result_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_match_result_entity.g.dart';

@JsonSerializable()
class GetMatchResultEntity {
	late String code;
	late List<GetMatchResultData> data;
	late String msg;
	late int ts;

	GetMatchResultEntity();

	factory GetMatchResultEntity.fromJson(Map<String, dynamic> json) => $GetMatchResultEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchResultEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMatchResultData {
	late List<GetMatchResultDataHl> hl;
	late String hpn;
	late String topKey;
	late String mid;
	late int hmm;
	late String hps;
	late String hshow;
	late List<GetMatchResultDataTitle> title;
	late int hpt;
	late String hlid;
	late String hpid;
	late int hpon;
	late String hton;
	late bool isExpand = true;

	GetMatchResultData();

	factory GetMatchResultData.fromJson(Map<String, dynamic> json) => $GetMatchResultDataFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchResultDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMatchResultDataHl {
	late String hid;
	late List<GetMatchResultDataHlOl> ol;
	late String hv;
	late String ad2;
	late String ad1;

	GetMatchResultDataHl();

	factory GetMatchResultDataHl.fromJson(Map<String, dynamic> json) => $GetMatchResultDataHlFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchResultDataHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMatchResultDataHlOl {
	late int result;
	late String ot;
	late String oid;
	late int otd;
	late String ott;
	late String on;

	GetMatchResultDataHlOl();

	factory GetMatchResultDataHlOl.fromJson(Map<String, dynamic> json) => $GetMatchResultDataHlOlFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchResultDataHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMatchResultDataTitle {
	late String osn;
	late int otd;

	GetMatchResultDataTitle();

	factory GetMatchResultDataTitle.fromJson(Map<String, dynamic> json) => $GetMatchResultDataTitleFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchResultDataTitleToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}