import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_detail_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/match_detail_entity.g.dart';

@JsonSerializable()
class MatchDetailEntity {
	late String code;
	late MatchDetailData data;
	late String msg;
	late int ts;

	MatchDetailEntity();

	factory MatchDetailEntity.fromJson(Map<String, dynamic> json) => $MatchDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchDetailData {
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
	/// 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断   ms=110时:显示即将开赛
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

	MatchDetailData();

	factory MatchDetailData.fromJson(Map<String, dynamic> json) => $MatchDetailDataFromJson(json);

	Map<String, dynamic> toJson() => $MatchDetailDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}