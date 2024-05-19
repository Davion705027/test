import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_detail_entity.dart';

MatchDetailEntity $MatchDetailEntityFromJson(Map<String, dynamic> json) {
  final MatchDetailEntity matchDetailEntity = MatchDetailEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matchDetailEntity.code = code;
  }
  final MatchDetailData? data = jsonConvert.convert<MatchDetailData>(
      json['data']);
  if (data != null) {
    matchDetailEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matchDetailEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matchDetailEntity.ts = ts;
  }
  return matchDetailEntity;
}

Map<String, dynamic> $MatchDetailEntityToJson(MatchDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatchDetailEntityExtension on MatchDetailEntity {
  MatchDetailEntity copyWith({
    String? code,
    MatchDetailData? data,
    String? msg,
    int? ts,
  }) {
    return MatchDetailEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatchDetailData $MatchDetailDataFromJson(Map<String, dynamic> json) {
  final MatchDetailData matchDetailData = MatchDetailData();
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    matchDetailData.tnjc = tnjc;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    matchDetailData.csna = csna;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    matchDetailData.tid = tid;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    matchDetailData.mst = mst;
  }
  final String? srid = jsonConvert.convert<String>(json['srid']);
  if (srid != null) {
    matchDetailData.srid = srid;
  }
  final int? mcg = jsonConvert.convert<int>(json['mcg']);
  if (mcg != null) {
    matchDetailData.mcg = mcg;
  }
  final int? atf = jsonConvert.convert<int>(json['atf']);
  if (atf != null) {
    matchDetailData.atf = atf;
  }
  final dynamic mdsc = json['mdsc'];
  if (mdsc != null) {
    matchDetailData.mdsc = mdsc;
  }
  final int? gcs = jsonConvert.convert<int>(json['gcs']);
  if (gcs != null) {
    matchDetailData.gcs = gcs;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    matchDetailData.mf = mf;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    matchDetailData.mgt = mgt;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    matchDetailData.maid = maid;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    matchDetailData.mct = mct;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    matchDetailData.tlev = tlev;
  }
  final String? mhlut = jsonConvert.convert<String>(json['mhlut']);
  if (mhlut != null) {
    matchDetailData.mhlut = mhlut;
  }
  final int? mo = jsonConvert.convert<int>(json['mo']);
  if (mo != null) {
    matchDetailData.mo = mo;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    matchDetailData.ctt = ctt;
  }
  final int? mp = jsonConvert.convert<int>(json['mp']);
  if (mp != null) {
    matchDetailData.mp = mp;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    matchDetailData.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    matchDetailData.ms = ms;
  }
  final String? cmec = jsonConvert.convert<String>(json['cmec']);
  if (cmec != null) {
    matchDetailData.cmec = cmec;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    matchDetailData.mle = mle;
  }
  final int? lvs = jsonConvert.convert<int>(json['lvs']);
  if (lvs != null) {
    matchDetailData.lvs = lvs;
  }
  final dynamic sort = json['sort'];
  if (sort != null) {
    matchDetailData.sort = sort;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    matchDetailData.malu = malu;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    matchDetailData.lurl = lurl;
  }
  final String? mprmc = jsonConvert.convert<String>(json['mprmc']);
  if (mprmc != null) {
    matchDetailData.mprmc = mprmc;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    matchDetailData.mhn = mhn;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matchDetailData.cds = cds;
  }
  final List<String>? frmhn = (json['frmhn'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frmhn != null) {
    matchDetailData.frmhn = frmhn;
  }
  final int? operationTournamentSort = jsonConvert.convert<int>(
      json['operationTournamentSort']);
  if (operationTournamentSort != null) {
    matchDetailData.operationTournamentSort = operationTournamentSort;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    matchDetailData.mhs = mhs;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    matchDetailData.mlet = mlet;
  }
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    matchDetailData.mhid = mhid;
  }
  final String? mrmc = jsonConvert.convert<String>(json['mrmc']);
  if (mrmc != null) {
    matchDetailData.mrmc = mrmc;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchDetailData.mid = mid;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    matchDetailData.mess = mess;
  }
  final dynamic lss = json['lss'];
  if (lss != null) {
    matchDetailData.lss = lss;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    matchDetailData.mmp = mmp;
  }
  final String? mststi = jsonConvert.convert<String>(json['mststi']);
  if (mststi != null) {
    matchDetailData.mststi = mststi;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    matchDetailData.mms = mms;
  }
  final int? mbmty = jsonConvert.convert<int>(json['mbmty']);
  if (mbmty != null) {
    matchDetailData.mbmty = mbmty;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    matchDetailData.mhlu = mhlu;
  }
  final String? seid = jsonConvert.convert<String>(json['seid']);
  if (seid != null) {
    matchDetailData.seid = seid;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    matchDetailData.mstst = mstst;
  }
  final String? malut = jsonConvert.convert<String>(json['malut']);
  if (malut != null) {
    matchDetailData.malut = malut;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    matchDetailData.man = man;
  }
  final List<String>? frman = (json['frman'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frman != null) {
    matchDetailData.frman = frman;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    matchDetailData.mat = mat;
  }
  final int? mng = jsonConvert.convert<int>(json['mng']);
  if (mng != null) {
    matchDetailData.mng = mng;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    matchDetailData.mststr = mststr;
  }
  final int? mvs = jsonConvert.convert<int>(json['mvs']);
  if (mvs != null) {
    matchDetailData.mvs = mvs;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    matchDetailData.mststs = mststs;
  }
  final int? mearlys = jsonConvert.convert<int>(json['mearlys']);
  if (mearlys != null) {
    matchDetailData.mearlys = mearlys;
  }
  final dynamic mfo = json['mfo'];
  if (mfo != null) {
    matchDetailData.mfo = mfo;
  }
  final int? mft = jsonConvert.convert<int>(json['mft']);
  if (mft != null) {
    matchDetailData.mft = mft;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    matchDetailData.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    matchDetailData.msc = msc;
  }
  return matchDetailData;
}

Map<String, dynamic> $MatchDetailDataToJson(MatchDetailData entity) {
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
  data['mhid'] = entity.mhid;
  data['mrmc'] = entity.mrmc;
  data['mid'] = entity.mid;
  data['mess'] = entity.mess;
  data['lss'] = entity.lss;
  data['mmp'] = entity.mmp;
  data['mststi'] = entity.mststi;
  data['mms'] = entity.mms;
  data['mbmty'] = entity.mbmty;
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
  data['mearlys'] = entity.mearlys;
  data['mfo'] = entity.mfo;
  data['mft'] = entity.mft;
  data['tn'] = entity.tn;
  data['msc'] = entity.msc;
  return data;
}

extension MatchDetailDataExtension on MatchDetailData {
  MatchDetailData copyWith({
    String? tnjc,
    String? csna,
    String? tid,
    String? mst,
    String? srid,
    int? mcg,
    int? atf,
    dynamic mdsc,
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
    String? mhid,
    String? mrmc,
    String? mid,
    int? mess,
    dynamic lss,
    String? mmp,
    String? mststi,
    int? mms,
    int? mbmty,
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
    int? mearlys,
    dynamic mfo,
    int? mft,
    String? tn,
    List<String>? msc,
  }) {
    return MatchDetailData()
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
      ..mhid = mhid ?? this.mhid
      ..mrmc = mrmc ?? this.mrmc
      ..mid = mid ?? this.mid
      ..mess = mess ?? this.mess
      ..lss = lss ?? this.lss
      ..mmp = mmp ?? this.mmp
      ..mststi = mststi ?? this.mststi
      ..mms = mms ?? this.mms
      ..mbmty = mbmty ?? this.mbmty
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
      ..mearlys = mearlys ?? this.mearlys
      ..mfo = mfo ?? this.mfo
      ..mft = mft ?? this.mft
      ..tn = tn ?? this.tn
      ..msc = msc ?? this.msc;
  }
}