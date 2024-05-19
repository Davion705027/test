import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/req/collection_req.dart';

CollectionReq $CollectionReqFromJson(Map<String, dynamic> json) {
  final CollectionReq collectionReq = CollectionReq();
  final String? cuid = jsonConvert.convert<String>(json['cuid']);
  if (cuid != null) {
    collectionReq.cuid = cuid;
  }
  final String? euid = jsonConvert.convert<String>(json['euid']);
  if (euid != null) {
    collectionReq.euid = euid;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    collectionReq.type = type;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    collectionReq.sort = sort;
  }
  final String? device = jsonConvert.convert<String>(json['device']);
  if (device != null) {
    collectionReq.device = device;
  }
  return collectionReq;
}

Map<String, dynamic> $CollectionReqToJson(CollectionReq entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['cuid'] = entity.cuid;
  data['euid'] = entity.euid;
  data['type'] = entity.type;
  data['sort'] = entity.sort;
  data['device'] = entity.device;
  return data;
}

extension CollectionReqExtension on CollectionReq {
  CollectionReq copyWith({
    String? cuid,
    String? euid,
    int? type,
    int? sort,
    String? device,
  }) {
    return CollectionReq()
      ..cuid = cuid ?? this.cuid
      ..euid = euid ?? this.euid
      ..type = type ?? this.type
      ..sort = sort ?? this.sort
      ..device = device ?? this.device;
  }
}