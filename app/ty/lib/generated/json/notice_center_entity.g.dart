import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/notice_center_entity.dart';

NoticeCenterEntity $NoticeCenterEntityFromJson(Map<String, dynamic> json) {
  final NoticeCenterEntity noticeCenterEntity = NoticeCenterEntity();
  final List<NoticeCenterNb>? nb = (json['nb'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<NoticeCenterNb>(e) as NoticeCenterNb)
      .toList();
  if (nb != null) {
    noticeCenterEntity.nb = nb;
  }
  final List<NoticeCenterNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<NoticeCenterNt>(e) as NoticeCenterNt)
      .toList();
  if (nt != null) {
    noticeCenterEntity.nt = nt;
  }
  final List<NoticeCenterNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<NoticeCenterNl>(e) as NoticeCenterNl)
      .toList();
  if (nl != null) {
    noticeCenterEntity.nl = nl;
  }
  return noticeCenterEntity;
}

Map<String, dynamic> $NoticeCenterEntityToJson(NoticeCenterEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension NoticeCenterEntityExtension on NoticeCenterEntity {
  NoticeCenterEntity copyWith({
    List<NoticeCenterNb>? nb,
    List<NoticeCenterNt>? nt,
    List<NoticeCenterNl>? nl,
  }) {
    return NoticeCenterEntity()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

NoticeCenterNb $NoticeCenterNbFromJson(Map<String, dynamic> json) {
  final NoticeCenterNb noticeCenterNb = NoticeCenterNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    noticeCenterNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeCenterNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    noticeCenterNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    noticeCenterNb.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    noticeCenterNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    noticeCenterNb.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    noticeCenterNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    noticeCenterNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    noticeCenterNb.title = title;
  }
  return noticeCenterNb;
}

Map<String, dynamic> $NoticeCenterNbToJson(NoticeCenterNb entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['context'] = entity.context;
  data['id'] = entity.id;
  data['isShuf'] = entity.isShuf;
  data['isTop'] = entity.isTop;
  data['noticeType'] = entity.noticeType;
  data['noticeTypeName'] = entity.noticeTypeName;
  data['sendTime'] = entity.sendTime;
  data['sendTimeOther'] = entity.sendTimeOther;
  data['title'] = entity.title;
  return data;
}

extension NoticeCenterNbExtension on NoticeCenterNb {
  NoticeCenterNb copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    int? noticeType,
    String? noticeTypeName,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return NoticeCenterNb()
      ..context = context ?? this.context
      ..id = id ?? this.id
      ..isShuf = isShuf ?? this.isShuf
      ..isTop = isTop ?? this.isTop
      ..noticeType = noticeType ?? this.noticeType
      ..noticeTypeName = noticeTypeName ?? this.noticeTypeName
      ..sendTime = sendTime ?? this.sendTime
      ..sendTimeOther = sendTimeOther ?? this.sendTimeOther
      ..title = title ?? this.title;
  }
}

NoticeCenterNt $NoticeCenterNtFromJson(Map<String, dynamic> json) {
  final NoticeCenterNt noticeCenterNt = NoticeCenterNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    noticeCenterNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    noticeCenterNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    noticeCenterNt.type = type;
  }
  return noticeCenterNt;
}

Map<String, dynamic> $NoticeCenterNtToJson(NoticeCenterNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension NoticeCenterNtExtension on NoticeCenterNt {
  NoticeCenterNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return NoticeCenterNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

NoticeCenterNl $NoticeCenterNlFromJson(Map<String, dynamic> json) {
  final NoticeCenterNl noticeCenterNl = NoticeCenterNl();
  final List<NoticeCenterNlMtl>? mtl = (json['mtl'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<NoticeCenterNlMtl>(e) as NoticeCenterNlMtl)
      .toList();
  if (mtl != null) {
    noticeCenterNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    noticeCenterNl.nen = nen;
  }
  final int? net = jsonConvert.convert<int>(json['net']);
  if (net != null) {
    noticeCenterNl.net = net;
  }
  return noticeCenterNl;
}

Map<String, dynamic> $NoticeCenterNlToJson(NoticeCenterNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension NoticeCenterNlExtension on NoticeCenterNl {
  NoticeCenterNl copyWith({
    List<NoticeCenterNlMtl>? mtl,
    String? nen,
    int? net,
  }) {
    return NoticeCenterNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

NoticeCenterNlMtl $NoticeCenterNlMtlFromJson(Map<String, dynamic> json) {
  final NoticeCenterNlMtl noticeCenterNlMtl = NoticeCenterNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    noticeCenterNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeCenterNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    noticeCenterNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    noticeCenterNlMtl.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    noticeCenterNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    noticeCenterNlMtl.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    noticeCenterNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    noticeCenterNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    noticeCenterNlMtl.title = title;
  }
  return noticeCenterNlMtl;
}

Map<String, dynamic> $NoticeCenterNlMtlToJson(NoticeCenterNlMtl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['context'] = entity.context;
  data['id'] = entity.id;
  data['isShuf'] = entity.isShuf;
  data['isTop'] = entity.isTop;
  data['noticeType'] = entity.noticeType;
  data['noticeTypeName'] = entity.noticeTypeName;
  data['sendTime'] = entity.sendTime;
  data['sendTimeOther'] = entity.sendTimeOther;
  data['title'] = entity.title;
  return data;
}

extension NoticeCenterNlMtlExtension on NoticeCenterNlMtl {
  NoticeCenterNlMtl copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    int? noticeType,
    String? noticeTypeName,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return NoticeCenterNlMtl()
      ..context = context ?? this.context
      ..id = id ?? this.id
      ..isShuf = isShuf ?? this.isShuf
      ..isTop = isTop ?? this.isTop
      ..noticeType = noticeType ?? this.noticeType
      ..noticeTypeName = noticeTypeName ?? this.noticeTypeName
      ..sendTime = sendTime ?? this.sendTime
      ..sendTimeOther = sendTimeOther ?? this.sendTimeOther
      ..title = title ?? this.title;
  }
}