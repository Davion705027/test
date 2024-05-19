import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/matche_result_entity.dart';

MatcheResultEntity $MatcheResultEntityFromJson(Map<String, dynamic> json) {
  final MatcheResultEntity matcheResultEntity = MatcheResultEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matcheResultEntity.code = code;
  }
  final List<MatcheResultData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<MatcheResultData>(e) as MatcheResultData)
      .toList();
  if (data != null) {
    matcheResultEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matcheResultEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matcheResultEntity.ts = ts;
  }
  return matcheResultEntity;
}

Map<String, dynamic> $MatcheResultEntityToJson(MatcheResultEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatcheResultEntityExtension on MatcheResultEntity {
  MatcheResultEntity copyWith({
    String? code,
    List<MatcheResultData>? data,
    String? msg,
    int? ts,
  }) {
    return MatcheResultEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatcheResultData $MatcheResultDataFromJson(Map<String, dynamic> json) {
  final MatcheResultData matcheResultData = MatcheResultData();
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    matcheResultData.tnjc = tnjc;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    matcheResultData.csna = csna;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    matcheResultData.tid = tid;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    matcheResultData.mst = mst;
  }
  final String? srid = jsonConvert.convert<String>(json['srid']);
  if (srid != null) {
    matcheResultData.srid = srid;
  }
  final int? mcg = jsonConvert.convert<int>(json['mcg']);
  if (mcg != null) {
    matcheResultData.mcg = mcg;
  }
  final int? atf = jsonConvert.convert<int>(json['atf']);
  if (atf != null) {
    matcheResultData.atf = atf;
  }
  final String? mdsc = jsonConvert.convert<String>(json['mdsc']);
  if (mdsc != null) {
    matcheResultData.mdsc = mdsc;
  }
  final int? gcs = jsonConvert.convert<int>(json['gcs']);
  if (gcs != null) {
    matcheResultData.gcs = gcs;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    matcheResultData.mf = mf;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    matcheResultData.mgt = mgt;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    matcheResultData.maid = maid;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    matcheResultData.mct = mct;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    matcheResultData.tlev = tlev;
  }
  final String? mhlut = jsonConvert.convert<String>(json['mhlut']);
  if (mhlut != null) {
    matcheResultData.mhlut = mhlut;
  }
  final int? mo = jsonConvert.convert<int>(json['mo']);
  if (mo != null) {
    matcheResultData.mo = mo;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    matcheResultData.ctt = ctt;
  }
  final int? mp = jsonConvert.convert<int>(json['mp']);
  if (mp != null) {
    matcheResultData.mp = mp;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    matcheResultData.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    matcheResultData.ms = ms;
  }
  final String? cmec = jsonConvert.convert<String>(json['cmec']);
  if (cmec != null) {
    matcheResultData.cmec = cmec;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    matcheResultData.mle = mle;
  }
  final int? lvs = jsonConvert.convert<int>(json['lvs']);
  if (lvs != null) {
    matcheResultData.lvs = lvs;
  }
  final dynamic sort = json['sort'];
  if (sort != null) {
    matcheResultData.sort = sort;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    matcheResultData.malu = malu;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    matcheResultData.lurl = lurl;
  }
  final String? mprmc = jsonConvert.convert<String>(json['mprmc']);
  if (mprmc != null) {
    matcheResultData.mprmc = mprmc;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    matcheResultData.mhn = mhn;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matcheResultData.cds = cds;
  }
  final List<String>? frmhn = (json['frmhn'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frmhn != null) {
    matcheResultData.frmhn = frmhn;
  }
  final int? operationTournamentSort = jsonConvert.convert<int>(
      json['operationTournamentSort']);
  if (operationTournamentSort != null) {
    matcheResultData.operationTournamentSort = operationTournamentSort;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    matcheResultData.mhs = mhs;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    matcheResultData.mlet = mlet;
  }
  final dynamic tonum = json['tonum'];
  if (tonum != null) {
    matcheResultData.tonum = tonum;
  }
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    matcheResultData.mhid = mhid;
  }
  final String? mrmc = jsonConvert.convert<String>(json['mrmc']);
  if (mrmc != null) {
    matcheResultData.mrmc = mrmc;
  }
  final bool? playBack = jsonConvert.convert<bool>(json['playBack']);
  if (playBack != null) {
    matcheResultData.playBack = playBack;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matcheResultData.mid = mid;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    matcheResultData.mess = mess;
  }
  final dynamic lss = json['lss'];
  if (lss != null) {
    matcheResultData.lss = lss;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    matcheResultData.mmp = mmp;
  }
  final dynamic mststi = json['mststi'];
  if (mststi != null) {
    matcheResultData.mststi = mststi;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    matcheResultData.mms = mms;
  }
  final int? mbmty = jsonConvert.convert<int>(json['mbmty']);
  if (mbmty != null) {
    matcheResultData.mbmty = mbmty;
  }
  final int? pmms = jsonConvert.convert<int>(json['pmms']);
  if (pmms != null) {
    matcheResultData.pmms = pmms;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    matcheResultData.mhlu = mhlu;
  }
  final String? seid = jsonConvert.convert<String>(json['seid']);
  if (seid != null) {
    matcheResultData.seid = seid;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    matcheResultData.mstst = mstst;
  }
  final String? malut = jsonConvert.convert<String>(json['malut']);
  if (malut != null) {
    matcheResultData.malut = malut;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    matcheResultData.man = man;
  }
  final List<String>? frman = (json['frman'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frman != null) {
    matcheResultData.frman = frman;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    matcheResultData.mat = mat;
  }
  final int? mng = jsonConvert.convert<int>(json['mng']);
  if (mng != null) {
    matcheResultData.mng = mng;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    matcheResultData.mststr = mststr;
  }
  final int? mvs = jsonConvert.convert<int>(json['mvs']);
  if (mvs != null) {
    matcheResultData.mvs = mvs;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    matcheResultData.mststs = mststs;
  }
  final int? tournamentSort = jsonConvert.convert<int>(json['tournamentSort']);
  if (tournamentSort != null) {
    matcheResultData.tournamentSort = tournamentSort;
  }
  final int? mearlys = jsonConvert.convert<int>(json['mearlys']);
  if (mearlys != null) {
    matcheResultData.mearlys = mearlys;
  }
  final bool? tf = jsonConvert.convert<bool>(json['tf']);
  if (tf != null) {
    matcheResultData.tf = tf;
  }
  final dynamic mfo = json['mfo'];
  if (mfo != null) {
    matcheResultData.mfo = mfo;
  }
  final int? mft = jsonConvert.convert<int>(json['mft']);
  if (mft != null) {
    matcheResultData.mft = mft;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    matcheResultData.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    matcheResultData.msc = msc;
  }
  return matcheResultData;
}

Map<String, dynamic> $MatcheResultDataToJson(MatcheResultData entity) {
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
  data['tonum'] = entity.tonum;
  data['mhid'] = entity.mhid;
  data['mrmc'] = entity.mrmc;
  data['playBack'] = entity.playBack;
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
  data['mvs'] = entity.mvs;
  data['mststs'] = entity.mststs;
  data['tournamentSort'] = entity.tournamentSort;
  data['mearlys'] = entity.mearlys;
  data['tf'] = entity.tf;
  data['mfo'] = entity.mfo;
  data['mft'] = entity.mft;
  data['tn'] = entity.tn;
  data['msc'] = entity.msc;
  return data;
}

extension MatcheResultDataExtension on MatcheResultData {
  MatcheResultData copyWith({
    String? tnjc,
    String? csna,
    String? tid,
    String? mst,
    String? srid,
    int? mcg,
    int? atf,
    String? mdsc,
    int? gcs,
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
    String? cmec,
    int? mle,
    int? lvs,
    dynamic sort,
    List<String>? malu,
    String? lurl,
    String? mprmc,
    String? mhn,
    String? cds,
    List<String>? frmhn,
    int? operationTournamentSort,
    int? mhs,
    String? mlet,
    dynamic tonum,
    String? mhid,
    String? mrmc,
    bool? playBack,
    String? mid,
    int? mess,
    dynamic lss,
    String? mmp,
    dynamic mststi,
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
    int? mvs,
    int? mststs,
    int? tournamentSort,
    int? mearlys,
    bool? tf,
    dynamic mfo,
    int? mft,
    String? tn,
    List<String>? msc,
  }) {
    return MatcheResultData()
      ..tnjc = tnjc ?? this.tnjc
      ..csna = csna ?? this.csna
      ..tid = tid ?? this.tid
      ..mst = mst ?? this.mst
      ..srid = srid ?? this.srid
      ..mcg = mcg ?? this.mcg
      ..atf = atf ?? this.atf
      ..mdsc = mdsc ?? this.mdsc
      ..gcs = gcs ?? this.gcs
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
      ..tonum = tonum ?? this.tonum
      ..mhid = mhid ?? this.mhid
      ..mrmc = mrmc ?? this.mrmc
      ..playBack = playBack ?? this.playBack
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
      ..mvs = mvs ?? this.mvs
      ..mststs = mststs ?? this.mststs
      ..tournamentSort = tournamentSort ?? this.tournamentSort
      ..mearlys = mearlys ?? this.mearlys
      ..tf = tf ?? this.tf
      ..mfo = mfo ?? this.mfo
      ..mft = mft ?? this.mft
      ..tn = tn ?? this.tn
      ..msc = msc ?? this.msc;
  }
}