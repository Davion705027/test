import 'package:flutter_ty_app/app/modules/match_detail/models/bet_item_collection.dart';
import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


MatchEntity $MatchEntityFromJson(Map<String, dynamic> json) {
  final MatchEntity matchEntity = MatchEntity();
  final String? mcid = jsonConvert.convert<String>(json['mcid']);
  if (mcid != null) {
    matchEntity.mcid = mcid;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    matchEntity.tnjc = tnjc;
  }
  final List<MatchHps>? hpsBold = (json['hpsBold'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHps>(e) as MatchHps)
      .toList();
  if (hpsBold != null) {
    matchEntity.hpsBold = hpsBold;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    matchEntity.csna = csna;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    matchEntity.tid = tid;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    matchEntity.mst = mst;
  }
  final String? srid = jsonConvert.convert<String>(json['srid']);
  if (srid != null) {
    matchEntity.srid = srid;
  }
  final int? mcg = jsonConvert.convert<int>(json['mcg']);
  if (mcg != null) {
    matchEntity.mcg = mcg;
  }
  final bool? cosCorner = jsonConvert.convert<bool>(json['cosCorner']);
  if (cosCorner != null) {
    matchEntity.cosCorner = cosCorner;
  }
  final String? atf = jsonConvert.convert<String>(json['atf']);
  if (atf != null) {
    matchEntity.atf = atf;
  }
  final bool? cosPunish = jsonConvert.convert<bool>(json['cosPunish']);
  if (cosPunish != null) {
    matchEntity.cosPunish = cosPunish;
  }
  final bool? cosOutright = jsonConvert.convert<bool>(json['cosOutright']);
  if (cosOutright != null) {
    matchEntity.cosOutright = cosOutright;
  }
  final String? mdsc = jsonConvert.convert<String>(json['mdsc']);
  if (mdsc != null) {
    matchEntity.mdsc = mdsc;
  }
  final int? gcs = jsonConvert.convert<int>(json['gcs']);
  if (gcs != null) {
    matchEntity.gcs = gcs;
  }
  final int? mc = jsonConvert.convert<int>(json['mc']);
  if (mc != null) {
    matchEntity.mc = mc;
  }
  final List<MatchHps>? hpsOvertime = (json['hpsOvertime'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHps>(e) as MatchHps)
      .toList();
  if (hpsOvertime != null) {
    matchEntity.hpsOvertime = hpsOvertime;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    matchEntity.mf = mf;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    matchEntity.mgt = mgt;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    matchEntity.maid = maid;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    matchEntity.mct = mct;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    matchEntity.tlev = tlev;
  }
  final String? mhlut = jsonConvert.convert<String>(json['mhlut']);
  if (mhlut != null) {
    matchEntity.mhlut = mhlut;
  }
  final int? mo = jsonConvert.convert<int>(json['mo']);
  if (mo != null) {
    matchEntity.mo = mo;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    matchEntity.ctt = ctt;
  }
  final int? mp = jsonConvert.convert<int>(json['mp']);
  if (mp != null) {
    matchEntity.mp = mp;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    matchEntity.csid = csid;
  }
  final dynamic pmms = json['pmms'];
  if (pmms != null) {
    matchEntity.pmms = pmms;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    matchEntity.ms = ms;
  }
  final String? cmec = jsonConvert.convert<String>(json['cmec']);
  if (cmec != null) {
    matchEntity.cmec = cmec;
  }
  final bool? cos5Minutes = jsonConvert.convert<bool>(json['cos5Minutes']);
  if (cos5Minutes != null) {
    matchEntity.cos5Minutes = cos5Minutes;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    matchEntity.mle = mle;
  }
  final int? lvs = jsonConvert.convert<int>(json['lvs']);
  if (lvs != null) {
    matchEntity.lvs = lvs;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    matchEntity.sort = sort;
  }
  final dynamic malu = json['malu'];
  if (malu != null) {
    matchEntity.malu = malu;
  }
  final List<MatchHps>? hps15Minutes = (json['hps15Minutes'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHps>(e) as MatchHps)
      .toList();
  if (hps15Minutes != null) {
    matchEntity.hps15Minutes = hps15Minutes;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    matchEntity.lurl = lurl;
  }
  final String? mprmc = jsonConvert.convert<String>(json['mprmc']);
  if (mprmc != null) {
    matchEntity.mprmc = mprmc;
  }
  final bool? cosOvertime = jsonConvert.convert<bool>(json['cosOvertime']);
  if (cosOvertime != null) {
    matchEntity.cosOvertime = cosOvertime;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    matchEntity.mhn = mhn;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    matchEntity.betAmount = betAmount;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matchEntity.cds = cds;
  }
  final dynamic frmhn = json['frmhn'];
  if (frmhn != null) {
    matchEntity.frmhn = frmhn;
  }
  final bool? compose = jsonConvert.convert<bool>(json['compose']);
  if (compose != null) {
    matchEntity.compose = compose;
  }
  final int? operationTournamentSort =
      jsonConvert.convert<int>(json['operationTournamentSort']);
  if (operationTournamentSort != null) {
    matchEntity.operationTournamentSort = operationTournamentSort;
  }
  final bool? cos15Minutes = jsonConvert.convert<bool>(json['cos15Minutes']);
  if (cos15Minutes != null) {
    matchEntity.cos15Minutes = cos15Minutes;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    matchEntity.mhs = mhs;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    matchEntity.mlet = mlet;
  }
  final List<MatchHps>? hps5Minutes = (json['hps5Minutes'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHps>(e) as MatchHps)
      .toList();
  if (hps5Minutes != null) {
    matchEntity.hps5Minutes = hps5Minutes;
  }
  final bool? cosPenalty = jsonConvert.convert<bool>(json['cosPenalty']);
  if (cosPenalty != null) {
    matchEntity.cosPenalty = cosPenalty;
  }
  final List<MatchHps>? hpsCorner = (json['hpsCorner'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHps>(e) as MatchHps)
      .toList();
  if (hpsCorner != null) {
    matchEntity.hpsCorner = hpsCorner;
  }
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    matchEntity.mhid = mhid;
  }
  final List<MatchHps>? hpsPunish = (json['hpsPunish'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHps>(e) as MatchHps)
      .toList();
  if (hpsPunish != null) {
    matchEntity.hpsPunish = hpsPunish;
  }
  final String? mrmc = jsonConvert.convert<String>(json['mrmc']);
  if (mrmc != null) {
    matchEntity.mrmc = mrmc;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchEntity.mid = mid;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    matchEntity.mess = mess;
  }
  final bool? cosBold = jsonConvert.convert<bool>(json['cosBold']);
  if (cosBold != null) {
    matchEntity.cosBold = cosBold;
  }
  final dynamic lss = json['lss'];
  if (lss != null) {
    matchEntity.lss = lss;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    matchEntity.mmp = mmp;
  }
  final String? mststi = jsonConvert.convert<String>(json['mststi']);
  if (mststi != null) {
    matchEntity.mststi = mststi;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    matchEntity.mms = mms;
  }
  final int? mbmty = jsonConvert.convert<int>(json['mbmty']);
  if (mbmty != null) {
    matchEntity.mbmty = mbmty;
  }
  final int? regionIdSort = jsonConvert.convert<int>(json['regionIdSort']);
  if (regionIdSort != null) {
    matchEntity.regionIdSort = regionIdSort;
  }
  final dynamic mhlu = json['mhlu'];
  if (mhlu != null) {
    matchEntity.mhlu = mhlu;
  }
  final String? seid = jsonConvert.convert<String>(json['seid']);
  if (seid != null) {
    matchEntity.seid = seid;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    matchEntity.mstst = mstst;
  }
  final String? malut = jsonConvert.convert<String>(json['malut']);
  if (malut != null) {
    matchEntity.malut = malut;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    matchEntity.man = man;
  }
  final dynamic frman = json['frman'];
  if (frman != null) {
    matchEntity.frman = frman;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    matchEntity.mat = mat;
  }
  final int? mng = jsonConvert.convert<int>(json['mng']);
  if (mng != null) {
    matchEntity.mng = mng;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    matchEntity.mststr = mststr;
  }
  final List<MatchHps>? hps = (json['hps'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHps>(e) as MatchHps)
      .toList();
  if (hps != null) {
    matchEntity.hps = hps;
  }
  final List<MatchHps>? hpsCompose = (json['hpsCompose'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHps>(e) as MatchHps)
      .toList();
  if (hpsCompose != null) {
    matchEntity.hpsCompose = hpsCompose;
  }
  final int? mvs = jsonConvert.convert<int>(json['mvs']);
  if (mvs != null) {
    matchEntity.mvs = mvs;
  }
  final List<MatchHps>? hpsPenalty = (json['hpsPenalty'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHps>(e) as MatchHps)
      .toList();
  if (hpsPenalty != null) {
    matchEntity.hpsPenalty = hpsPenalty;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    matchEntity.mststs = mststs;
  }
  final int? mearlys = jsonConvert.convert<int>(json['mearlys']);
  if (mearlys != null) {
    matchEntity.mearlys = mearlys;
  }
  final bool? tf = jsonConvert.convert<bool>(json['tf']);
  if (tf != null) {
    matchEntity.tf = tf;
  }
  final int? th = jsonConvert.convert<int>(json['th']);
  if (th != null) {
    matchEntity.th = th;
  }
  final bool? cosPromotion = jsonConvert.convert<bool>(json['cosPromotion']);
  if (cosPromotion != null) {
    matchEntity.cosPromotion = cosPromotion;
  }
  final dynamic mfo = json['mfo'];
  if (mfo != null) {
    matchEntity.mfo = mfo;
  }
  final int? mft = jsonConvert.convert<int>(json['mft']);
  if (mft != null) {
    matchEntity.mft = mft;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    matchEntity.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (msc != null) {
    matchEntity.msc = msc;
  }
  final List<MatchHps>? hpsPromotion = (json['hpsPromotion'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHps>(e) as MatchHps)
      .toList();
  if (hpsPromotion != null) {
    matchEntity.hpsPromotion = hpsPromotion;
  }
  final List<MatchHps>? hpsOutright = (json['hpsOutright'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHps>(e) as MatchHps)
      .toList();
  if (hpsOutright != null) {
    matchEntity.hpsOutright = hpsOutright;
  }
  final String? seoy = jsonConvert.convert<String>(json['seoy']);
  if (seoy != null) {
    matchEntity.seoy = seoy;
  }
  final String? onTn = jsonConvert.convert<String>(json['onTn']);
  if (onTn != null) {
    matchEntity.onTn = onTn;
  }
  final String? med = jsonConvert.convert<String>(json['med']);
  if (med != null) {
    matchEntity.med = med;
  }
  final String? mbkn = jsonConvert.convert<String>(json['mbkn']);
  if (mbkn != null) {
    matchEntity.mbkn = mbkn;
  }
  final String? mbhn = jsonConvert.convert<String>(json['mbhn']);
  if (mbhn != null) {
    matchEntity.mbhn = mbhn;
  }
  final String? mbcn = jsonConvert.convert<String>(json['mbcn']);
  if (mbcn != null) {
    matchEntity.mbcn = mbcn;
  }
  final List<String>? teams = (json['teams'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (teams != null) {
    matchEntity.teams = teams;
  }
  final String? vurl = jsonConvert.convert<String>(json['vurl']);
  if (vurl != null) {
    matchEntity.vurl = vurl;
  }
  final String? varl = jsonConvert.convert<String>(json['varl']);
  if (varl != null) {
    matchEntity.varl = varl;
  }
  final int? ispo = jsonConvert.convert<int>(json['ispo']);
  if (ispo != null) {
    matchEntity.ispo = ispo;
  }
  final String? mbtlp = jsonConvert.convert<String>(json['mbtlp']);
  if (mbtlp != null) {
    matchEntity.mbtlp = mbtlp;
  }
  final String? mbolp = jsonConvert.convert<String>(json['mbolp']);
  if (mbolp != null) {
    matchEntity.mbolp = mbolp;
  }
  final String? mbthlp = jsonConvert.convert<String>(json['mbthlp']);
  if (mbthlp != null) {
    matchEntity.mbthlp = mbthlp;
  }
  final String? lod = jsonConvert.convert<String>(json['lod']);
  if (lod != null) {
    matchEntity.lod = lod;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    matchEntity.batchNo = batchNo;
  }
  final String? homeScore = jsonConvert.convert<String>(json['homeScore']);
  if (homeScore != null) {
    matchEntity.homeScore = homeScore;
  }
  final String? awayScore = jsonConvert.convert<String>(json['awayScore']);
  if (awayScore != null) {
    matchEntity.awayScore = awayScore;
  }
  return matchEntity;
}

Map<String, dynamic> $MatchEntityToJson(MatchEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mcid'] = entity.mcid;
  data['tnjc'] = entity.tnjc;
  data['hpsBold'] = entity.hpsBold.map((v) => v.toJson()).toList();
  data['csna'] = entity.csna;
  data['tid'] = entity.tid;
  data['mst'] = entity.mst;
  data['srid'] = entity.srid;
  data['mcg'] = entity.mcg;
  data['cosCorner'] = entity.cosCorner;
  data['atf'] = entity.atf;
  data['cosPunish'] = entity.cosPunish;
  data['cosOutright'] = entity.cosOutright;
  data['mdsc'] = entity.mdsc;
  data['gcs'] = entity.gcs;
  data['mc'] = entity.mc;
  data['hpsOvertime'] = entity.hpsOvertime.map((v) => v.toJson()).toList();
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
  data['pmms'] = entity.pmms;
  data['ms'] = entity.ms;
  data['cmec'] = entity.cmec;
  data['cos5Minutes'] = entity.cos5Minutes;
  data['mle'] = entity.mle;
  data['lvs'] = entity.lvs;
  data['sort'] = entity.sort;
  data['malu'] = entity.malu;
  data['hps15Minutes'] = entity.hps15Minutes.map((v) => v.toJson()).toList();
  data['lurl'] = entity.lurl;
  data['mprmc'] = entity.mprmc;
  data['cosOvertime'] = entity.cosOvertime;
  data['mhn'] = entity.mhn;
  data['betAmount'] = entity.betAmount;
  data['cds'] = entity.cds;
  data['frmhn'] = entity.frmhn;
  data['compose'] = entity.compose;
  data['operationTournamentSort'] = entity.operationTournamentSort;
  data['cos15Minutes'] = entity.cos15Minutes;
  data['mhs'] = entity.mhs;
  data['mlet'] = entity.mlet;
  data['hps5Minutes'] = entity.hps5Minutes.map((v) => v.toJson()).toList();
  data['cosPenalty'] = entity.cosPenalty;
  data['hpsCorner'] = entity.hpsCorner.map((v) => v.toJson()).toList();
  data['mhid'] = entity.mhid;
  data['hpsPunish'] = entity.hpsPunish.map((v) => v.toJson()).toList();
  data['mrmc'] = entity.mrmc;
  data['mid'] = entity.mid;
  data['mess'] = entity.mess;
  data['cosBold'] = entity.cosBold;
  data['lss'] = entity.lss;
  data['mmp'] = entity.mmp;
  data['mststi'] = entity.mststi;
  data['mms'] = entity.mms;
  data['mbmty'] = entity.mbmty;
  data['regionIdSort'] = entity.regionIdSort;
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
  data['hpsCompose'] = entity.hpsCompose.map((v) => v.toJson()).toList();
  data['mvs'] = entity.mvs;
  data['hpsPenalty'] = entity.hpsPenalty.map((v) => v.toJson()).toList();
  data['mststs'] = entity.mststs;
  data['mearlys'] = entity.mearlys;
  data['tf'] = entity.tf;
  data['th'] = entity.th;
  data['cosPromotion'] = entity.cosPromotion;
  data['mfo'] = entity.mfo;
  data['mft'] = entity.mft;
  data['tn'] = entity.tn;
  data['msc'] = entity.msc;
  data['hpsPromotion'] = entity.hpsPromotion.map((v) => v.toJson()).toList();
  data['hpsOutright'] = entity.hpsOutright.map((v) => v.toJson()).toList();
  data['seoy'] = entity.seoy;
  data['onTn'] = entity.onTn;
  data['med'] = entity.med;
  data['mbkn'] = entity.mbkn;
  data['mbhn'] = entity.mbhn;
  data['mbcn'] = entity.mbcn;
  data['teams'] = entity.teams;
  data['vurl'] = entity.vurl;
  data['varl'] = entity.varl;
  data['ispo'] = entity.ispo;
  data['mbtlp'] = entity.mbtlp;
  data['mbolp'] = entity.mbolp;
  data['mbthlp'] = entity.mbthlp;
  data['lod'] = entity.lod;
  data['batchNo'] = entity.batchNo;
  data['homeScore'] = entity.homeScore;
  data['awayScore'] = entity.awayScore;
  return data;
}

extension MatchEntityExtension on MatchEntity {
  MatchEntity copyWith({
    String? mcid,
    String? tnjc,
    List<MatchHps>? hpsBold,
    String? csna,
    String? tid,
    String? mst,
    String? srid,
    int? mcg,
    bool? cosCorner,
    String? atf,
    bool? cosPunish,
    bool? cosOutright,
    String? mdsc,
    int? gcs,
    int? mc,
    List<MatchHps>? hpsOvertime,
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
    dynamic pmms,
    int? ms,
    String? cmec,
    bool? cos5Minutes,
    int? mle,
    int? lvs,
    int? sort,
    dynamic malu,
    List<MatchHps>? hps15Minutes,
    String? lurl,
    String? mprmc,
    bool? cosOvertime,
    String? mhn,
    String? betAmount,
    String? cds,
    dynamic frmhn,
    bool? compose,
    int? operationTournamentSort,
    bool? cos15Minutes,
    int? mhs,
    String? mlet,
    List<MatchHps>? hps5Minutes,
    bool? cosPenalty,
    List<MatchHps>? hpsCorner,
    String? mhid,
    List<MatchHps>? hpsPunish,
    String? mrmc,
    String? mid,
    int? mess,
    bool? cosBold,
    dynamic lss,
    String? mmp,
    String? mststi,
    int? mms,
    int? mbmty,
    int? regionIdSort,
    dynamic mhlu,
    String? seid,
    String? mstst,
    String? malut,
    String? man,
    dynamic frman,
    String? mat,
    int? mng,
    String? mststr,
    List<MatchHps>? hps,
    List<MatchHps>? hpsCompose,
    int? mvs,
    List<MatchHps>? hpsPenalty,
    int? mststs,
    int? mearlys,
    bool? tf,
    int? th,
    bool? cosPromotion,
    dynamic mfo,
    int? mft,
    String? tn,
    List<String>? msc,
    List<MatchHps>? hpsPromotion,
    List<MatchHps>? hpsOutright,
    String? seoy,
    String? onTn,
    String? med,
    String? mbkn,
    String? mbhn,
    String? mbcn,
    List<String>? teams,
    String? vurl,
    String? varl,
    int? ispo,
    String? mbtlp,
    String? mbolp,
    String? mbthlp,
    String? lod,
    String? batchNo,
    bool? isCollection,
    bool? isExpand,
    int? startFlag,
    int? homeRedScore,
    int? awayRedScore,
    int? homeYellowScore,
    int? awayYellowScore,
    List<String>? mscListDict,
    String? homeScore,
    String? awayScore,
    List<List<String>>? mscFormat,
    List<List<String>>? mscSFormat,
  }) {
    return MatchEntity()
      ..mcid = mcid ?? this.mcid
      ..tnjc = tnjc ?? this.tnjc
      ..hpsBold = hpsBold ?? this.hpsBold
      ..csna = csna ?? this.csna
      ..tid = tid ?? this.tid
      ..mst = mst ?? this.mst
      ..srid = srid ?? this.srid
      ..mcg = mcg ?? this.mcg
      ..cosCorner = cosCorner ?? this.cosCorner
      ..atf = atf ?? this.atf
      ..cosPunish = cosPunish ?? this.cosPunish
      ..cosOutright = cosOutright ?? this.cosOutright
      ..mdsc = mdsc ?? this.mdsc
      ..gcs = gcs ?? this.gcs
      ..mc = mc ?? this.mc
      ..hpsOvertime = hpsOvertime ?? this.hpsOvertime
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
      ..pmms = pmms ?? this.pmms
      ..ms = ms ?? this.ms
      ..cmec = cmec ?? this.cmec
      ..cos5Minutes = cos5Minutes ?? this.cos5Minutes
      ..mle = mle ?? this.mle
      ..lvs = lvs ?? this.lvs
      ..sort = sort ?? this.sort
      ..malu = malu ?? this.malu
      ..hps15Minutes = hps15Minutes ?? this.hps15Minutes
      ..lurl = lurl ?? this.lurl
      ..mprmc = mprmc ?? this.mprmc
      ..cosOvertime = cosOvertime ?? this.cosOvertime
      ..mhn = mhn ?? this.mhn
      ..betAmount = betAmount ?? this.betAmount
      ..cds = cds ?? this.cds
      ..frmhn = frmhn ?? this.frmhn
      ..compose = compose ?? this.compose
      ..operationTournamentSort =
          operationTournamentSort ?? this.operationTournamentSort
      ..cos15Minutes = cos15Minutes ?? this.cos15Minutes
      ..mhs = mhs ?? this.mhs
      ..mlet = mlet ?? this.mlet
      ..hps5Minutes = hps5Minutes ?? this.hps5Minutes
      ..cosPenalty = cosPenalty ?? this.cosPenalty
      ..hpsCorner = hpsCorner ?? this.hpsCorner
      ..mhid = mhid ?? this.mhid
      ..hpsPunish = hpsPunish ?? this.hpsPunish
      ..mrmc = mrmc ?? this.mrmc
      ..mid = mid ?? this.mid
      ..mess = mess ?? this.mess
      ..cosBold = cosBold ?? this.cosBold
      ..lss = lss ?? this.lss
      ..mmp = mmp ?? this.mmp
      ..mststi = mststi ?? this.mststi
      ..mms = mms ?? this.mms
      ..mbmty = mbmty ?? this.mbmty
      ..regionIdSort = regionIdSort ?? this.regionIdSort
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
      ..hpsCompose = hpsCompose ?? this.hpsCompose
      ..mvs = mvs ?? this.mvs
      ..hpsPenalty = hpsPenalty ?? this.hpsPenalty
      ..mststs = mststs ?? this.mststs
      ..mearlys = mearlys ?? this.mearlys
      ..tf = tf ?? this.tf
      ..th = th ?? this.th
      ..cosPromotion = cosPromotion ?? this.cosPromotion
      ..mfo = mfo ?? this.mfo
      ..mft = mft ?? this.mft
      ..tn = tn ?? this.tn
      ..msc = msc ?? this.msc
      ..hpsPromotion = hpsPromotion ?? this.hpsPromotion
      ..hpsOutright = hpsOutright ?? this.hpsOutright
      ..seoy = seoy ?? this.seoy
      ..onTn = onTn ?? this.onTn
      ..med = med ?? this.med
      ..mbkn = mbkn ?? this.mbkn
      ..mbhn = mbhn ?? this.mbhn
      ..mbcn = mbcn ?? this.mbcn
      ..teams = teams ?? this.teams
      ..vurl = vurl ?? this.vurl
      ..varl = varl ?? this.varl
      ..ispo = ispo ?? this.ispo
      ..mbtlp = mbtlp ?? this.mbtlp
      ..mbolp = mbolp ?? this.mbolp
      ..mbthlp = mbthlp ?? this.mbthlp
      ..lod = lod ?? this.lod
      ..batchNo = batchNo ?? this.batchNo
      ..isCollection = isCollection ?? this.isCollection
      ..isExpand = isExpand ?? this.isExpand
      ..startFlag = startFlag ?? this.startFlag
      ..homeRedScore = homeRedScore ?? this.homeRedScore
      ..awayRedScore = awayRedScore ?? this.awayRedScore
      ..homeYellowScore = homeYellowScore ?? this.homeYellowScore
      ..awayYellowScore = awayYellowScore ?? this.awayYellowScore
      ..mscListDict = mscListDict ?? this.mscListDict
      ..homeScore = homeScore ?? this.homeScore
      ..awayScore = awayScore ?? this.awayScore
      ..mscFormat = mscFormat ?? this.mscFormat
      ..mscSFormat = mscSFormat ?? this.mscSFormat;
  }
}

MatchHps $MatchHpsFromJson(Map<String, dynamic> json) {
  final MatchHps matchHps = MatchHps();
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchHps.mid = mid;
  }
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    matchHps.chpid = chpid;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    matchHps.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    matchHps.hpon = hpon;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    matchHps.hshow = hshow;
  }
  final String? hSpecial = jsonConvert.convert<String>(json['hSpecial']);
  if (hSpecial != null) {
    matchHps.hSpecial = hSpecial;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    matchHps.hpn = hpn;
  }
  final String? topKey = jsonConvert.convert<String>(json['topKey']);
  if (topKey != null) {
    matchHps.topKey = topKey;
  }
  final String? hps = jsonConvert.convert<String>(json['hps']);
  if (hps != null) {
    matchHps.hps = hps;
  }
  final dynamic jno = json['jno'];
  if (jno != null) {
    matchHps.jno = jno;
  }
  final String? hlid = jsonConvert.convert<String>(json['hlid']);
  if (hlid != null) {
    matchHps.hlid = hlid;
  }
  final String? hton = jsonConvert.convert<String>(json['hton']);
  if (hton != null) {
    matchHps.hton = hton;
  }
  final String? hpnb = jsonConvert.convert<String>(json['hpnb']);
  if (hpnb != null) {
    matchHps.hpnb = hpnb;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    matchHps.hpt = hpt;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    matchHps.hsw = hsw;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    matchHps.hmm = hmm;
  }
  final int? hids = jsonConvert.convert<int>(json['hids']);
  if (hids != null) {
    matchHps.hids = hids;
  }
  final List<MatchHpsHl>? hl = (json['hl'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHpsHl>(e) as MatchHpsHl)
      .toList();
  if (hl != null) {
    matchHps.hl = hl;
  }
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    matchHps.hid = hid;
  }
  final int? hpono = jsonConvert.convert<int>(json['hpono']);
  if (hpono != null) {
    matchHps.hpono = hpono;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    matchHps.hs = hs;
  }
  final dynamic hv = json['hv'];
  if (hv != null) {
    matchHps.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    matchHps.hmt = hmt;
  }
  final int? hn = jsonConvert.convert<int>(json['hn']);
  if (hn != null) {
    matchHps.hn = hn;
  }
  final String? hmed = jsonConvert.convert<String>(json['hmed']);
  if (hmed != null) {
    matchHps.hmed = hmed;
  }
  final String? hmgt = jsonConvert.convert<String>(json['hmgt']);
  if (hmgt != null) {
    matchHps.hmgt = hmgt;
  }
  final List<MatchHpsHlOl>? ol = (json['ol'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHpsHlOl>(e) as MatchHpsHlOl)
      .toList();
  if (ol != null) {
    matchHps.ol = ol;
  }
  return matchHps;
}

Map<String, dynamic> $MatchHpsToJson(MatchHps entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mid'] = entity.mid;
  data['chpid'] = entity.chpid;
  data['hpid'] = entity.hpid;
  data['hpon'] = entity.hpon;
  data['hshow'] = entity.hshow;
  data['hSpecial'] = entity.hSpecial;
  data['hpn'] = entity.hpn;
  data['topKey'] = entity.topKey;
  data['hps'] = entity.hps;
  data['jno'] = entity.jno;
  data['hlid'] = entity.hlid;
  data['hton'] = entity.hton;
  data['hpnb'] = entity.hpnb;
  data['hpt'] = entity.hpt;
  data['hsw'] = entity.hsw;
  data['hmm'] = entity.hmm;
  data['hids'] = entity.hids;
  data['hl'] = entity.hl.map((v) => v.toJson()).toList();
  data['hid'] = entity.hid;
  data['hpono'] = entity.hpono;
  data['hs'] = entity.hs;
  data['hv'] = entity.hv;
  data['hmt'] = entity.hmt;
  data['hn'] = entity.hn;
  data['hmed'] = entity.hmed;
  data['hmgt'] = entity.hmgt;
  data['ol'] = entity.ol.map((v) => v.toJson()).toList();
  data['title'] = entity.title;
  return data;
}

extension MatchHpsExtension on MatchHps {
  MatchHps copyWith({
    String? mid,
    String? chpid,
    String? hpid,
    int? hpon,
    String? hshow,
    String? hSpecial,
    String? hpn,
    String? topKey,
    String? hps,
    dynamic jno,
    String? hlid,
    String? hton,
    String? hpnb,
    int? hpt,
    String? hsw,
    int? hmm,
    int? hids,
    List<MatchHpsHl>? hl,
    String? hid,
    int? hpono,
    int? hs,
    dynamic hv,
    int? hmt,
    int? hn,
    String? hmed,
    String? hmgt,
    List<MatchHpsHlOl>? ol,
    List<dynamic>? title,
    int? index,
    List<BetItemCollection>? collection,
    List<BetItemCollection>? otherCollection,
  }) {
    return MatchHps()
      ..mid = mid ?? this.mid
      ..chpid = chpid ?? this.chpid
      ..hpid = hpid ?? this.hpid
      ..hpon = hpon ?? this.hpon
      ..hshow = hshow ?? this.hshow
      ..hSpecial = hSpecial ?? this.hSpecial
      ..hpn = hpn ?? this.hpn
      ..topKey = topKey ?? this.topKey
      ..hps = hps ?? this.hps
      ..jno = jno ?? this.jno
      ..hlid = hlid ?? this.hlid
      ..hton = hton ?? this.hton
      ..hpnb = hpnb ?? this.hpnb
      ..hpt = hpt ?? this.hpt
      ..hsw = hsw ?? this.hsw
      ..hmm = hmm ?? this.hmm
      ..hids = hids ?? this.hids
      ..hl = hl ?? this.hl
      ..hid = hid ?? this.hid
      ..hpono = hpono ?? this.hpono
      ..hs = hs ?? this.hs
      ..hv = hv ?? this.hv
      ..hmt = hmt ?? this.hmt
      ..hn = hn ?? this.hn
      ..hmed = hmed ?? this.hmed
      ..hmgt = hmgt ?? this.hmgt
      ..ol = ol ?? this.ol
      ..title = title ?? this.title
      ..index = index ?? this.index
      ..collection = collection ?? this.collection
      ..otherCollection = otherCollection ?? this.otherCollection;
  }
}

MatchHpsHl $MatchHpsHlFromJson(Map<String, dynamic> json) {
  final MatchHpsHl matchHpsHl = MatchHpsHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    matchHpsHl.hid = hid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    matchHpsHl.hs = hs;
  }
  final String? hv = jsonConvert.convert<String>(json['hv']);
  if (hv != null) {
    matchHpsHl.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    matchHpsHl.hmt = hmt;
  }
  final int? hn = jsonConvert.convert<int>(json['hn']);
  if (hn != null) {
    matchHpsHl.hn = hn;
  }
  final String? hon = jsonConvert.convert<String>(json['hon']);
  if (hon != null) {
    matchHpsHl.hon = hon;
  }
  final String? ad2 = jsonConvert.convert<String>(json['ad2']);
  if (ad2 != null) {
    matchHpsHl.ad2 = ad2;
  }
  final String? ad1 = jsonConvert.convert<String>(json['ad1']);
  if (ad1 != null) {
    matchHpsHl.ad1 = ad1;
  }
  final int? hipo = jsonConvert.convert<int>(json['hipo']);
  if (hipo != null) {
    matchHpsHl.hipo = hipo;
  }
  final List<MatchHpsTitle>? title = (json['title'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHpsTitle>(e) as MatchHpsTitle)
      .toList();
  if (title != null) {
    matchHpsHl.title = title;
  }
  final List<MatchHpsHlOl>? ol = (json['ol'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MatchHpsHlOl>(e) as MatchHpsHlOl)
      .toList();
  if (ol != null) {
    matchHpsHl.ol = ol;
  }
  return matchHpsHl;
}

Map<String, dynamic> $MatchHpsHlToJson(MatchHpsHl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hid'] = entity.hid;
  data['hs'] = entity.hs;
  data['hv'] = entity.hv;
  data['hmt'] = entity.hmt;
  data['hn'] = entity.hn;
  data['hon'] = entity.hon;
  data['ad2'] = entity.ad2;
  data['ad1'] = entity.ad1;
  data['hipo'] = entity.hipo;
  data['title'] = entity.title.map((v) => v.toJson()).toList();
  data['ol'] = entity.ol.map((v) => v.toJson()).toList();
  return data;
}

extension MatchHpsHlExtension on MatchHpsHl {
  MatchHpsHl copyWith({
    String? hid,
    int? hs,
    String? hv,
    int? hmt,
    int? hn,
    String? hon,
    String? ad2,
    String? ad1,
    int? hipo,
    List<MatchHpsTitle>? title,
    List<MatchHpsHlOl>? ol,
  }) {
    return MatchHpsHl()
      ..hid = hid ?? this.hid
      ..hs = hs ?? this.hs
      ..hv = hv ?? this.hv
      ..hmt = hmt ?? this.hmt
      ..hn = hn ?? this.hn
      ..hon = hon ?? this.hon
      ..ad2 = ad2 ?? this.ad2
      ..ad1 = ad1 ?? this.ad1
      ..hipo = hipo ?? this.hipo
      ..title = title ?? this.title
      ..ol = ol ?? this.ol;
  }
}

MatchHpsHlOl $MatchHpsHlOlFromJson(Map<String, dynamic> json) {
  final MatchHpsHlOl matchHpsHlOl = MatchHpsHlOl();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    matchHpsHlOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    matchHpsHlOl.os = os;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    matchHpsHlOl.otd = otd;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    matchHpsHlOl.ot = ot;
  }
  final int? ov = jsonConvert.convert<int>(json['ov']);
  if (ov != null) {
    matchHpsHlOl.ov = ov;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    matchHpsHlOl.on = on;
  }
  final String? onb = jsonConvert.convert<String>(json['onb']);
  if (onb != null) {
    matchHpsHlOl.onb = onb;
  }
  final String? onbl = jsonConvert.convert<String>(json['onbl']);
  if (onbl != null) {
    matchHpsHlOl.onbl = onbl;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matchHpsHlOl.cds = cds;
  }
  final String? ots = jsonConvert.convert<String>(json['ots']);
  if (ots != null) {
    matchHpsHlOl.ots = ots;
  }
  final String? otv = jsonConvert.convert<String>(json['otv']);
  if (otv != null) {
    matchHpsHlOl.otv = otv;
  }
  final int? obv = jsonConvert.convert<int>(json['obv']);
  if (obv != null) {
    matchHpsHlOl.obv = obv;
  }
  final String? ott = jsonConvert.convert<String>(json['ott']);
  if (ott != null) {
    matchHpsHlOl.ott = ott;
  }
  final int? oddSort = jsonConvert.convert<int>(json['oddSort']);
  if (oddSort != null) {
    matchHpsHlOl.oddSort = oddSort;
  }
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    matchHpsHlOl.result = result;
  }
  final String? teamId = jsonConvert.convert<String>(json['teamId']);
  if (teamId != null) {
    matchHpsHlOl.teamId = teamId;
  }
  final String? otn = jsonConvert.convert<String>(json['otn']);
  if (otn != null) {
    matchHpsHlOl.otn = otn;
  }
  final String? osid = jsonConvert.convert<String>(json['osid']);
  if (osid != null) {
    matchHpsHlOl.osid = osid;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    matchHpsHlOl.hpid = hpid;
  }
  final bool? isDetail = jsonConvert.convert<bool>(json['isDetail']);
  if (isDetail != null) {
    matchHpsHlOl.isDetail = isDetail;
  }
  return matchHpsHlOl;
}

Map<String, dynamic> $MatchHpsHlOlToJson(MatchHpsHlOl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['oid'] = entity.oid;
  data['os'] = entity.os;
  data['otd'] = entity.otd;
  data['ot'] = entity.ot;
  data['ov'] = entity.ov;
  data['on'] = entity.on;
  data['onb'] = entity.onb;
  data['onbl'] = entity.onbl;
  data['cds'] = entity.cds;
  data['ots'] = entity.ots;
  data['otv'] = entity.otv;
  data['obv'] = entity.obv;
  data['ott'] = entity.ott;
  data['oddSort'] = entity.oddSort;
  data['result'] = entity.result;
  data['teamId'] = entity.teamId;
  data['otn'] = entity.otn;
  data['osid'] = entity.osid;
  data['hpid'] = entity.hpid;
  data['isDetail'] = entity.isDetail;
  return data;
}

extension MatchHpsHlOlExtension on MatchHpsHlOl {
  MatchHpsHlOl copyWith({
    String? oid,
    int? os,
    int? otd,
    String? ot,
    int? ov,
    String? on,
    String? onb,
    String? onbl,
    String? cds,
    String? ots,
    String? otv,
    int? obv,
    String? ott,
    int? oddSort,
    int? result,
    String? teamId,
    String? otn,
    String? osid,
    String? hpid,
    bool? isDetail,
  }) {
    return MatchHpsHlOl()
      ..oid = oid ?? this.oid
      ..os = os ?? this.os
      ..otd = otd ?? this.otd
      ..ot = ot ?? this.ot
      ..ov = ov ?? this.ov
      ..on = on ?? this.on
      ..onb = onb ?? this.onb
      ..onbl = onbl ?? this.onbl
      ..cds = cds ?? this.cds
      ..ots = ots ?? this.ots
      ..otv = otv ?? this.otv
      ..obv = obv ?? this.obv
      ..ott = ott ?? this.ott
      ..oddSort = oddSort ?? this.oddSort
      ..result = result ?? this.result
      ..teamId = teamId ?? this.teamId
      ..otn = otn ?? this.otn
      ..osid = osid ?? this.osid
      ..hpid = hpid ?? this.hpid
      ..isDetail = isDetail ?? this.isDetail;
  }
}

MatchHpsTitle $MatchHpsTitleFromJson(Map<String, dynamic> json) {
  final MatchHpsTitle matchHpsTitle = MatchHpsTitle();
  final String? osn = jsonConvert.convert<String>(json['osn']);
  if (osn != null) {
    matchHpsTitle.osn = osn;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    matchHpsTitle.otd = otd;
  }
  return matchHpsTitle;
}

Map<String, dynamic> $MatchHpsTitleToJson(MatchHpsTitle entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['osn'] = entity.osn;
  data['otd'] = entity.otd;
  return data;
}

extension MatchHpsTitleExtension on MatchHpsTitle {
  MatchHpsTitle copyWith({
    String? osn,
    int? otd,
  }) {
    return MatchHpsTitle()
      ..osn = osn ?? this.osn
      ..otd = otd ?? this.otd;
  }
}
