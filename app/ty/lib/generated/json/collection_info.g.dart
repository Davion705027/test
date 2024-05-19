import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/collection_info.dart';

CollectionInfo $CollectionInfoFromJson(Map<String, dynamic> json) {
  final CollectionInfo collectionInfo = CollectionInfo();
  final List<String>? tids = (json['tids'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (tids != null) {
    collectionInfo.tids = tids;
  }
  final List<String>? mids = (json['mids'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mids != null) {
    collectionInfo.mids = mids;
  }
  return collectionInfo;
}

Map<String, dynamic> $CollectionInfoToJson(CollectionInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tids'] = entity.tids;
  data['mids'] = entity.mids;
  return data;
}

extension CollectionInfoExtension on CollectionInfo {
  CollectionInfo copyWith({
    List<String>? tids,
    List<String>? mids,
  }) {
    return CollectionInfo()
      ..tids = tids ?? this.tids
      ..mids = mids ?? this.mids;
  }
}

CollectionInfoExclude $CollectionInfoExcludeFromJson(
    Map<String, dynamic> json) {
  final CollectionInfoExclude collectionInfoExclude = CollectionInfoExclude();
  final String? tids = jsonConvert.convert<String>(json['tids']);
  if (tids != null) {
    collectionInfoExclude.tids = tids;
  }
  final List<String>? mids = (json['mids'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mids != null) {
    collectionInfoExclude.mids = mids;
  }
  return collectionInfoExclude;
}

Map<String, dynamic> $CollectionInfoExcludeToJson(
    CollectionInfoExclude entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tids'] = entity.tids;
  data['mids'] = entity.mids;
  return data;
}

extension CollectionInfoExcludeExtension on CollectionInfoExclude {
  CollectionInfoExclude copyWith({
    String? tids,
    List<String>? mids,
  }) {
    return CollectionInfoExclude()
      ..tids = tids ?? this.tids
      ..mids = mids ?? this.mids;
  }
}