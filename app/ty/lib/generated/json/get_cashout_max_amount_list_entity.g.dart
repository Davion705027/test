import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_cashout_max_amount_list_entity.dart';

GetCashoutMaxAmountListEntity $GetCashoutMaxAmountListEntityFromJson(
    Map<String, dynamic> json) {
  final GetCashoutMaxAmountListEntity getCashoutMaxAmountListEntity = GetCashoutMaxAmountListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getCashoutMaxAmountListEntity.code = code;
  }
  final List<GetCashoutMaxAmountListData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetCashoutMaxAmountListData>(
          e) as GetCashoutMaxAmountListData).toList();
  if (data != null) {
    getCashoutMaxAmountListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getCashoutMaxAmountListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getCashoutMaxAmountListEntity.ts = ts;
  }
  return getCashoutMaxAmountListEntity;
}

Map<String, dynamic> $GetCashoutMaxAmountListEntityToJson(
    GetCashoutMaxAmountListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetCashoutMaxAmountListEntityExtension on GetCashoutMaxAmountListEntity {
  GetCashoutMaxAmountListEntity copyWith({
    String? code,
    List<GetCashoutMaxAmountListData>? data,
    String? msg,
    int? ts,
  }) {
    return GetCashoutMaxAmountListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetCashoutMaxAmountListData $GetCashoutMaxAmountListDataFromJson(
    Map<String, dynamic> json) {
  final GetCashoutMaxAmountListData getCashoutMaxAmountListData = GetCashoutMaxAmountListData();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getCashoutMaxAmountListData.betAmount = betAmount;
  }
  final double? csper = jsonConvert.convert<double>(json['csper']);
  if (csper != null) {
    getCashoutMaxAmountListData.csper = csper;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getCashoutMaxAmountListData.orderNo = orderNo;
  }
  final int? orderStatus = jsonConvert.convert<int>(json['orderStatus']);
  if (orderStatus != null) {
    getCashoutMaxAmountListData.orderStatus = orderStatus;
  }
  final dynamic preBetAmount = json['preBetAmount'];
  if (preBetAmount != null) {
    getCashoutMaxAmountListData.preBetAmount = preBetAmount;
  }
  final double? preSettleMaxWin = jsonConvert.convert<double>(
      json['preSettleMaxWin']);
  if (preSettleMaxWin != null) {
    getCashoutMaxAmountListData.preSettleMaxWin = preSettleMaxWin;
  }
  return getCashoutMaxAmountListData;
}

Map<String, dynamic> $GetCashoutMaxAmountListDataToJson(
    GetCashoutMaxAmountListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['csper'] = entity.csper;
  data['orderNo'] = entity.orderNo;
  data['orderStatus'] = entity.orderStatus;
  data['preBetAmount'] = entity.preBetAmount;
  data['preSettleMaxWin'] = entity.preSettleMaxWin;
  return data;
}

extension GetCashoutMaxAmountListDataExtension on GetCashoutMaxAmountListData {
  GetCashoutMaxAmountListData copyWith({
    double? betAmount,
    double? csper,
    String? orderNo,
    int? orderStatus,
    dynamic preBetAmount,
    double? preSettleMaxWin,
  }) {
    return GetCashoutMaxAmountListData()
      ..betAmount = betAmount ?? this.betAmount
      ..csper = csper ?? this.csper
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatus = orderStatus ?? this.orderStatus
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..preSettleMaxWin = preSettleMaxWin ?? this.preSettleMaxWin;
  }
}