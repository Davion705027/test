import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/matche_result_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/matche_result_entity.g.dart';

@JsonSerializable()
class MatcheResultEntity {
	late String code;
	late List<MatcheResultData> data;
	late String msg;
	late int ts;

	MatcheResultEntity();

	factory MatcheResultEntity.fromJson(Map<String, dynamic> json) => $MatcheResultEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatcheResultEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatcheResultData {
	late String tnjc;
	late String csna;
	late String tid;
	late String mst;
	late String srid;
	late int mcg;
	late int atf;
	late String mdsc;
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
	dynamic tonum;
	late String mhid;
	late String mrmc;
	late bool playBack;
	late String mid;
	late int mess;
	dynamic lss;
	late String mmp;
	dynamic mststi;
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
	late int tournamentSort;
	late int mearlys;
	late bool tf;
	dynamic mfo;
	late int mft;
	late String tn;
	late List<String> msc;

	MatcheResultData();

	factory MatcheResultData.fromJson(Map<String, dynamic> json) => $MatcheResultDataFromJson(json);

	Map<String, dynamic> toJson() => $MatcheResultDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}