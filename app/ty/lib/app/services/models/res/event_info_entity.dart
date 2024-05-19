import 'dart:convert';

import 'package:flutter_ty_app/generated/json/base/json_field.dart';

import '../../../../generated/json/event_info_entity.g.dart';

@JsonSerializable()
class EventInfo2Entity {
  late String code;
  late List<EventInfo2Data> data;
  late String msg;
  late int ts;

  EventInfo2Entity();

  factory EventInfo2Entity.fromJson(Map<String, dynamic> json) =>
      $EventInfo2EntityFromJson(json);

  Map<String, dynamic> toJson() => $EventInfo2EntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class EventInfo2Data {
  late String ad;
  late String de;
  late String en;
  late String es;
  late String fr;
  late String it;
  late String ja;
  late String jc;
  late String jp;
  late String ko;
  late String lan1;
  late String ms;
  late String mya;
  late String nameCode;
  late String other;
  late String pt;
  late String ru;
  late String th;
  late String tw;
  late String updateTime;
  late String vi;
  late String zh;
  late String zs;

  EventInfo2Data();

  factory EventInfo2Data.fromJson(Map<String, dynamic> json) =>
      $EventInfo2DataFromJson(json);

  Map<String, dynamic> toJson() => $EventInfo2DataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
