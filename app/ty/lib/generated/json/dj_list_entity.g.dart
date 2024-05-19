import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_list_entity.dart';

DjListEntity $DjListEntityFromJson(Map<String, dynamic> json) {
  final DjListEntity djListEntity = DjListEntity();
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    djListEntity.mid = mid;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    djListEntity.mess = mess;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    djListEntity.csna = csna;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    djListEntity.tid = tid;
  }
  final String? vurl = jsonConvert.convert<String>(json['vurl']);
  if (vurl != null) {
    djListEntity.vurl = vurl;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    djListEntity.mst = mst;
  }
  final int? mmp = jsonConvert.convert<int>(json['mmp']);
  if (mmp != null) {
    djListEntity.mmp = mmp;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    djListEntity.mms = mms;
  }
  final String? varl = jsonConvert.convert<String>(json['varl']);
  if (varl != null) {
    djListEntity.varl = varl;
  }
  final int? mc = jsonConvert.convert<int>(json['mc']);
  if (mc != null) {
    djListEntity.mc = mc;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    djListEntity.mhlu = mhlu;
  }
  final int? ispo = jsonConvert.convert<int>(json['ispo']);
  if (ispo != null) {
    djListEntity.ispo = ispo;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    djListEntity.mf = mf;
  }
  final int? mgt = jsonConvert.convert<int>(json['mgt']);
  if (mgt != null) {
    djListEntity.mgt = mgt;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    djListEntity.man = man;
  }
  final List<String>? frman = (json['frman'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frman != null) {
    djListEntity.frman = frman;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    djListEntity.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    djListEntity.ms = ms;
  }
  final List<DjListHps>? hps = (json['hps'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<DjListHps>(e) as DjListHps).toList();
  if (hps != null) {
    djListEntity.hps = hps;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    djListEntity.malu = malu;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    djListEntity.mhn = mhn;
  }
  final bool? tf = jsonConvert.convert<bool>(json['tf']);
  if (tf != null) {
    djListEntity.tf = tf;
  }
  final List<String>? frmhn = (json['frmhn'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frmhn != null) {
    djListEntity.frmhn = frmhn;
  }
  final String? mfo = jsonConvert.convert<String>(json['mfo']);
  if (mfo != null) {
    djListEntity.mfo = mfo;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    djListEntity.mhs = mhs;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    djListEntity.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    djListEntity.msc = msc;
  }
  return djListEntity;
}

Map<String, dynamic> $DjListEntityToJson(DjListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mid'] = entity.mid;
  data['mess'] = entity.mess;
  data['csna'] = entity.csna;
  data['tid'] = entity.tid;
  data['vurl'] = entity.vurl;
  data['mst'] = entity.mst;
  data['mmp'] = entity.mmp;
  data['mms'] = entity.mms;
  data['varl'] = entity.varl;
  data['mc'] = entity.mc;
  data['mhlu'] = entity.mhlu;
  data['ispo'] = entity.ispo;
  data['mf'] = entity.mf;
  data['mgt'] = entity.mgt;
  data['man'] = entity.man;
  data['frman'] = entity.frman;
  data['csid'] = entity.csid;
  data['ms'] = entity.ms;
  data['hps'] = entity.hps.map((v) => v.toJson()).toList();
  data['malu'] = entity.malu;
  data['mhn'] = entity.mhn;
  data['tf'] = entity.tf;
  data['frmhn'] = entity.frmhn;
  data['mfo'] = entity.mfo;
  data['mhs'] = entity.mhs;
  data['tn'] = entity.tn;
  data['msc'] = entity.msc;
  return data;
}

extension DjListEntityExtension on DjListEntity {
  DjListEntity copyWith({
    String? mid,
    int? mess,
    String? csna,
    String? tid,
    String? vurl,
    String? mst,
    int? mmp,
    int? mms,
    String? varl,
    int? mc,
    List<String>? mhlu,
    int? ispo,
    bool? mf,
    int? mgt,
    String? man,
    List<String>? frman,
    String? csid,
    int? ms,
    List<DjListHps>? hps,
    List<String>? malu,
    String? mhn,
    bool? tf,
    List<String>? frmhn,
    String? mfo,
    int? mhs,
    String? tn,
    List<String>? msc,
    bool? isCollection,
    bool? isExpand,
  }) {
    return DjListEntity()
      ..mid = mid ?? this.mid
      ..mess = mess ?? this.mess
      ..csna = csna ?? this.csna
      ..tid = tid ?? this.tid
      ..vurl = vurl ?? this.vurl
      ..mst = mst ?? this.mst
      ..mmp = mmp ?? this.mmp
      ..mms = mms ?? this.mms
      ..varl = varl ?? this.varl
      ..mc = mc ?? this.mc
      ..mhlu = mhlu ?? this.mhlu
      ..ispo = ispo ?? this.ispo
      ..mf = mf ?? this.mf
      ..mgt = mgt ?? this.mgt
      ..man = man ?? this.man
      ..frman = frman ?? this.frman
      ..csid = csid ?? this.csid
      ..ms = ms ?? this.ms
      ..hps = hps ?? this.hps
      ..malu = malu ?? this.malu
      ..mhn = mhn ?? this.mhn
      ..tf = tf ?? this.tf
      ..frmhn = frmhn ?? this.frmhn
      ..mfo = mfo ?? this.mfo
      ..mhs = mhs ?? this.mhs
      ..tn = tn ?? this.tn
      ..msc = msc ?? this.msc
      ..isCollection = isCollection ?? this.isCollection
      ..isExpand = isExpand ?? this.isExpand;
  }
}

DjListHps $DjListHpsFromJson(Map<String, dynamic> json) {
  final DjListHps djListHps = DjListHps();
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    djListHps.hpid = hpid;
  }
  final List<DjListHpsHl>? hl = (json['hl'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<DjListHpsHl>(e) as DjListHpsHl).toList();
  if (hl != null) {
    djListHps.hl = hl;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    djListHps.hpon = hpon;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    djListHps.hpn = hpn;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    djListHps.mid = mid;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    djListHps.hmm = hmm;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    djListHps.hshow = hshow;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    djListHps.hsw = hsw;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    djListHps.hpt = hpt;
  }
  return djListHps;
}

Map<String, dynamic> $DjListHpsToJson(DjListHps entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hpid'] = entity.hpid;
  data['hl'] = entity.hl.map((v) => v.toJson()).toList();
  data['hpon'] = entity.hpon;
  data['hpn'] = entity.hpn;
  data['mid'] = entity.mid;
  data['hmm'] = entity.hmm;
  data['hshow'] = entity.hshow;
  data['hsw'] = entity.hsw;
  data['hpt'] = entity.hpt;
  return data;
}

extension DjListHpsExtension on DjListHps {
  DjListHps copyWith({
    String? hpid,
    List<DjListHpsHl>? hl,
    int? hpon,
    String? hpn,
    String? mid,
    int? hmm,
    String? hshow,
    String? hsw,
    int? hpt,
  }) {
    return DjListHps()
      ..hpid = hpid ?? this.hpid
      ..hl = hl ?? this.hl
      ..hpon = hpon ?? this.hpon
      ..hpn = hpn ?? this.hpn
      ..mid = mid ?? this.mid
      ..hmm = hmm ?? this.hmm
      ..hshow = hshow ?? this.hshow
      ..hsw = hsw ?? this.hsw
      ..hpt = hpt ?? this.hpt;
  }
}

DjListHpsHl $DjListHpsHlFromJson(Map<String, dynamic> json) {
  final DjListHpsHl djListHpsHl = DjListHpsHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    djListHpsHl.hid = hid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    djListHpsHl.hs = hs;
  }
  final dynamic hv = json['hv'];
  if (hv != null) {
    djListHpsHl.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    djListHpsHl.hmt = hmt;
  }
  final int? hn = jsonConvert.convert<int>(json['hn']);
  if (hn != null) {
    djListHpsHl.hn = hn;
  }
  final int? hipo = jsonConvert.convert<int>(json['hipo']);
  if (hipo != null) {
    djListHpsHl.hipo = hipo;
  }
  final List<DjListHpsHlOl>? ol = (json['ol'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<DjListHpsHlOl>(e) as DjListHpsHlOl)
      .toList();
  if (ol != null) {
    djListHpsHl.ol = ol;
  }
  return djListHpsHl;
}

Map<String, dynamic> $DjListHpsHlToJson(DjListHpsHl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hid'] = entity.hid;
  data['hs'] = entity.hs;
  data['hv'] = entity.hv;
  data['hmt'] = entity.hmt;
  data['hn'] = entity.hn;
  data['hipo'] = entity.hipo;
  data['ol'] = entity.ol?.map((v) => v.toJson()).toList();
  return data;
}

extension DjListHpsHlExtension on DjListHpsHl {
  DjListHpsHl copyWith({
    String? hid,
    int? hs,
    dynamic hv,
    int? hmt,
    int? hn,
    int? hipo,
    List<DjListHpsHlOl>? ol,
  }) {
    return DjListHpsHl()
      ..hid = hid ?? this.hid
      ..hs = hs ?? this.hs
      ..hv = hv ?? this.hv
      ..hmt = hmt ?? this.hmt
      ..hn = hn ?? this.hn
      ..hipo = hipo ?? this.hipo
      ..ol = ol ?? this.ol;
  }
}

DjListHpsHlOl $DjListHpsHlOlFromJson(Map<String, dynamic> json) {
  final DjListHpsHlOl djListHpsHlOl = DjListHpsHlOl();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    djListHpsHlOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    djListHpsHlOl.os = os;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    djListHpsHlOl.otd = otd;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    djListHpsHlOl.ot = ot;
  }
  final int? ov = jsonConvert.convert<int>(json['ov']);
  if (ov != null) {
    djListHpsHlOl.ov = ov;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    djListHpsHlOl.on = on;
  }
  final String? onb = jsonConvert.convert<String>(json['onb']);
  if (onb != null) {
    djListHpsHlOl.onb = onb;
  }
  final dynamic cds = json['cds'];
  if (cds != null) {
    djListHpsHlOl.cds = cds;
  }
  final String? ots = jsonConvert.convert<String>(json['ots']);
  if (ots != null) {
    djListHpsHlOl.ots = ots;
  }
  return djListHpsHlOl;
}

Map<String, dynamic> $DjListHpsHlOlToJson(DjListHpsHlOl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['oid'] = entity.oid;
  data['os'] = entity.os;
  data['otd'] = entity.otd;
  data['ot'] = entity.ot;
  data['ov'] = entity.ov;
  data['on'] = entity.on;
  data['onb'] = entity.onb;
  data['cds'] = entity.cds;
  data['ots'] = entity.ots;
  return data;
}

extension DjListHpsHlOlExtension on DjListHpsHlOl {
  DjListHpsHlOl copyWith({
    String? oid,
    int? os,
    int? otd,
    String? ot,
    int? ov,
    String? on,
    String? onb,
    dynamic cds,
    String? ots,
  }) {
    return DjListHpsHlOl()
      ..oid = oid ?? this.oid
      ..os = os ?? this.os
      ..otd = otd ?? this.otd
      ..ot = ot ?? this.ot
      ..ov = ov ?? this.ov
      ..on = on ?? this.on
      ..onb = onb ?? this.onb
      ..cds = cds ?? this.cds
      ..ots = ots ?? this.ots;
  }
}