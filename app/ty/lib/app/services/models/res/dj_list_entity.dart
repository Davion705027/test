import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/dj_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/dj_list_entity.g.dart';

@JsonSerializable()
class DjListEntity {
	late String mid;
	late int mess;
	late String csna;
	late String tid;
	late String vurl;
	late String mst;
	late int mmp;
	late int mms;
	late String varl;
	late int mc;
	late List<String> mhlu;
	late int ispo;
	late bool mf;
	late int mgt;
	late String man;
	late List<String> frman;
	late String csid;
	late int ms;
	late List<DjListHps> hps;
	late List<String> malu;
	late String mhn;
	late bool tf;
	late List<String> frmhn;
	late String mfo;
	late int mhs;
	late String tn;
	late List<String> msc;

	@JSONField(serialize: false, deserialize: false)
	bool isCollection = false;
	@JSONField(serialize: false, deserialize: false)
	bool isExpand = true;
	DjListEntity();

	factory DjListEntity.fromJson(Map<String, dynamic> json) => $DjListEntityFromJson(json);

	Map<String, dynamic> toJson() => $DjListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class DjListHps {
	late String hpid;
	late List<DjListHpsHl> hl;
	late int hpon;
	late String hpn;
	late String mid;
	late int hmm;
	late String hshow;
	late String hsw;
	late int hpt;

	DjListHps();

	factory DjListHps.fromJson(Map<String, dynamic> json) => $DjListHpsFromJson(json);

	Map<String, dynamic> toJson() => $DjListHpsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class DjListHpsHl {
	late String hid;
	 int? hs;
	dynamic hv;
	late int hmt;
	late int hn;
	late int hipo;
	 List<DjListHpsHlOl>? ol;

	DjListHpsHl();

	factory DjListHpsHl.fromJson(Map<String, dynamic> json) => $DjListHpsHlFromJson(json);

	Map<String, dynamic> toJson() => $DjListHpsHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class DjListHpsHlOl {
	late String oid;
	late int os;
	late int otd;
	late String ot;
	late int ov;
	late String on;
	late String onb;
	dynamic cds;
	late String ots;

	DjListHpsHlOl();

	factory DjListHpsHlOl.fromJson(Map<String, dynamic> json) => $DjListHpsHlOlFromJson(json);

	Map<String, dynamic> toJson() => $DjListHpsHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}