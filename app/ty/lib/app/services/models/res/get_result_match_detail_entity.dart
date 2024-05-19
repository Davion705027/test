import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_result_match_detail_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_result_match_detail_entity.g.dart';

@JsonSerializable()
class GetResultMatchDetailEntity {
	late String code;
	late GetResultMatchDetailData data;
	late String msg;
	late int ts;

	GetResultMatchDetailEntity();

	factory GetResultMatchDetailEntity.fromJson(Map<String, dynamic> json) => $GetResultMatchDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetResultMatchDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetResultMatchDetailData {
	late String tnjc;
	late String csna;
	late String tid;
	late String mst;
	late String srid;
	late int mcg;
	late int atf;
	dynamic mdsc;
	late int gcs;
	late bool mf;
	late String mgt;
	late String maid;
	late int mct;
	late int tlev;
	late String mhlut;
	late int mo;
	late int ctt;
	late int mp;
	late String csid;
	late int ms;
	late String cmec;
	late int mle;
	late int lvs;
	dynamic sort;
	late List<String> malu;
	late String lurl;
	late String mprmc;
	late String mhn;
	late String cds;
	late List<String> frmhn;
	late int operationTournamentSort;
	late int mhs;
	late String mlet;
	late String mhid;
	late String mrmc;
	late String mid;
	late int mess;
	dynamic lss;
	late String mmp;
	late String mststi;
	late int mms;
	late int mbmty;
	late int pmms;
	late List<String> mhlu;
	late String seid;
	late String mstst;
	late String malut;
	late String man;
	late List<String> frman;
	late String mat;
	late int mng;
	late String mststr;
	late int mvs;
	late int mststs;
	late int mearlys;
	dynamic mfo;
	late int mft;
	late String tn;
	late List<String> msc;

	GetResultMatchDetailData();

	factory GetResultMatchDetailData.fromJson(Map<String, dynamic> json) => $GetResultMatchDetailDataFromJson(json);

	Map<String, dynamic> toJson() => $GetResultMatchDetailDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}