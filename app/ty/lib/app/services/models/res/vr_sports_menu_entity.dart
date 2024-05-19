import 'dart:convert';

import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/vr_sports_menu_entity.g.dart';

export 'package:flutter_ty_app/generated/json/vr_sports_menu_entity.g.dart';

@JsonSerializable()
class VrSportsMenuEntity {
  dynamic count;
  late String field1 = '';
  late String field2 = '';
  late String field3 = '';
  late String field4 = '';
  late String menuId = '';
  dynamic menuType;
  late String name = '';
  late List<VrSportsMenuEntity> subList = [];

  int get type {
    switch (menuId) {
      case '1001':
        return 1;
      case '1004':
        return 2;
      case '1011':
        return 3;
      case '1002':
        return 4;
      case '1010':
        return 5;
      case '1009':
        return 6;
    }
    return 1;
  }

  VrSportsMenuEntity();

  factory VrSportsMenuEntity.fromJson(Map<String, dynamic> json) =>
      $VrSportsMenuEntityFromJson(json);

  Map<String, dynamic> toJson() => $VrSportsMenuEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
