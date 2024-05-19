import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_info.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/match_info.g.dart';

@JsonSerializable()
class MatchInfo {
  MatchCd? cd;
  String? cmd;
  String? ctsp;
  String? ld;

  MatchInfo();

  factory MatchInfo.fromJson(Map<String, dynamic> json) =>
      $MatchInfoFromJson(json);

  Map<String, dynamic> toJson() => $MatchInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class MatchCd {
  int? csid;
  String? mid;
  int? ms;
  int? mst;
  String? cmec;
  int? cmes;
  String? mat;
  String? mmp;
  int? mess;
  String? mct;
  String? mbhn;
  String? mbkn;
  String? mbcn;
  String? mbolp;
  String? mbtlp;
  String? mbthlp;
  String? mststs;
  int? mststi;
  int? mhs;
  String? mvs;
  int? mms;
  List<MatchCdVdo>? vdo;
  String? hpid;
  int? hs;
  String? hid;
  String? hmgt;
  String? hmed;
  int? mc;
  String? ld;
  String? marketLevel;
  String? time;
  String? tid;
  List<MatchCdHls>? hls;
  List<String>? msc;

  MatchCd();

  factory MatchCd.fromJson(Map<String, dynamic> json) => $MatchCdFromJson(json);

  Map<String, dynamic> toJson() => $MatchCdToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class MatchCdVdo {
  String? sid;
  String? sms;
  String? sts;

  MatchCdVdo();

  factory MatchCdVdo.fromJson(Map<String, dynamic> json) =>
      $MatchCdVdoFromJson(json);

  Map<String, dynamic> toJson() => $MatchCdVdoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class MatchCdHls {
  String? hid;
  int? hmt;
  int? hn;
  String? hpid;
  int? hs;
  String? mid;
  List<MatchCdHlsOl>? ol;
  String? t;

  MatchCdHls();

  factory MatchCdHls.fromJson(Map<String, dynamic> json) =>
      $MatchCdHlsFromJson(json);

  Map<String, dynamic> toJson() => $MatchCdHlsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class MatchCdHlsOl {
  String? obv;
  String? oid;
  int? os;
  String? ot;
  String? ov;

  MatchCdHlsOl();

  factory MatchCdHlsOl.fromJson(Map<String, dynamic> json) =>
      $MatchCdHlsOlFromJson(json);

  Map<String, dynamic> toJson() => $MatchCdHlsOlToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
