import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_result_match_detail_entity.dart';

GetResultMatchDetailEntity $GetResultMatchDetailEntityFromJson(
    Map<String, dynamic> json) {
  final GetResultMatchDetailEntity getResultMatchDetailEntity = GetResultMatchDetailEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getResultMatchDetailEntity.code = code;
  }
  final GetResultMatchDetailData? data = jsonConvert.convert<
      GetResultMatchDetailData>(json['data']);
  if (data != null) {
    getResultMatchDetailEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getResultMatchDetailEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getResultMatchDetailEntity.ts = ts;
  }
  return getResultMatchDetailEntity;
}

Map<String, dynamic> $GetResultMatchDetailEntityToJson(
    GetResultMatchDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetResultMatchDetailEntityExtension on GetResultMatchDetailEntity {
  GetResultMatchDetailEntity copyWith({
    String? code,
    GetResultMatchDetailData? data,
    String? msg,
    int? ts,
  }) {
    return GetResultMatchDetailEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetResultMatchDetailData $GetResultMatchDetailDataFromJson(
    Map<String, dynamic> json) {
  final GetResultMatchDetailData getResultMatchDetailData = GetResultMatchDetailData();
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    getResultMatchDetailData.tnjc = tnjc;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    getResultMatchDetailData.csna = csna;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    getResultMatchDetailData.tid = tid;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    getResultMatchDetailData.mst = mst;
  }
  final String? srid = jsonConvert.convert<String>(json['srid']);
  if (srid != null) {
    getResultMatchDetailData.srid = srid;
  }
  final int? mcg = jsonConvert.convert<int>(json['mcg']);
  if (mcg != null) {
    getResultMatchDetailData.mcg = mcg;
  }
  final int? atf = jsonConvert.convert<int>(json['atf']);
  if (atf != null) {
    getResultMatchDetailData.atf = atf;
  }
  final dynamic mdsc = json['mdsc'];
  if (mdsc != null) {
    getResultMatchDetailData.mdsc = mdsc;
  }
  final int? gcs = jsonConvert.convert<int>(json['gcs']);
  if (gcs != null) {
    getResultMatchDetailData.gcs = gcs;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    getResultMatchDetailData.mf = mf;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    getResultMatchDetailData.mgt = mgt;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    getResultMatchDetailData.maid = maid;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    getResultMatchDetailData.mct = mct;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    getResultMatchDetailData.tlev = tlev;
  }
  final String? mhlut = jsonConvert.convert<String>(json['mhlut']);
  if (mhlut != null) {
    getResultMatchDetailData.mhlut = mhlut;
  }
  final int? mo = jsonConvert.convert<int>(json['mo']);
  if (mo != null) {
    getResultMatchDetailData.mo = mo;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    getResultMatchDetailData.ctt = ctt;
  }
  final int? mp = jsonConvert.convert<int>(json['mp']);
  if (mp != null) {
    getResultMatchDetailData.mp = mp;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    getResultMatchDetailData.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    getResultMatchDetailData.ms = ms;
  }
  final String? cmec = jsonConvert.convert<String>(json['cmec']);
  if (cmec != null) {
    getResultMatchDetailData.cmec = cmec;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    getResultMatchDetailData.mle = mle;
  }
  final int? lvs = jsonConvert.convert<int>(json['lvs']);
  if (lvs != null) {
    getResultMatchDetailData.lvs = lvs;
  }
  final dynamic sort = json['sort'];
  if (sort != null) {
    getResultMatchDetailData.sort = sort;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    getResultMatchDetailData.malu = malu;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    getResultMatchDetailData.lurl = lurl;
  }
  final String? mprmc = jsonConvert.convert<String>(json['mprmc']);
  if (mprmc != null) {
    getResultMatchDetailData.mprmc = mprmc;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    getResultMatchDetailData.mhn = mhn;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    getResultMatchDetailData.cds = cds;
  }
  final List<String>? frmhn = (json['frmhn'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frmhn != null) {
    getResultMatchDetailData.frmhn = frmhn;
  }
  final int? operationTournamentSort = jsonConvert.convert<int>(
      json['operationTournamentSort']);
  if (operationTournamentSort != null) {
    getResultMatchDetailData.operationTournamentSort = operationTournamentSort;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    getResultMatchDetailData.mhs = mhs;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    getResultMatchDetailData.mlet = mlet;
  }
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    getResultMatchDetailData.mhid = mhid;
  }
  final String? mrmc = jsonConvert.convert<String>(json['mrmc']);
  if (mrmc != null) {
    getResultMatchDetailData.mrmc = mrmc;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    getResultMatchDetailData.mid = mid;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    getResultMatchDetailData.mess = mess;
  }
  final dynamic lss = json['lss'];
  if (lss != null) {
    getResultMatchDetailData.lss = lss;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    getResultMatchDetailData.mmp = mmp;
  }
  final String? mststi = jsonConvert.convert<String>(json['mststi']);
  if (mststi != null) {
    getResultMatchDetailData.mststi = mststi;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    getResultMatchDetailData.mms = mms;
  }
  final int? mbmty = jsonConvert.convert<int>(json['mbmty']);
  if (mbmty != null) {
    getResultMatchDetailData.mbmty = mbmty;
  }
  final int? pmms = jsonConvert.convert<int>(json['pmms']);
  if (pmms != null) {
    getResultMatchDetailData.pmms = pmms;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    getResultMatchDetailData.mhlu = mhlu;
  }
  final String? seid = jsonConvert.convert<String>(json['seid']);
  if (seid != null) {
    getResultMatchDetailData.seid = seid;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    getResultMatchDetailData.mstst = mstst;
  }
  final String? malut = jsonConvert.convert<String>(json['malut']);
  if (malut != null) {
    getResultMatchDetailData.malut = malut;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    getResultMatchDetailData.man = man;
  }
  final List<String>? frman = (json['frman'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frman != null) {
    getResultMatchDetailData.frman = frman;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    getResultMatchDetailData.mat = mat;
  }
  final int? mng = jsonConvert.convert<int>(json['mng']);
  if (mng != null) {
    getResultMatchDetailData.mng = mng;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    getResultMatchDetailData.mststr = mststr;
  }
  final int? mvs = jsonConvert.convert<int>(json['mvs']);
  if (mvs != null) {
    getResultMatchDetailData.mvs = mvs;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    getResultMatchDetailData.mststs = mststs;
  }
  final int? mearlys = jsonConvert.convert<int>(json['mearlys']);
  if (mearlys != null) {
    getResultMatchDetailData.mearlys = mearlys;
  }
  final dynamic mfo = json['mfo'];
  if (mfo != null) {
    getResultMatchDetailData.mfo = mfo;
  }
  final int? mft = jsonConvert.convert<int>(json['mft']);
  if (mft != null) {
    getResultMatchDetailData.mft = mft;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    getResultMatchDetailData.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    getResultMatchDetailData.msc = msc;
  }
  return getResultMatchDetailData;
}

Map<String, dynamic> $GetResultMatchDetailDataToJson(
    GetResultMatchDetailData entity) {
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
  data['mearlys'] = entity.mearlys;
  data['mfo'] = entity.mfo;
  data['mft'] = entity.mft;
  data['tn'] = entity.tn;
  data['msc'] = entity.msc;
  return data;
}

extension GetResultMatchDetailDataExtension on GetResultMatchDetailData {
  GetResultMatchDetailData copyWith({
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
    int? mearlys,
    dynamic mfo,
    int? mft,
    String? tn,
    List<String>? msc,
  }) {
    return GetResultMatchDetailData()
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
      ..mearlys = mearlys ?? this.mearlys
      ..mfo = mfo ?? this.mfo
      ..mft = mft ?? this.mft
      ..tn = tn ?? this.tn
      ..msc = msc ?? this.msc;
  }
}