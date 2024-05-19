import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_info.dart';

MatchInfo $MatchInfoFromJson(Map<String, dynamic> json) {
  final MatchInfo matchInfo = MatchInfo();
  final MatchCd? cd = jsonConvert.convert<MatchCd>(json['cd']);
  if (cd != null) {
    matchInfo.cd = cd;
  }
  final String? cmd = jsonConvert.convert<String>(json['cmd']);
  if (cmd != null) {
    matchInfo.cmd = cmd;
  }
  final String? ctsp = jsonConvert.convert<String>(json['ctsp']);
  if (ctsp != null) {
    matchInfo.ctsp = ctsp;
  }
  final String? ld = jsonConvert.convert<String>(json['ld']);
  if (ld != null) {
    matchInfo.ld = ld;
  }
  return matchInfo;
}

Map<String, dynamic> $MatchInfoToJson(MatchInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['cd'] = entity.cd?.toJson();
  data['cmd'] = entity.cmd;
  data['ctsp'] = entity.ctsp;
  data['ld'] = entity.ld;
  return data;
}

extension MatchInfoExtension on MatchInfo {
  MatchInfo copyWith({
    MatchCd? cd,
    String? cmd,
    String? ctsp,
    String? ld,
  }) {
    return MatchInfo()
      ..cd = cd ?? this.cd
      ..cmd = cmd ?? this.cmd
      ..ctsp = ctsp ?? this.ctsp
      ..ld = ld ?? this.ld;
  }
}

