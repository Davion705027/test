import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_match_result_entity.dart';

GetMatchResultEntity $GetMatchResultEntityFromJson(Map<String, dynamic> json) {
  final GetMatchResultEntity getMatchResultEntity = GetMatchResultEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getMatchResultEntity.code = code;
  }
  final List<GetMatchResultData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetMatchResultData>(e) as GetMatchResultData)
      .toList();
  if (data != null) {
    getMatchResultEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getMatchResultEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getMatchResultEntity.ts = ts;
  }
  return getMatchResultEntity;
}

Map<String, dynamic> $GetMatchResultEntityToJson(GetMatchResultEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetMatchResultEntityExtension on GetMatchResultEntity {
  GetMatchResultEntity copyWith({
    String? code,
    List<GetMatchResultData>? data,
    String? msg,
    int? ts,
  }) {
    return GetMatchResultEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetMatchResultData $GetMatchResultDataFromJson(Map<String, dynamic> json) {
  final GetMatchResultData getMatchResultData = GetMatchResultData();
  final List<GetMatchResultDataHl>? hl = (json['hl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetMatchResultDataHl>(e) as GetMatchResultDataHl)
      .toList();
  if (hl != null) {
    getMatchResultData.hl = hl;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    getMatchResultData.hpn = hpn;
  }
  final String? topKey = jsonConvert.convert<String>(json['topKey']);
  if (topKey != null) {
    getMatchResultData.topKey = topKey;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    getMatchResultData.mid = mid;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    getMatchResultData.hmm = hmm;
  }
  final String? hps = jsonConvert.convert<String>(json['hps']);
  if (hps != null) {
    getMatchResultData.hps = hps;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    getMatchResultData.hshow = hshow;
  }
  final List<GetMatchResultDataTitle>? title = (json['title'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetMatchResultDataTitle>(
          e) as GetMatchResultDataTitle)
      .toList();
  if (title != null) {
    getMatchResultData.title = title;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    getMatchResultData.hpt = hpt;
  }
  final String? hlid = jsonConvert.convert<String>(json['hlid']);
  if (hlid != null) {
    getMatchResultData.hlid = hlid;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    getMatchResultData.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    getMatchResultData.hpon = hpon;
  }
  final String? hton = jsonConvert.convert<String>(json['hton']);
  if (hton != null) {
    getMatchResultData.hton = hton;
  }
  final bool? isExpand = jsonConvert.convert<bool>(json['isExpand']);
  if (isExpand != null) {
    getMatchResultData.isExpand = isExpand;
  }
  return getMatchResultData;
}

Map<String, dynamic> $GetMatchResultDataToJson(GetMatchResultData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hl'] = entity.hl.map((v) => v.toJson()).toList();
  data['hpn'] = entity.hpn;
  data['topKey'] = entity.topKey;
  data['mid'] = entity.mid;
  data['hmm'] = entity.hmm;
  data['hps'] = entity.hps;
  data['hshow'] = entity.hshow;
  data['title'] = entity.title.map((v) => v.toJson()).toList();
  data['hpt'] = entity.hpt;
  data['hlid'] = entity.hlid;
  data['hpid'] = entity.hpid;
  data['hpon'] = entity.hpon;
  data['hton'] = entity.hton;
  data['isExpand'] = entity.isExpand;
  return data;
}

extension GetMatchResultDataExtension on GetMatchResultData {
  GetMatchResultData copyWith({
    List<GetMatchResultDataHl>? hl,
    String? hpn,
    String? topKey,
    String? mid,
    int? hmm,
    String? hps,
    String? hshow,
    List<GetMatchResultDataTitle>? title,
    int? hpt,
    String? hlid,
    String? hpid,
    int? hpon,
    String? hton,
    bool? isExpand,
  }) {
    return GetMatchResultData()
      ..hl = hl ?? this.hl
      ..hpn = hpn ?? this.hpn
      ..topKey = topKey ?? this.topKey
      ..mid = mid ?? this.mid
      ..hmm = hmm ?? this.hmm
      ..hps = hps ?? this.hps
      ..hshow = hshow ?? this.hshow
      ..title = title ?? this.title
      ..hpt = hpt ?? this.hpt
      ..hlid = hlid ?? this.hlid
      ..hpid = hpid ?? this.hpid
      ..hpon = hpon ?? this.hpon
      ..hton = hton ?? this.hton
      ..isExpand = isExpand ?? this.isExpand;
  }
}

GetMatchResultDataHl $GetMatchResultDataHlFromJson(Map<String, dynamic> json) {
  final GetMatchResultDataHl getMatchResultDataHl = GetMatchResultDataHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    getMatchResultDataHl.hid = hid;
  }
  final List<GetMatchResultDataHlOl>? ol = (json['ol'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetMatchResultDataHlOl>(e) as GetMatchResultDataHlOl)
      .toList();
  if (ol != null) {
    getMatchResultDataHl.ol = ol;
  }
  final String? hv = jsonConvert.convert<String>(json['hv']);
  if (hv != null) {
    getMatchResultDataHl.hv = hv;
  }
  final String? ad2 = jsonConvert.convert<String>(json['ad2']);
  if (ad2 != null) {
    getMatchResultDataHl.ad2 = ad2;
  }
  final String? ad1 = jsonConvert.convert<String>(json['ad1']);
  if (ad1 != null) {
    getMatchResultDataHl.ad1 = ad1;
  }
  return getMatchResultDataHl;
}

Map<String, dynamic> $GetMatchResultDataHlToJson(GetMatchResultDataHl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hid'] = entity.hid;
  data['ol'] = entity.ol.map((v) => v.toJson()).toList();
  data['hv'] = entity.hv;
  data['ad2'] = entity.ad2;
  data['ad1'] = entity.ad1;
  return data;
}

extension GetMatchResultDataHlExtension on GetMatchResultDataHl {
  GetMatchResultDataHl copyWith({
    String? hid,
    List<GetMatchResultDataHlOl>? ol,
    String? hv,
    String? ad2,
    String? ad1,
  }) {
    return GetMatchResultDataHl()
      ..hid = hid ?? this.hid
      ..ol = ol ?? this.ol
      ..hv = hv ?? this.hv
      ..ad2 = ad2 ?? this.ad2
      ..ad1 = ad1 ?? this.ad1;
  }
}

GetMatchResultDataHlOl $GetMatchResultDataHlOlFromJson(
    Map<String, dynamic> json) {
  final GetMatchResultDataHlOl getMatchResultDataHlOl = GetMatchResultDataHlOl();
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    getMatchResultDataHlOl.result = result;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    getMatchResultDataHlOl.ot = ot;
  }
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    getMatchResultDataHlOl.oid = oid;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    getMatchResultDataHlOl.otd = otd;
  }
  final String? ott = jsonConvert.convert<String>(json['ott']);
  if (ott != null) {
    getMatchResultDataHlOl.ott = ott;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    getMatchResultDataHlOl.on = on;
  }
  return getMatchResultDataHlOl;
}

Map<String, dynamic> $GetMatchResultDataHlOlToJson(
    GetMatchResultDataHlOl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result;
  data['ot'] = entity.ot;
  data['oid'] = entity.oid;
  data['otd'] = entity.otd;
  data['ott'] = entity.ott;
  data['on'] = entity.on;
  return data;
}

extension GetMatchResultDataHlOlExtension on GetMatchResultDataHlOl {
  GetMatchResultDataHlOl copyWith({
    int? result,
    String? ot,
    String? oid,
    int? otd,
    String? ott,
    String? on,
  }) {
    return GetMatchResultDataHlOl()
      ..result = result ?? this.result
      ..ot = ot ?? this.ot
      ..oid = oid ?? this.oid
      ..otd = otd ?? this.otd
      ..ott = ott ?? this.ott
      ..on = on ?? this.on;
  }
}

GetMatchResultDataTitle $GetMatchResultDataTitleFromJson(
    Map<String, dynamic> json) {
  final GetMatchResultDataTitle getMatchResultDataTitle = GetMatchResultDataTitle();
  final String? osn = jsonConvert.convert<String>(json['osn']);
  if (osn != null) {
    getMatchResultDataTitle.osn = osn;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    getMatchResultDataTitle.otd = otd;
  }
  return getMatchResultDataTitle;
}

Map<String, dynamic> $GetMatchResultDataTitleToJson(
    GetMatchResultDataTitle entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['osn'] = entity.osn;
  data['otd'] = entity.otd;
  return data;
}

extension GetMatchResultDataTitleExtension on GetMatchResultDataTitle {
  GetMatchResultDataTitle copyWith({
    String? osn,
    int? otd,
  }) {
    return GetMatchResultDataTitle()
      ..osn = osn ?? this.osn
      ..otd = otd ?? this.otd;
  }
}