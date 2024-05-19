import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/category_list_entity.dart';

CategoryListEntity $CategoryListEntityFromJson(Map<String, dynamic> json) {
  final CategoryListEntity categoryListEntity = CategoryListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    categoryListEntity.code = code;
  }
  final List<CategoryListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<CategoryListData>(e) as CategoryListData)
      .toList();
  if (data != null) {
    categoryListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    categoryListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    categoryListEntity.ts = ts;
  }
  return categoryListEntity;
}

Map<String, dynamic> $CategoryListEntityToJson(CategoryListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension CategoryListEntityExtension on CategoryListEntity {
  CategoryListEntity copyWith({
    String? code,
    List<CategoryListData>? data,
    String? msg,
    int? ts,
  }) {
    return CategoryListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

CategoryListData $CategoryListDataFromJson(Map<String, dynamic> json) {
  final CategoryListData categoryListData = CategoryListData();
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    categoryListData.marketName = marketName;
  }
  final int? orderNo = jsonConvert.convert<int>(json['orderNo']);
  if (orderNo != null) {
    categoryListData.orderNo = orderNo;
  }
  final List<int>? plays = (json['plays'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (plays != null) {
    categoryListData.plays = plays;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    categoryListData.id = id;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    categoryListData.label = label;
  }
  final int? round = jsonConvert.convert<int>(json['round']);
  if (round != null) {
    categoryListData.round = round;
  }
  return categoryListData;
}

Map<String, dynamic> $CategoryListDataToJson(CategoryListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['marketName'] = entity.marketName;
  data['orderNo'] = entity.orderNo;
  data['plays'] = entity.plays;
  data['id'] = entity.id;
  data['label'] = entity.label;
  data['round'] = entity.round;
  return data;
}

extension CategoryListDataExtension on CategoryListData {
  CategoryListData copyWith({
    String? marketName,
    int? orderNo,
    List<int>? plays,
    String? id,
    String? label,
    int? round,
  }) {
    return CategoryListData()
      ..marketName = marketName ?? this.marketName
      ..orderNo = orderNo ?? this.orderNo
      ..plays = plays ?? this.plays
      ..id = id ?? this.id
      ..label = label ?? this.label
      ..round = round ?? this.round;
  }
}