MatchCd $MatchCdFromJson(Map<String, dynamic> json) {
  final MatchCd matchCd = MatchCd();
  final int? csid = jsonConvert.convert<int>(json['csid']);
  if (csid != null) {
    matchCd.csid = csid;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchCd.mid = mid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    matchCd.ms = ms;
  }
  final int? mst = jsonConvert.convert<int>(json['mst']);
  if (mst != null) {
    matchCd.mst = mst;
  }
  final String? cmec = jsonConvert.convert<String>(json['cmec']);
  if (cmec != null) {
    matchCd.cmec = cmec;
  }
  final int? cmes = jsonConvert.convert<int>(json['cmes']);
  if (cmes != null) {
    matchCd.cmes = cmes;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    matchCd.mat = mat;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    matchCd.mmp = mmp;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    matchCd.mess = mess;
  }
  final String? mct = jsonConvert.convert<String>(json['mct']);
  if (mct != null) {
    matchCd.mct = mct;
  }
  final String? mbhn = jsonConvert.convert<String>(json['mbhn']);
  if (mbhn != null) {
    matchCd.mbhn = mbhn;
  }
  final String? mbkn = jsonConvert.convert<String>(json['mbkn']);
  if (mbkn != null) {
    matchCd.mbkn = mbkn;
  }
  final String? mbcn = jsonConvert.convert<String>(json['mbcn']);
  if (mbcn != null) {
    matchCd.mbcn = mbcn;
  }
  final String? mbolp = jsonConvert.convert<String>(json['mbolp']);
  if (mbolp != null) {
    matchCd.mbolp = mbolp;
  }
  final String? mbtlp = jsonConvert.convert<String>(json['mbtlp']);
  if (mbtlp != null) {
    matchCd.mbtlp = mbtlp;
  }
  final String? mbthlp = jsonConvert.convert<String>(json['mbthlp']);
  if (mbthlp != null) {
    matchCd.mbthlp = mbthlp;
  }
  final String? mststs = jsonConvert.convert<String>(json['mststs']);
  if (mststs != null) {
    matchCd.mststs = mststs;
  }
  final int? mststi = jsonConvert.convert<int>(json['mststi']);
  if (mststi != null) {
    matchCd.mststi = mststi;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    matchCd.mhs = mhs;
  }
  final String? mvs = jsonConvert.convert<String>(json['mvs']);
  if (mvs != null) {
    matchCd.mvs = mvs;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    matchCd.mms = mms;
  }
  final List<MatchCdVdo>? vdo = (json['vdo'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MatchCdVdo>(e) as MatchCdVdo).toList();
  if (vdo != null) {
    matchCd.vdo = vdo;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    matchCd.hpid = hpid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    matchCd.hs = hs;
  }
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    matchCd.hid = hid;
  }
  final String? hmgt = jsonConvert.convert<String>(json['hmgt']);
  if (hmgt != null) {
    matchCd.hmgt = hmgt;
  }
  final String? hmed = jsonConvert.convert<String>(json['hmed']);
  if (hmed != null) {
    matchCd.hmed = hmed;
  }
  final int? mc = jsonConvert.convert<int>(json['mc']);
  if (mc != null) {
    matchCd.mc = mc;
  }
  final String? ld = jsonConvert.convert<String>(json['ld']);
  if (ld != null) {
    matchCd.ld = ld;
  }
  final String? marketLevel = jsonConvert.convert<String>(json['marketLevel']);
  if (marketLevel != null) {
    matchCd.marketLevel = marketLevel;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    matchCd.time = time;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    matchCd.tid = tid;
  }
  final List<MatchCdHls>? hls = (json['hls'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MatchCdHls>(e) as MatchCdHls).toList();
  if (hls != null) {
    matchCd.hls = hls;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    matchCd.msc = msc;
  }
  return matchCd;
}

Map<String, dynamic> $MatchCdToJson(MatchCd entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['csid'] = entity.csid;
  data['mid'] = entity.mid;
  data['ms'] = entity.ms;
  data['mst'] = entity.mst;
  data['cmec'] = entity.cmec;
  data['cmes'] = entity.cmes;
  data['mat'] = entity.mat;
  data['mmp'] = entity.mmp;
  data['mess'] = entity.mess;
  data['mct'] = entity.mct;
  data['mbhn'] = entity.mbhn;
  data['mbkn'] = entity.mbkn;
  data['mbcn'] = entity.mbcn;
  data['mbolp'] = entity.mbolp;
  data['mbtlp'] = entity.mbtlp;
  data['mbthlp'] = entity.mbthlp;
  data['mststs'] = entity.mststs;
  data['mststi'] = entity.mststi;
  data['mhs'] = entity.mhs;
  data['mvs'] = entity.mvs;
  data['mms'] = entity.mms;
  data['vdo'] = entity.vdo?.map((v) => v.toJson()).toList();
  data['hpid'] = entity.hpid;
  data['hs'] = entity.hs;
  data['hid'] = entity.hid;
  data['hmgt'] = entity.hmgt;
  data['hmed'] = entity.hmed;
  data['mc'] = entity.mc;
  data['ld'] = entity.ld;
  data['marketLevel'] = entity.marketLevel;
  data['time'] = entity.time;
  data['tid'] = entity.tid;
  data['hls'] = entity.hls?.map((v) => v.toJson()).toList();
  data['msc'] = entity.msc;
  return data;
}

extension MatchCdExtension on MatchCd {
  MatchCd copyWith({
    int? csid,
    String? mid,
    int? ms,
    int? mst,
    String? cmec,
    int? cmes,
    String? mat,
    String? mmp,
    int? mess,
    String? mct,
    String? mbhn,
    String? mbkn,
    String? mbcn,
    String? mbolp,
    String? mbtlp,
    String? mbthlp,
    String? mststs,
    int? mststi,
    int? mhs,
    String? mvs,
    int? mms,
    List<MatchCdVdo>? vdo,
    String? hpid,
    int? hs,
    String? hid,
    String? hmgt,
    String? hmed,
    int? mc,
    String? ld,
    String? marketLevel,
    String? time,
    String? tid,
    List<MatchCdHls>? hls,
    List<String>? msc,
  }) {
    return MatchCd()
      ..csid = csid ?? this.csid
      ..mid = mid ?? this.mid
      ..ms = ms ?? this.ms
      ..mst = mst ?? this.mst
      ..cmec = cmec ?? this.cmec
      ..cmes = cmes ?? this.cmes
      ..mat = mat ?? this.mat
      ..mmp = mmp ?? this.mmp
      ..mess = mess ?? this.mess
      ..mct = mct ?? this.mct
      ..mbhn = mbhn ?? this.mbhn
      ..mbkn = mbkn ?? this.mbkn
      ..mbcn = mbcn ?? this.mbcn
      ..mbolp = mbolp ?? this.mbolp
      ..mbtlp = mbtlp ?? this.mbtlp
      ..mbthlp = mbthlp ?? this.mbthlp
      ..mststs = mststs ?? this.mststs
      ..mststi = mststi ?? this.mststi
      ..mhs = mhs ?? this.mhs
      ..mvs = mvs ?? this.mvs
      ..mms = mms ?? this.mms
      ..vdo = vdo ?? this.vdo
      ..hpid = hpid ?? this.hpid
      ..hs = hs ?? this.hs
      ..hid = hid ?? this.hid
      ..hmgt = hmgt ?? this.hmgt
      ..hmed = hmed ?? this.hmed
      ..mc = mc ?? this.mc
      ..ld = ld ?? this.ld
      ..marketLevel = marketLevel ?? this.marketLevel
      ..time = time ?? this.time
      ..tid = tid ?? this.tid
      ..hls = hls ?? this.hls
      ..msc = msc ?? this.msc;
  }
}

MatchCdVdo $MatchCdVdoFromJson(Map<String, dynamic> json) {
  final MatchCdVdo matchCdVdo = MatchCdVdo();
  final String? sid = jsonConvert.convert<String>(json['sid']);
  if (sid != null) {
    matchCdVdo.sid = sid;
  }
  final String? sms = jsonConvert.convert<String>(json['sms']);
  if (sms != null) {
    matchCdVdo.sms = sms;
  }
  final String? sts = jsonConvert.convert<String>(json['sts']);
  if (sts != null) {
    matchCdVdo.sts = sts;
  }
  return matchCdVdo;
}

Map<String, dynamic> $MatchCdVdoToJson(MatchCdVdo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['sid'] = entity.sid;
  data['sms'] = entity.sms;
  data['sts'] = entity.sts;
  return data;
}

extension MatchCdVdoExtension on MatchCdVdo {
  MatchCdVdo copyWith({
    String? sid,
    String? sms,
    String? sts,
  }) {
    return MatchCdVdo()
      ..sid = sid ?? this.sid
      ..sms = sms ?? this.sms
      ..sts = sts ?? this.sts;
  }
}

MatchCdHls $MatchCdHlsFromJson(Map<String, dynamic> json) {
  final MatchCdHls matchCdHls = MatchCdHls();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    matchCdHls.hid = hid;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    matchCdHls.hmt = hmt;
  }
  final int? hn = jsonConvert.convert<int>(json['hn']);
  if (hn != null) {
    matchCdHls.hn = hn;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    matchCdHls.hpid = hpid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    matchCdHls.hs = hs;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchCdHls.mid = mid;
  }
  final List<MatchCdHlsOl>? ol = (json['ol'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MatchCdHlsOl>(e) as MatchCdHlsOl).toList();
  if (ol != null) {
    matchCdHls.ol = ol;
  }
  final String? t = jsonConvert.convert<String>(json['t']);
  if (t != null) {
    matchCdHls.t = t;
  }
  return matchCdHls;
}

Map<String, dynamic> $MatchCdHlsToJson(MatchCdHls entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hid'] = entity.hid;
  data['hmt'] = entity.hmt;
  data['hn'] = entity.hn;
  data['hpid'] = entity.hpid;
  data['hs'] = entity.hs;
  data['mid'] = entity.mid;
  data['ol'] = entity.ol?.map((v) => v.toJson()).toList();
  data['t'] = entity.t;
  return data;
}

extension MatchCdHlsExtension on MatchCdHls {
  MatchCdHls copyWith({
    String? hid,
    int? hmt,
    int? hn,
    String? hpid,
    int? hs,
    String? mid,
    List<MatchCdHlsOl>? ol,
    String? t,
  }) {
    return MatchCdHls()
      ..hid = hid ?? this.hid
      ..hmt = hmt ?? this.hmt
      ..hn = hn ?? this.hn
      ..hpid = hpid ?? this.hpid
      ..hs = hs ?? this.hs
      ..mid = mid ?? this.mid
      ..ol = ol ?? this.ol
      ..t = t ?? this.t;
  }
}

MatchCdHlsOl $MatchCdHlsOlFromJson(Map<String, dynamic> json) {
  final MatchCdHlsOl matchCdHlsOl = MatchCdHlsOl();
  final String? obv = jsonConvert.convert<String>(json['obv']);
  if (obv != null) {
    matchCdHlsOl.obv = obv;
  }
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    matchCdHlsOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    matchCdHlsOl.os = os;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    matchCdHlsOl.ot = ot;
  }
  final String? ov = jsonConvert.convert<String>(json['ov']);
  if (ov != null) {
    matchCdHlsOl.ov = ov;
  }
  return matchCdHlsOl;
}

Map<String, dynamic> $MatchCdHlsOlToJson(MatchCdHlsOl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['obv'] = entity.obv;
  data['oid'] = entity.oid;
  data['os'] = entity.os;
  data['ot'] = entity.ot;
  data['ov'] = entity.ov;
  return data;
}

extension MatchCdHlsOlExtension on MatchCdHlsOl {
  MatchCdHlsOl copyWith({
    String? obv,
    String? oid,
    int? os,
    String? ot,
    String? ov,
  }) {
    return MatchCdHlsOl()
      ..obv = obv ?? this.obv
      ..oid = oid ?? this.oid
      ..os = os ?? this.os
      ..ot = ot ?? this.ot
      ..ov = ov ?? this.ov;
  }
}