import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/matche_handpick_entity.dart';

MatcheHandpickEntity $MatcheHandpickEntityFromJson(Map<String, dynamic> json) {
  final MatcheHandpickEntity matcheHandpickEntity = MatcheHandpickEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matcheHandpickEntity.code = code;
  }
  final List<MatcheHandpickData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatcheHandpickData>(e) as MatcheHandpickData)
      .toList();
  if (data != null) {
    matcheHandpickEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matcheHandpickEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matcheHandpickEntity.ts = ts;
  }
  return matcheHandpickEntity;
}

Map<String, dynamic> $MatcheHandpickEntityToJson(MatcheHandpickEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatcheHandpickEntityExtension on MatcheHandpickEntity {
  MatcheHandpickEntity copyWith({
    String? code,
    List<MatcheHandpickData>? data,
    String? msg,
    int? ts,
  }) {
    return MatcheHandpickEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatcheHandpickData $MatcheHandpickDataFromJson(Map<String, dynamic> json) {
  final MatcheHandpickData matcheHandpickData = MatcheHandpickData();
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    matcheHandpickData.tnjc = tnjc;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    matcheHandpickData.csna = csna;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    matcheHandpickData.tid = tid;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    matcheHandpickData.mst = mst;
  }
  final String? srid = jsonConvert.convert<String>(json['srid']);
  if (srid != null) {
    matcheHandpickData.srid = srid;
  }
  final int? mcg = jsonConvert.convert<int>(json['mcg']);
  if (mcg != null) {
    matcheHandpickData.mcg = mcg;
  }
  final int? atf = jsonConvert.convert<int>(json['atf']);
  if (atf != null) {
    matcheHandpickData.atf = atf;
  }
  final dynamic mdsc = json['mdsc'];
  if (mdsc != null) {
    matcheHandpickData.mdsc = mdsc;
  }
  final int? gcs = jsonConvert.convert<int>(json['gcs']);
  if (gcs != null) {
    matcheHandpickData.gcs = gcs;
  }
  final int? mc = jsonConvert.convert<int>(json['mc']);
  if (mc != null) {
    matcheHandpickData.mc = mc;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    matcheHandpickData.mf = mf;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    matcheHandpickData.mgt = mgt;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    matcheHandpickData.maid = maid;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    matcheHandpickData.mct = mct;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    matcheHandpickData.tlev = tlev;
  }
  final String? mhlut = jsonConvert.convert<String>(json['mhlut']);
  if (mhlut != null) {
    matcheHandpickData.mhlut = mhlut;
  }
  final int? mo = jsonConvert.convert<int>(json['mo']);
  if (mo != null) {
    matcheHandpickData.mo = mo;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    matcheHandpickData.ctt = ctt;
  }
  final int? mp = jsonConvert.convert<int>(json['mp']);
  if (mp != null) {
    matcheHandpickData.mp = mp;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    matcheHandpickData.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    matcheHandpickData.ms = ms;
  }
  final dynamic cmec = json['cmec'];
  if (cmec != null) {
    matcheHandpickData.cmec = cmec;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    matcheHandpickData.mle = mle;
  }
  final int? lvs = jsonConvert.convert<int>(json['lvs']);
  if (lvs != null) {
    matcheHandpickData.lvs = lvs;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    matcheHandpickData.sort = sort;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    matcheHandpickData.malu = malu;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    matcheHandpickData.lurl = lurl;
  }
  final String? mprmc = jsonConvert.convert<String>(json['mprmc']);
  if (mprmc != null) {
    matcheHandpickData.mprmc = mprmc;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    matcheHandpickData.mhn = mhn;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matcheHandpickData.cds = cds;
  }
  final List<String>? frmhn = (json['frmhn'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frmhn != null) {
    matcheHandpickData.frmhn = frmhn;
  }
  final int? operationTournamentSort = jsonConvert.convert<int>(
      json['operationTournamentSort']);
  if (operationTournamentSort != null) {
    matcheHandpickData.operationTournamentSort = operationTournamentSort;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    matcheHandpickData.mhs = mhs;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    matcheHandpickData.mlet = mlet;
  }
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    matcheHandpickData.mhid = mhid;
  }
  final String? mrmc = jsonConvert.convert<String>(json['mrmc']);
  if (mrmc != null) {
    matcheHandpickData.mrmc = mrmc;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matcheHandpickData.mid = mid;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    matcheHandpickData.mess = mess;
  }
  final dynamic lss = json['lss'];
  if (lss != null) {
    matcheHandpickData.lss = lss;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    matcheHandpickData.mmp = mmp;
  }
  final String? mststi = jsonConvert.convert<String>(json['mststi']);
  if (mststi != null) {
    matcheHandpickData.mststi = mststi;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    matcheHandpickData.mms = mms;
  }
  final int? mbmty = jsonConvert.convert<int>(json['mbmty']);
  if (mbmty != null) {
    matcheHandpickData.mbmty = mbmty;
  }
  final int? pmms = jsonConvert.convert<int>(json['pmms']);
  if (pmms != null) {
    matcheHandpickData.pmms = pmms;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    matcheHandpickData.mhlu = mhlu;
  }
  final String? seid = jsonConvert.convert<String>(json['seid']);
  if (seid != null) {
    matcheHandpickData.seid = seid;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    matcheHandpickData.mstst = mstst;
  }
  final String? malut = jsonConvert.convert<String>(json['malut']);
  if (malut != null) {
    matcheHandpickData.malut = malut;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    matcheHandpickData.man = man;
  }
  final List<String>? frman = (json['frman'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frman != null) {
    matcheHandpickData.frman = frman;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    matcheHandpickData.mat = mat;
  }
  final int? mng = jsonConvert.convert<int>(json['mng']);
  if (mng != null) {
    matcheHandpickData.mng = mng;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    matcheHandpickData.mststr = mststr;
  }
  final List<MatcheHandpickDataHps>? hps = (json['hps'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatcheHandpickDataHps>(e) as MatcheHandpickDataHps)
      .toList();
  if (hps != null) {
    matcheHandpickData.hps = hps;
  }
  final int? mvs = jsonConvert.convert<int>(json['mvs']);
  if (mvs != null) {
    matcheHandpickData.mvs = mvs;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    matcheHandpickData.mststs = mststs;
  }
  final int? mearlys = jsonConvert.convert<int>(json['mearlys']);
  if (mearlys != null) {
    matcheHandpickData.mearlys = mearlys;
  }
  final dynamic mfo = json['mfo'];
  if (mfo != null) {
    matcheHandpickData.mfo = mfo;
  }
  final int? mft = jsonConvert.convert<int>(json['mft']);
  if (mft != null) {
    matcheHandpickData.mft = mft;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    matcheHandpickData.tn = tn;
  }
  final List<dynamic>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (msc != null) {
    matcheHandpickData.msc = msc;
  }
  return matcheHandpickData;
}

Map<String, dynamic> $MatcheHandpickDataToJson(MatcheHandpickData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tnjc'] = entity.tnjc;
  data['csna'] = entity.csna;
  data['tid'] = entity.tid;
  data['mst'] = entity.mst;
  data['srid'] = entity.srid;
  data['mcg'] = entity.mcg;
  data['atf'] = entity.atf;
  data['mdsc'] = entity.mdsc;
  data['gcs'] = entity.gcs;
  data['mc'] = entity.mc;
  data['mf'] = entity.mf;
  data['mgt'] = entity.mgt;
  data['maid'] = entity.maid;
  data['mct'] = entity.mct;
  data['tlev'] = entity.tlev;
  data['mhlut'] = entity.mhlut;
  data['mo'] = entity.mo;
  data['ctt'] = entity.ctt;
  data['mp'] = entity.mp;
  data['csid'] = entity.csid;
  data['ms'] = entity.ms;
  data['cmec'] = entity.cmec;
  data['mle'] = entity.mle;
  data['lvs'] = entity.lvs;
  data['sort'] = entity.sort;
  data['malu'] = entity.malu;
  data['lurl'] = entity.lurl;
  data['mprmc'] = entity.mprmc;
  data['mhn'] = entity.mhn;
  data['cds'] = entity.cds;
  data['frmhn'] = entity.frmhn;
  data['operationTournamentSort'] = entity.operationTournamentSort;
  data['mhs'] = entity.mhs;
  data['mlet'] = entity.mlet;
  data['mhid'] = entity.mhid;
  data['mrmc'] = entity.mrmc;
  data['mid'] = entity.mid;
  data['mess'] = entity.mess;
  data['lss'] = entity.lss;
  data['mmp'] = entity.mmp;
  data['mststi'] = entity.mststi;
  data['mms'] = entity.mms;
  data['mbmty'] = entity.mbmty;
  data['pmms'] = entity.pmms;
  data['mhlu'] = entity.mhlu;
  data['seid'] = entity.seid;
  data['mstst'] = entity.mstst;
  data['malut'] = entity.malut;
  data['man'] = entity.man;
  data['frman'] = entity.frman;
  data['mat'] = entity.mat;
  data['mng'] = entity.mng;
  data['mststr'] = entity.mststr;
  data['hps'] = entity.hps.map((v) => v.toJson()).toList();
  data['mvs'] = entity.mvs;
  data['mststs'] = entity.mststs;
  data['mearlys'] = entity.mearlys;
  data['mfo'] = entity.mfo;
  data['mft'] = entity.mft;
  data['tn'] = entity.tn;
  data['msc'] = entity.msc;
  return data;
}

extension MatcheHandpickDataExtension on MatcheHandpickData {
  MatcheHandpickData copyWith({
    String? tnjc,
    String? csna,
    String? tid,
    String? mst,
    String? srid,
    int? mcg,
    int? atf,
    dynamic mdsc,
    int? gcs,
    int? mc,
    bool? mf,
    String? mgt,
    String? maid,
    int? mct,
    int? tlev,
    String? mhlut,
    int? mo,
    int? ctt,
    int? mp,
    String? csid,
    int? ms,
    dynamic cmec,
    int? mle,
    int? lvs,
    int? sort,
    List<String>? malu,
    String? lurl,
    String? mprmc,
    String? mhn,
    String? cds,
    List<String>? frmhn,
    int? operationTournamentSort,
    int? mhs,
    String? mlet,
    String? mhid,
    String? mrmc,
    String? mid,
    int? mess,
    dynamic lss,
    String? mmp,
    String? mststi,
    int? mms,
    int? mbmty,
    int? pmms,
    List<String>? mhlu,
    String? seid,
    String? mstst,
    String? malut,
    String? man,
    List<String>? frman,
    String? mat,
    int? mng,
    String? mststr,
    List<MatcheHandpickDataHps>? hps,
    int? mvs,
    int? mststs,
    int? mearlys,
    dynamic mfo,
    int? mft,
    String? tn,
    List<dynamic>? msc,
  }) {
    return MatcheHandpickData()
      ..tnjc = tnjc ?? this.tnjc
      ..csna = csna ?? this.csna
      ..tid = tid ?? this.tid
      ..mst = mst ?? this.mst
      ..srid = srid ?? this.srid
      ..mcg = mcg ?? this.mcg
      ..atf = atf ?? this.atf
      ..mdsc = mdsc ?? this.mdsc
      ..gcs = gcs ?? this.gcs
      ..mc = mc ?? this.mc
      ..mf = mf ?? this.mf
      ..mgt = mgt ?? this.mgt
      ..maid = maid ?? this.maid
      ..mct = mct ?? this.mct
      ..tlev = tlev ?? this.tlev
      ..mhlut = mhlut ?? this.mhlut
      ..mo = mo ?? this.mo
      ..ctt = ctt ?? this.ctt
      ..mp = mp ?? this.mp
      ..csid = csid ?? this.csid
      ..ms = ms ?? this.ms
      ..cmec = cmec ?? this.cmec
      ..mle = mle ?? this.mle
      ..lvs = lvs ?? this.lvs
      ..sort = sort ?? this.sort
      ..malu = malu ?? this.malu
      ..lurl = lurl ?? this.lurl
      ..mprmc = mprmc ?? this.mprmc
      ..mhn = mhn ?? this.mhn
      ..cds = cds ?? this.cds
      ..frmhn = frmhn ?? this.frmhn
      ..operationTournamentSort = operationTournamentSort ??
          this.operationTournamentSort
      ..mhs = mhs ?? this.mhs
      ..mlet = mlet ?? this.mlet
      ..mhid = mhid ?? this.mhid
      ..mrmc = mrmc ?? this.mrmc
      ..mid = mid ?? this.mid
      ..mess = mess ?? this.mess
      ..lss = lss ?? this.lss
      ..mmp = mmp ?? this.mmp
      ..mststi = mststi ?? this.mststi
      ..mms = mms ?? this.mms
      ..mbmty = mbmty ?? this.mbmty
      ..pmms = pmms ?? this.pmms
      ..mhlu = mhlu ?? this.mhlu
      ..seid = seid ?? this.seid
      ..mstst = mstst ?? this.mstst
      ..malut = malut ?? this.malut
      ..man = man ?? this.man
      ..frman = frman ?? this.frman
      ..mat = mat ?? this.mat
      ..mng = mng ?? this.mng
      ..mststr = mststr ?? this.mststr
      ..hps = hps ?? this.hps
      ..mvs = mvs ?? this.mvs
      ..mststs = mststs ?? this.mststs
      ..mearlys = mearlys ?? this.mearlys
      ..mfo = mfo ?? this.mfo
      ..mft = mft ?? this.mft
      ..tn = tn ?? this.tn
      ..msc = msc ?? this.msc;
  }
}

MatcheHandpickDataHps $MatcheHandpickDataHpsFromJson(
    Map<String, dynamic> json) {
  final MatcheHandpickDataHps matcheHandpickDataHps = MatcheHandpickDataHps();
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matcheHandpickDataHps.mid = mid;
  }
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    matcheHandpickDataHps.chpid = chpid;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    matcheHandpickDataHps.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    matcheHandpickDataHps.hpon = hpon;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    matcheHandpickDataHps.hshow = hshow;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    matcheHandpickDataHps.hpn = hpn;
  }
  final String? hpnb = jsonConvert.convert<String>(json['hpnb']);
  if (hpnb != null) {
    matcheHandpickDataHps.hpnb = hpnb;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    matcheHandpickDataHps.hpt = hpt;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    matcheHandpickDataHps.hsw = hsw;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    matcheHandpickDataHps.hmm = hmm;
  }
  final int? hids = jsonConvert.convert<int>(json['hids']);
  if (hids != null) {
    matcheHandpickDataHps.hids = hids;
  }
  final List<MatcheHandpickDataHpsHl>? hl = (json['hl'] as List<dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MatcheHandpickDataHpsHl>(
          e) as MatcheHandpickDataHpsHl).toList();
  if (hl != null) {
    matcheHandpickDataHps.hl = hl;
  }
  return matcheHandpickDataHps;
}

Map<String, dynamic> $MatcheHandpickDataHpsToJson(
    MatcheHandpickDataHps entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mid'] = entity.mid;
  data['chpid'] = entity.chpid;
  data['hpid'] = entity.hpid;
  data['hpon'] = entity.hpon;
  data['hshow'] = entity.hshow;
  data['hpn'] = entity.hpn;
  data['hpnb'] = entity.hpnb;
  data['hpt'] = entity.hpt;
  data['hsw'] = entity.hsw;
  data['hmm'] = entity.hmm;
  data['hids'] = entity.hids;
  data['hl'] = entity.hl.map((v) => v.toJson()).toList();
  return data;
}

extension MatcheHandpickDataHpsExtension on MatcheHandpickDataHps {
  MatcheHandpickDataHps copyWith({
    String? mid,
    String? chpid,
    String? hpid,
    int? hpon,
    String? hshow,
    String? hpn,
    String? hpnb,
    int? hpt,
    String? hsw,
    int? hmm,
    int? hids,
    List<MatcheHandpickDataHpsHl>? hl,
  }) {
    return MatcheHandpickDataHps()
      ..mid = mid ?? this.mid
      ..chpid = chpid ?? this.chpid
      ..hpid = hpid ?? this.hpid
      ..hpon = hpon ?? this.hpon
      ..hshow = hshow ?? this.hshow
      ..hpn = hpn ?? this.hpn
      ..hpnb = hpnb ?? this.hpnb
      ..hpt = hpt ?? this.hpt
      ..hsw = hsw ?? this.hsw
      ..hmm = hmm ?? this.hmm
      ..hids = hids ?? this.hids
      ..hl = hl ?? this.hl;
  }
}

MatcheHandpickDataHpsHl $MatcheHandpickDataHpsHlFromJson(
    Map<String, dynamic> json) {
  final MatcheHandpickDataHpsHl matcheHandpickDataHpsHl = MatcheHandpickDataHpsHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    matcheHandpickDataHpsHl.hid = hid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    matcheHandpickDataHpsHl.hs = hs;
  }
  final String? hv = jsonConvert.convert<String>(json['hv']);
  if (hv != null) {
    matcheHandpickDataHpsHl.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    matcheHandpickDataHpsHl.hmt = hmt;
  }
  final int? hn = jsonConvert.convert<int>(json['hn']);
  if (hn != null) {
    matcheHandpickDataHpsHl.hn = hn;
  }
  final List<MatcheHandpickDataHpsHlOl>? ol = (json['ol'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatcheHandpickDataHpsHlOl>(
          e) as MatcheHandpickDataHpsHlOl)
      .toList();
  if (ol != null) {
    matcheHandpickDataHpsHl.ol = ol;
  }
  return matcheHandpickDataHpsHl;
}

Map<String, dynamic> $MatcheHandpickDataHpsHlToJson(
    MatcheHandpickDataHpsHl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hid'] = entity.hid;
  data['hs'] = entity.hs;
  data['hv'] = entity.hv;
  data['hmt'] = entity.hmt;
  data['hn'] = entity.hn;
  data['ol'] = entity.ol.map((v) => v.toJson()).toList();
  return data;
}

extension MatcheHandpickDataHpsHlExtension on MatcheHandpickDataHpsHl {
  MatcheHandpickDataHpsHl copyWith({
    String? hid,
    int? hs,
    String? hv,
    int? hmt,
    int? hn,
    List<MatcheHandpickDataHpsHlOl>? ol,
  }) {
    return MatcheHandpickDataHpsHl()
      ..hid = hid ?? this.hid
      ..hs = hs ?? this.hs
      ..hv = hv ?? this.hv
      ..hmt = hmt ?? this.hmt
      ..hn = hn ?? this.hn
      ..ol = ol ?? this.ol;
  }
}

MatcheHandpickDataHpsHlOl $MatcheHandpickDataHpsHlOlFromJson(
    Map<String, dynamic> json) {
  final MatcheHandpickDataHpsHlOl matcheHandpickDataHpsHlOl = MatcheHandpickDataHpsHlOl();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    matcheHandpickDataHpsHlOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    matcheHandpickDataHpsHlOl.os = os;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    matcheHandpickDataHpsHlOl.otd = otd;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    matcheHandpickDataHpsHlOl.ot = ot;
  }
  final int? ov = jsonConvert.convert<int>(json['ov']);
  if (ov != null) {
    matcheHandpickDataHpsHlOl.ov = ov;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    matcheHandpickDataHpsHlOl.on = on;
  }
  final String? onb = jsonConvert.convert<String>(json['onb']);
  if (onb != null) {
    matcheHandpickDataHpsHlOl.onb = onb;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matcheHandpickDataHpsHlOl.cds = cds;
  }
  final String? ots = jsonConvert.convert<String>(json['ots']);
  if (ots != null) {
    matcheHandpickDataHpsHlOl.ots = ots;
  }
  return matcheHandpickDataHpsHlOl;
}

Map<String, dynamic> $MatcheHandpickDataHpsHlOlToJson(
    MatcheHandpickDataHpsHlOl entity) {
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

extension MatcheHandpickDataHpsHlOlExtension on MatcheHandpickDataHpsHlOl {
  MatcheHandpickDataHpsHlOl copyWith({
    String? oid,
    int? os,
    int? otd,
    String? ot,
    int? ov,
    String? on,
    String? onb,
    String? cds,
    String? ots,
  }) {
    return MatcheHandpickDataHpsHlOl()
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