import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/matche_handpick_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/matche_handpick_entity.g.dart';

@JsonSerializable()
class MatcheHandpickEntity {
	late String code;
	late List<MatcheHandpickData> data;
	late String msg;
	late int ts;

	MatcheHandpickEntity();

	factory MatcheHandpickEntity.fromJson(Map<String, dynamic> json) => $MatcheHandpickEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatcheHandpickEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatcheHandpickData {
	late String tnjc;
	late String csna;
	late String tid;
	late String mst;
	late String srid;
	late int mcg;
	late int atf;
	dynamic mdsc;
	late int gcs;
	late int mc;
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
	dynamic cmec;
	late int mle;
	late int lvs;
	late int sort;
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
	late List<MatcheHandpickDataHps> hps;
	late int mvs;
	late int mststs;
	late int mearlys;
	dynamic mfo;
	late int mft;
	late String tn;
	late List<dynamic> msc;

	MatcheHandpickData();

	factory MatcheHandpickData.fromJson(Map<String, dynamic> json) => $MatcheHandpickDataFromJson(json);

	Map<String, dynamic> toJson() => $MatcheHandpickDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatcheHandpickDataHps {
	late String mid;
	late String chpid;
	late String hpid;
	late int hpon;
	late String hshow;
	late String hpn;
	late String hpnb;
	late int hpt;
	late String hsw;
	late int hmm;
	late int hids;
	late List<MatcheHandpickDataHpsHl> hl;

	MatcheHandpickDataHps();

	factory MatcheHandpickDataHps.fromJson(Map<String, dynamic> json) => $MatcheHandpickDataHpsFromJson(json);

	Map<String, dynamic> toJson() => $MatcheHandpickDataHpsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatcheHandpickDataHpsHl {
	late String hid;
	late int hs;
	late String hv;
	late int hmt;
	late int hn;
	late List<MatcheHandpickDataHpsHlOl> ol;

	MatcheHandpickDataHpsHl();

	factory MatcheHandpickDataHpsHl.fromJson(Map<String, dynamic> json) => $MatcheHandpickDataHpsHlFromJson(json);

	Map<String, dynamic> toJson() => $MatcheHandpickDataHpsHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatcheHandpickDataHpsHlOl {
	late String oid;
	late int os;
	late int otd;
	late String ot;
	late int ov;
	late String on;
	late String onb;
	late String cds;
	late String ots;

	MatcheHandpickDataHpsHlOl();

	factory MatcheHandpickDataHpsHlOl.fromJson(Map<String, dynamic> json) => $MatcheHandpickDataHpsHlOlFromJson(json);

	Map<String, dynamic> toJson() => $MatcheHandpickDataHpsHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}