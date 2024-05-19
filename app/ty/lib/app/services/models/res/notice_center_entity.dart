import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/notice_center_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/notice_center_entity.g.dart';

@JsonSerializable()
class NoticeCenterEntity {
	late List<NoticeCenterNb> nb = [];
	late List<NoticeCenterNt> nt = [];
	late List<NoticeCenterNl> nl = [];

	NoticeCenterEntity();

	factory NoticeCenterEntity.fromJson(Map<String, dynamic> json) => $NoticeCenterEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoticeCenterEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeCenterNb {
	late String context = '';
	late String id = '';
	late int isShuf = 0;
	late int isTop = 0;
	late int noticeType = 0;
	late String noticeTypeName = '';
	late String sendTime = '';
	late String sendTimeOther = '';
	late String title = '';

	NoticeCenterNb();

	factory NoticeCenterNb.fromJson(Map<String, dynamic> json) => $NoticeCenterNbFromJson(json);

	Map<String, dynamic> toJson() => $NoticeCenterNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeCenterNt {
	late String enType = '';
	late int id = 0;
	late String type = '';

	NoticeCenterNt();

	factory NoticeCenterNt.fromJson(Map<String, dynamic> json) => $NoticeCenterNtFromJson(json);

	Map<String, dynamic> toJson() => $NoticeCenterNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeCenterNl {
	late List<NoticeCenterNlMtl> mtl = [];
	late String nen = '';
	late int net = 0;

	NoticeCenterNl();

	factory NoticeCenterNl.fromJson(Map<String, dynamic> json) => $NoticeCenterNlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeCenterNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeCenterNlMtl {
	late String context = '';
	late String id = '';
	late int isShuf = 0;
	late int isTop = 0;
	late int noticeType = 0;
	late String noticeTypeName = '';
	late String sendTime = '';
	late String sendTimeOther = '';
	late String title = '';

	NoticeCenterNlMtl();

	factory NoticeCenterNlMtl.fromJson(Map<String, dynamic> json) => $NoticeCenterNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeCenterNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}