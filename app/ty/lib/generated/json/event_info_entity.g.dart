import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/event_info_entity.dart';

EventInfo2Entity $EventInfo2EntityFromJson(Map<String, dynamic> json) {
  final EventInfo2Entity eventInfo2Entity = EventInfo2Entity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    eventInfo2Entity.code = code;
  }
  final List<EventInfo2Data>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<EventInfo2Data>(e) as EventInfo2Data)
      .toList();
  if (data != null) {
    eventInfo2Entity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    eventInfo2Entity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    eventInfo2Entity.ts = ts;
  }
  return eventInfo2Entity;
}

Map<String, dynamic> $EventInfo2EntityToJson(EventInfo2Entity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension EventInfo2EntityExtension on EventInfo2Entity {
  EventInfo2Entity copyWith({
    String? code,
    List<EventInfo2Data>? data,
    String? msg,
    int? ts,
  }) {
    return EventInfo2Entity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

EventInfo2Data $EventInfo2DataFromJson(Map<String, dynamic> json) {
  final EventInfo2Data eventInfo2Data = EventInfo2Data();
  final String? ad = jsonConvert.convert<String>(json['ad']);
  if (ad != null) {
    eventInfo2Data.ad = ad;
  }
  final String? de = jsonConvert.convert<String>(json['de']);
  if (de != null) {
    eventInfo2Data.de = de;
  }
  final String? en = jsonConvert.convert<String>(json['en']);
  if (en != null) {
    eventInfo2Data.en = en;
  }
  final String? es = jsonConvert.convert<String>(json['es']);
  if (es != null) {
    eventInfo2Data.es = es;
  }
  final String? fr = jsonConvert.convert<String>(json['fr']);
  if (fr != null) {
    eventInfo2Data.fr = fr;
  }
  final String? it = jsonConvert.convert<String>(json['it']);
  if (it != null) {
    eventInfo2Data.it = it;
  }
  final String? ja = jsonConvert.convert<String>(json['ja']);
  if (ja != null) {
    eventInfo2Data.ja = ja;
  }
  final String? jc = jsonConvert.convert<String>(json['jc']);
  if (jc != null) {
    eventInfo2Data.jc = jc;
  }
  final String? jp = jsonConvert.convert<String>(json['jp']);
  if (jp != null) {
    eventInfo2Data.jp = jp;
  }
  final String? ko = jsonConvert.convert<String>(json['ko']);
  if (ko != null) {
    eventInfo2Data.ko = ko;
  }
  final String? lan1 = jsonConvert.convert<String>(json['lan1']);
  if (lan1 != null) {
    eventInfo2Data.lan1 = lan1;
  }
  final String? ms = jsonConvert.convert<String>(json['ms']);
  if (ms != null) {
    eventInfo2Data.ms = ms;
  }
  final String? mya = jsonConvert.convert<String>(json['mya']);
  if (mya != null) {
    eventInfo2Data.mya = mya;
  }
  final String? nameCode = jsonConvert.convert<String>(json['nameCode']);
  if (nameCode != null) {
    eventInfo2Data.nameCode = nameCode;
  }
  final String? other = jsonConvert.convert<String>(json['other']);
  if (other != null) {
    eventInfo2Data.other = other;
  }
  final String? pt = jsonConvert.convert<String>(json['pt']);
  if (pt != null) {
    eventInfo2Data.pt = pt;
  }
  final String? ru = jsonConvert.convert<String>(json['ru']);
  if (ru != null) {
    eventInfo2Data.ru = ru;
  }
  final String? th = jsonConvert.convert<String>(json['th']);
  if (th != null) {
    eventInfo2Data.th = th;
  }
  final String? tw = jsonConvert.convert<String>(json['tw']);
  if (tw != null) {
    eventInfo2Data.tw = tw;
  }
  final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
  if (updateTime != null) {
    eventInfo2Data.updateTime = updateTime;
  }
  final String? vi = jsonConvert.convert<String>(json['vi']);
  if (vi != null) {
    eventInfo2Data.vi = vi;
  }
  final String? zh = jsonConvert.convert<String>(json['zh']);
  if (zh != null) {
    eventInfo2Data.zh = zh;
  }
  final String? zs = jsonConvert.convert<String>(json['zs']);
  if (zs != null) {
    eventInfo2Data.zs = zs;
  }
  return eventInfo2Data;
}

Map<String, dynamic> $EventInfo2DataToJson(EventInfo2Data entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ad'] = entity.ad;
  data['de'] = entity.de;
  data['en'] = entity.en;
  data['es'] = entity.es;
  data['fr'] = entity.fr;
  data['it'] = entity.it;
  data['ja'] = entity.ja;
  data['jc'] = entity.jc;
  data['jp'] = entity.jp;
  data['ko'] = entity.ko;
  data['lan1'] = entity.lan1;
  data['ms'] = entity.ms;
  data['mya'] = entity.mya;
  data['nameCode'] = entity.nameCode;
  data['other'] = entity.other;
  data['pt'] = entity.pt;
  data['ru'] = entity.ru;
  data['th'] = entity.th;
  data['tw'] = entity.tw;
  data['updateTime'] = entity.updateTime;
  data['vi'] = entity.vi;
  data['zh'] = entity.zh;
  data['zs'] = entity.zs;
  return data;
}

extension EventInfo2DataExtension on EventInfo2Data {
  EventInfo2Data copyWith({
    String? ad,
    String? de,
    String? en,
    String? es,
    String? fr,
    String? it,
    String? ja,
    String? jc,
    String? jp,
    String? ko,
    String? lan1,
    String? ms,
    String? mya,
    String? nameCode,
    String? other,
    String? pt,
    String? ru,
    String? th,
    String? tw,
    String? updateTime,
    String? vi,
    String? zh,
    String? zs,
  }) {
    return EventInfo2Data()
      ..ad = ad ?? this.ad
      ..de = de ?? this.de
      ..en = en ?? this.en
      ..es = es ?? this.es
      ..fr = fr ?? this.fr
      ..it = it ?? this.it
      ..ja = ja ?? this.ja
      ..jc = jc ?? this.jc
      ..jp = jp ?? this.jp
      ..ko = ko ?? this.ko
      ..lan1 = lan1 ?? this.lan1
      ..ms = ms ?? this.ms
      ..mya = mya ?? this.mya
      ..nameCode = nameCode ?? this.nameCode
      ..other = other ?? this.other
      ..pt = pt ?? this.pt
      ..ru = ru ?? this.ru
      ..th = th ?? this.th
      ..tw = tw ?? this.tw
      ..updateTime = updateTime ?? this.updateTime
      ..vi = vi ?? this.vi
      ..zh = zh ?? this.zh
      ..zs = zs ?? this.zs;
  }
}