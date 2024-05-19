import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/sport_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/sport_entity.g.dart';

@JsonSerializable()
class SportEntity {
  late String csid = '';
  late String csna = '';

  SportEntity();

  factory SportEntity.fromJson(Map<String, dynamic> json) =>
      $SportEntityFromJson(json);

  Map<String, dynamic> toJson() => $SportEntityToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SportEntity &&
          runtimeType == other.runtimeType &&
          csid == other.csid &&
          csna == other.csna;

  @override
  int get hashCode => csid.hashCode ^ csna.hashCode;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
