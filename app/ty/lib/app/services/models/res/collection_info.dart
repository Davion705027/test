import 'dart:convert';

import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/collection_info.g.dart';

export 'package:flutter_ty_app/generated/json/collection_info.g.dart';

@JsonSerializable()
class CollectionInfo {
  late List<String> tids = [];
  late List<String> mids = [];

  // List<CollectionInfoExclude>? exclude;

  CollectionInfo();

  factory CollectionInfo.fromJson(Map<String, dynamic> json) =>
      $CollectionInfoFromJson(json);

  Map<String, dynamic> toJson() => $CollectionInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionInfoExclude {
  late String tids = '';
  late List<String> mids = [];

  CollectionInfoExclude();

  factory CollectionInfoExclude.fromJson(Map<String, dynamic> json) =>
      $CollectionInfoExcludeFromJson(json);

  Map<String, dynamic> toJson() => $CollectionInfoExcludeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
